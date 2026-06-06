const axios  = require('axios');
const prisma = require('../config/prisma');

const COUNTRY_DATA = {
  'USA':         { name: 'United States',  continent: 'America',  code: 'NY'  },
  'UK':          { name: 'United Kingdom', continent: 'Europe',   code: 'LON' },
  'Germany':     { name: 'Germany',        continent: 'Europe',   code: 'BER' },
  'France':      { name: 'France',         continent: 'Europe',   code: 'PAR' },
  'Netherlands': { name: 'Netherlands',    continent: 'Europe',   code: 'AMS' },
  'Spain':       { name: 'Spain',          continent: 'Europe',   code: 'MAD' },
  'Portugal':    { name: 'Portugal',       continent: 'Europe',   code: 'LIS' },
  'Canada':      { name: 'Canada',         continent: 'America',  code: 'TOR' },
  'Australia':   { name: 'Australia',      continent: 'Oceania',  code: 'SYD' },
  'Remote':      { name: 'Remote',         continent: 'Global',   code: 'REM' },
};

function detectCountry(location = '') {
  const l = location.toLowerCase();
  if (l.includes('germany')     || l.includes('berlin'))      return 'Germany';
  if (l.includes('france')      || l.includes('paris'))       return 'France';
  if (l.includes('netherlands') || l.includes('amsterdam'))   return 'Netherlands';
  if (l.includes('spain')       || l.includes('madrid'))      return 'Spain';
  if (l.includes('portugal')    || l.includes('lisbon'))      return 'Portugal';
  if (l.includes('uk')          || l.includes('london'))      return 'UK';
  if (l.includes('canada'))                                    return 'Canada';
  if (l.includes('australia'))                                 return 'Australia';
  if (l.includes('usa') || l.includes('united states') || l.includes('new york')) return 'USA';
  return 'Remote';
}

function extractCity(location = '') {
  if (!location || ['worldwide','remote','anywhere'].includes(location.toLowerCase())) {
    return { name: 'Remote', code: 'REM' };
  }
  const cityName = location.split(/[,\/]/)[0].trim() || 'Remote';
  return { name: cityName, code: cityName.substring(0, 3).toUpperCase() };
}

function stripHtml(html = '') {
  return html
    .replace(/<[^>]*>/g, ' ')
    .replace(/&amp;/g,'&').replace(/&lt;/g,'<').replace(/&gt;/g,'>').replace(/&quot;/g,'"').replace(/&#39;/g,"'")
    .replace(/\s+/g, ' ').trim().substring(0, 500);
}

async function upsertCountry(key) {
  const d = COUNTRY_DATA[key] || COUNTRY_DATA['Remote'];
  return prisma.country.upsert({
    where:  { name: d.name },
    update: {},
    create: { name: d.name, continent: d.continent, code: d.code },
  });
}

async function upsertCity(cityInfo, countryId) {
  const existing = await prisma.city.findFirst({ where: { name: cityInfo.name, countryId } });
  if (existing) return existing;
  return prisma.city.create({ data: { name: cityInfo.name, code: cityInfo.code, countryId } });
}

async function upsertCompany(name, cityId) {
  const existing = await prisma.company.findFirst({ where: { name } });
  if (existing) return existing;
  return prisma.company.create({ data: { name, cityId } });
}

// ─── Fuente 1: RemoteOK ──────────────────────────────────────────────────────
// API pública JSON — devuelve ~100 ofertas con id único por oferta
async function fetchRemoteOK() {
  try {
    const { data } = await axios.get('https://remoteok.com/api', {
      headers: { 'User-Agent': 'NovaCasa Job Portal/1.0', 'Accept': 'application/json' },
      timeout: 15000,
    });
    const jobs = data.slice(1); // primer elemento es metadata
    console.log(`[scrapeJobs] RemoteOK: ${jobs.length} ofertas recibidas`);
    return jobs
      .filter(j => j.company && j.position)
      .map(j => ({
        externalId:  `ROK-${j.id || j.slug}`,
        title:       j.position,
        company:     j.company,
        location:    j.location || 'Remote',
        description: stripHtml(j.description) || j.position,
        tags:        Array.isArray(j.tags) ? j.tags : [],
        salary:      j.salary_min ? parseFloat(j.salary_min) : null,
        jobType:     j.job_type || 'full_time',
      }));
  } catch (err) {
    console.warn(`[scrapeJobs] RemoteOK no accesible: ${err.message}`);
    return [];
  }
}

// ─── Fuente 2: Remotive ──────────────────────────────────────────────────────
// API pública JSON — devuelve ~28 ofertas con id único por oferta
async function fetchRemotive() {
  try {
    const { data } = await axios.get('https://remotive.com/api/remote-jobs', {
      headers: { 'User-Agent': 'NovaCasa Job Portal/1.0', 'Accept': 'application/json' },
      timeout: 15000,
    });
    const jobs = data.jobs || [];
    console.log(`[scrapeJobs] Remotive: ${jobs.length} ofertas recibidas`);
    return jobs
      .filter(j => j.company_name && j.title)
      .map(j => ({
        externalId:  `RMT-${j.id}`,
        title:       j.title,
        company:     j.company_name,
        location:    j.candidate_required_location || 'Remote',
        description: stripHtml(j.description) || j.title,
        tags:        Array.isArray(j.tags) ? j.tags : [j.category].filter(Boolean),
        salary:      parseSalary(j.salary),
        jobType:     j.job_type || 'full_time',
      }));
  } catch (err) {
    console.warn(`[scrapeJobs] Remotive no accesible: ${err.message}`);
    return [];
  }
}

// Parsea el campo salary de Remotive que viene como string: "$50-$75 /hour"
function parseSalary(raw) {
  if (!raw) return null;
  const match = String(raw).match(/\d[\d,]*/);
  if (!match) return null;
  return parseFloat(match[0].replace(/,/g, ''));
}

// ─── Función principal ───────────────────────────────────────────────────────
async function scrapeJobs() {
  console.log('[scrapeJobs] Iniciando scraping de empleos...');

  const [remoteOKJobs, remotiveJobs] = await Promise.all([fetchRemoteOK(), fetchRemotive()]);
  const allJobs = [...remoteOKJobs, ...remotiveJobs];
  console.log(`[scrapeJobs] Total a procesar: ${allJobs.length} ofertas`);

  let insertados = 0;
  let omitidos   = 0;

  for (const job of allJobs) {
    try {
      const countryKey = detectCountry(job.location);
      const cityInfo   = extractCity(job.location);

      const country = await upsertCountry(countryKey);
      const city    = await upsertCity(cityInfo, country.id);
      const company = await upsertCompany(job.company, city.id);

      // Deduplicación por externalId guardado en requirements
      const exists = await prisma.jobOffer.findFirst({
        where: { requirements: { startsWith: `[${job.externalId}]` } },
      });
      if (exists) { omitidos++; continue; }

      const tags       = job.tags.slice(0, 5);
      const workSector = tags[0] || 'Technology';
      const isRemote   = job.location.toLowerCase().includes('remote')
                      || job.location.toLowerCase().includes('worldwide')
                      || job.location.toLowerCase().includes('anywhere');

      await prisma.jobOffer.create({
        data: {
          title:          job.title,
          description:    job.description,
          companyId:      company.id,
          countryId:      country.id,
          cityId:         city.id,
          contract:       job.jobType === 'full_time' ? 'Full-time'
                        : job.jobType === 'part_time' ? 'Part-time'
                        : job.jobType === 'freelance' ? 'Freelance'
                        : 'Full-time',
          timestampStart: new Date(),
          experience:     'Not specified',
          // El externalId al inicio permite buscarlo de forma eficiente
          requirements:   `[${job.externalId}] ${tags.join(', ')}`,
          workSector,
          workday:        isRemote ? 'Remote' : 'On-site',
          salary:         job.salary,
        },
      });
      insertados++;
    } catch (err) {
      console.error(`[scrapeJobs] Error en "${job.title}":`, err.message);
      omitidos++;
    }
  }

  console.log(`[scrapeJobs] Finalizado — insertados: ${insertados}, omitidos: ${omitidos}`);
  return { insertados, omitidos, total: allJobs.length };
}

// Elimina todas las ofertas scrapeadas (las que tienen externalId en requirements)
async function clearScrapedJobs() {
  const deleted = await prisma.jobOffer.deleteMany({
    where: {
      OR: [
        { requirements: { startsWith: '[ROK-' } },
        { requirements: { startsWith: '[RMT-' } },
      ],
    },
  });
  console.log(`[scrapeJobs] ${deleted.count} ofertas eliminadas`);
  return deleted.count;
}

module.exports = { scrapeJobs, clearScrapedJobs };
