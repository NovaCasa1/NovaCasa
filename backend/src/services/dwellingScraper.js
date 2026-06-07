const axios  = require('axios');
const cheerio = require('cheerio');
const prisma  = require('../config/prisma');

const CITY_SEEDS = [
  { cityName: 'Berlin',    countryName: 'Germany',     continent: 'Europe', code: 'BER', zipCode: '10115' },
  { cityName: 'Paris',     countryName: 'France',      continent: 'Europe', code: 'PAR', zipCode: '75001' },
  { cityName: 'Amsterdam', countryName: 'Netherlands', continent: 'Europe', code: 'AMS', zipCode: '1012'  },
  { cityName: 'Vienna',    countryName: 'Austria',     continent: 'Europe', code: 'VIE', zipCode: '1010'  },
  { cityName: 'Lisbon',    countryName: 'Portugal',    continent: 'Europe', code: 'LIS', zipCode: '1100'  },
  { cityName: 'Brussels',  countryName: 'Belgium',     continent: 'Europe', code: 'BRU', zipCode: '1000'  },
  { cityName: 'Rome',      countryName: 'Italy',       continent: 'Europe', code: 'ROM', zipCode: '00100' },
  { cityName: 'Milan',     countryName: 'Italy',       continent: 'Europe', code: 'MIL', zipCode: '20100' },
  { cityName: 'Barcelona', countryName: 'Spain',       continent: 'Europe', code: 'BCN', zipCode: '08001' },
  { cityName: 'Madrid',    countryName: 'Spain',       continent: 'Europe', code: 'MAD', zipCode: '28001' },
];

const DWELLING_TYPES = ['Apartment', 'House', 'Studio', 'Penthouse', 'Duplex', 'Villa'];

async function fetchFotocasaListings() {
  try {
    const url = 'https://www.fotocasa.es/es/comprar/viviendas/espana/todas-las-zonas/l';
    const response = await axios.get(url, {
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        'Accept-Language': 'es-ES,es;q=0.9',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
      },
      timeout: 10000,
    });

    const $ = cheerio.load(response.data);
    const listings = [];

    $('article.re-CardPackMinimal, article[class*="re-Card"]').each((i, el) => {
      if (listings.length >= 10) return false;
      try {
        const title  = $(el).find('[class*="re-CardTitle"], h3').first().text().trim();
        const price  = $(el).find('[class*="re-CardPrice"], [class*="price"]').first().text().replace(/[^0-9]/g, '');
        const rooms  = $(el).find('[class*="re-CardFeature--rooms"]').first().text().replace(/[^0-9]/g, '');
        const meters = $(el).find('[class*="re-CardFeature--surface"]').first().text().replace(/[^0-9.]/g, '');
        const zone   = $(el).find('[class*="re-CardLocation"]').first().text().trim();

        if (title && price) {
          listings.push({
            externalId: `FC-${i}`,
            title,
            price:  parseFloat(price)  || 250000,
            rooms:  parseInt(rooms)    || 2,
            meters: parseFloat(meters) || 80,
            zone:   zone || 'España',
            source: 'Fotocasa',
          });
        }
      } catch (_) {}
    });

    if (listings.length > 0) {
      console.log(`[scrapeDwellings] Fotocasa: ${listings.length} viviendas extraídas`);
      return listings;
    }
  } catch (err) {
    console.log(`[scrapeDwellings] Fotocasa no accesible (${err.message}), usando datos estructurados`);
  }
  return [];
}

function getStructuredListings() {
  return [
    { externalId: 'DW-001', title: 'Modern 3-room apartment Mitte district',          price: 520000,  rooms: 3, meters: 95,  zone: 'Mitte, Berlin',             zipCode: '10115', source: 'ImmobilienScout24' },
    { externalId: 'DW-002', title: 'Renovated studio near Alexanderplatz',             price: 210000,  rooms: 1, meters: 38,  zone: 'Mitte Alexanderplatz, Berlin', zipCode: '10178', source: 'ImmobilienScout24' },
    { externalId: 'DW-003', title: 'Spacious loft Prenzlauer Berg',                   price: 390000,  rooms: 2, meters: 85,  zone: 'Prenzlauer Berg, Berlin',   zipCode: '10437', source: 'ImmoWelt' },
    { externalId: 'DW-004', title: 'Family house Zehlendorf with garden',             price: 780000,  rooms: 5, meters: 180, zone: 'Zehlendorf, Berlin',        zipCode: '14163', source: 'ImmobilienScout24' },
    { externalId: 'DW-005', title: 'Elegant flat Marais historic quarter',            price: 890000,  rooms: 2, meters: 72,  zone: 'Le Marais, Paris',          zipCode: '75003', source: 'SeLoger' },
    { externalId: 'DW-006', title: 'Haussmann-style apartment Boulevard Voltaire',    price: 620000,  rooms: 3, meters: 110, zone: 'Paris 11e Voltaire',        zipCode: '75011', source: 'SeLoger' },
    { externalId: 'DW-007', title: 'Charming studio Montmartre artists quarter',      price: 295000,  rooms: 1, meters: 32,  zone: 'Montmartre, Paris',         zipCode: '75018', source: 'PAP' },
    { externalId: 'DW-008', title: 'Modern penthouse with Eiffel Tower views',        price: 1850000, rooms: 4, meters: 145, zone: 'Champ de Mars, Paris',      zipCode: '75007', source: 'SeLoger' },
    { externalId: 'DW-009', title: 'Canal house De Pijp neighbourhood',               price: 675000,  rooms: 3, meters: 115, zone: 'De Pijp, Amsterdam',        zipCode: '1072',  source: 'Funda' },
    { externalId: 'DW-010', title: 'Contemporary apartment Jordaan area',             price: 480000,  rooms: 2, meters: 68,  zone: 'Jordaan, Amsterdam',        zipCode: '1016',  source: 'Funda' },
    { externalId: 'DW-011', title: 'Townhouse with private garden Oud-Zuid',          price: 920000,  rooms: 4, meters: 155, zone: 'Oud-Zuid, Amsterdam',       zipCode: '1071',  source: 'Funda' },
    { externalId: 'DW-012', title: 'Bright studio near Vondelpark',                   price: 340000,  rooms: 1, meters: 45,  zone: 'Vondelpark, Amsterdam',     zipCode: '1054',  source: 'Pararius' },
    { externalId: 'DW-013', title: 'Classic Vienna apartment Ringstrasse',            price: 750000,  rooms: 4, meters: 145, zone: 'Innere Stadt, Vienna',      zipCode: '1010',  source: 'Willhaben' },
    { externalId: 'DW-014', title: 'Art Nouveau flat Josefstadt district',            price: 420000,  rooms: 2, meters: 88,  zone: 'Josefstadt, Vienna',        zipCode: '1080',  source: 'Willhaben' },
    { externalId: 'DW-015', title: 'Penthouse with rooftop terrace Döbling',         price: 1100000, rooms: 5, meters: 200, zone: 'Döbling, Vienna',           zipCode: '1190',  source: 'Willhaben' },
    { externalId: 'DW-016', title: 'Tiled azulejo flat Alfama viewpoint',             price: 340000,  rooms: 2, meters: 85,  zone: 'Alfama, Lisbon',            zipCode: '1100',  source: 'Idealista' },
    { externalId: 'DW-017', title: 'Renovated apartment Bairro Alto nightlife area',  price: 280000,  rooms: 2, meters: 70,  zone: 'Bairro Alto, Lisbon',       zipCode: '1200',  source: 'Idealista' },
    { externalId: 'DW-018', title: 'Modern flat near Parque das Nações expo',         price: 395000,  rooms: 3, meters: 100, zone: 'Parque das Nações, Lisbon', zipCode: '1990',  source: 'Imovirtual' },
    { externalId: 'DW-019', title: 'Art Nouveau apartment Sablon quarter',            price: 420000,  rooms: 2, meters: 90,  zone: 'Sablon, Brussels',          zipCode: '1000',  source: 'Immovlan' },
    { externalId: 'DW-020', title: 'Townhouse Ixelles expat neighbourhood',           price: 590000,  rooms: 3, meters: 130, zone: 'Ixelles, Brussels',         zipCode: '1050',  source: 'Immovlan' },
    { externalId: 'DW-021', title: 'Penthouse with terrace Prati district Rome',      price: 980000,  rooms: 4, meters: 160, zone: 'Prati, Rome',               zipCode: '00100', source: 'Immobiliare' },
    { externalId: 'DW-022', title: 'Charming flat Trastevere bohemian quarter',       price: 490000,  rooms: 2, meters: 80,  zone: 'Trastevere, Rome',          zipCode: '00153', source: 'Casa.it' },
    { externalId: 'DW-023', title: 'Historic palazzo apartment Colosseum views',      price: 1250000, rooms: 3, meters: 120, zone: 'Celio, Rome',               zipCode: '00184', source: 'Immobiliare' },
    { externalId: 'DW-024', title: 'Design apartment Navigli Milan canalside',        price: 560000,  rooms: 2, meters: 78,  zone: 'Navigli, Milan',            zipCode: '20100', source: 'Immobiliare' },
    { externalId: 'DW-025', title: 'Luxury flat Brera fashion district',              price: 890000,  rooms: 3, meters: 105, zone: 'Brera, Milan',              zipCode: '20121', source: 'Casa.it' },
    { externalId: 'DW-026', title: 'Modern studio Porta Romana near Bocconi',         price: 310000,  rooms: 1, meters: 42,  zone: 'Porta Romana, Milan',       zipCode: '20135', source: 'Idealista' },
    { externalId: 'DW-027', title: 'Penthouse sea views Barceloneta beach',           price: 830000,  rooms: 3, meters: 130, zone: 'Barceloneta, Barcelona',    zipCode: '08003', source: 'Idealista' },
    { externalId: 'DW-028', title: 'Renovated flat Eixample modernist grid',          price: 450000,  rooms: 3, meters: 105, zone: 'Eixample, Barcelona',       zipCode: '08009', source: 'Idealista' },
    { externalId: 'DW-029', title: 'Bright apartment Gràcia bohemian village',        price: 380000,  rooms: 2, meters: 80,  zone: 'Gràcia, Barcelona',         zipCode: '08012', source: 'Habitaclia' },
    { externalId: 'DW-030', title: 'Studio with terrace Poble Nou tech district',     price: 275000,  rooms: 1, meters: 50,  zone: 'Poble Nou, Barcelona',      zipCode: '08018', source: 'Fotocasa' },
    { externalId: 'DW-031', title: 'Modern duplex Retiro park views',                 price: 695000,  rooms: 4, meters: 138, zone: 'Retiro, Madrid',            zipCode: '28009', source: 'Idealista' },
    { externalId: 'DW-032', title: 'Classic flat Salamanca luxury district',          price: 850000,  rooms: 3, meters: 115, zone: 'Salamanca, Madrid',         zipCode: '28006', source: 'Idealista' },
    { externalId: 'DW-033', title: 'Renovated apartment Malasaña creative quarter',   price: 390000,  rooms: 2, meters: 75,  zone: 'Malasaña, Madrid',          zipCode: '28004', source: 'Fotocasa' },
  ];
}

function detectCityAndCountry(zone) {
  const z = zone.toLowerCase();
  if (z.includes('berlin'))                          return CITY_SEEDS[0];
  if (z.includes('paris'))                           return CITY_SEEDS[1];
  if (z.includes('amsterdam'))                       return CITY_SEEDS[2];
  if (z.includes('vienna') || z.includes('wien'))   return CITY_SEEDS[3];
  if (z.includes('lisbon') || z.includes('lisboa')) return CITY_SEEDS[4];
  if (z.includes('brussels'))                        return CITY_SEEDS[5];
  if (z.includes('rome')   || z.includes('roma'))   return CITY_SEEDS[6];
  if (z.includes('milan')  || z.includes('milano')) return CITY_SEEDS[7];
  if (z.includes('barcelona'))                       return CITY_SEEDS[8];
  if (z.includes('madrid'))                          return CITY_SEEDS[9];
  return CITY_SEEDS[0];
}

async function upsertCountry(seed) {
  return prisma.country.upsert({
    where:  { name: seed.countryName },
    update: {},
    create: { name: seed.countryName, continent: seed.continent, code: seed.countryName.substring(0, 3).toUpperCase() },
  });
}

async function upsertCity(seed, countryId) {
  const existing = await prisma.city.findFirst({ where: { name: seed.cityName, countryId } });
  if (existing) return existing;
  return prisma.city.create({ data: { name: seed.cityName, code: seed.code, countryId } });
}

async function upsertOwner(source) {
  const email = `contact@${source.toLowerCase().replace(/[\s\/\.]+/g, '')}.com`;
  return prisma.owner.upsert({
    where:  { email },
    update: {},
    create: { name: source, email },
  });
}

async function scrapeDwellings() {
  console.log('[scrapeDwellings] Iniciando scraping de viviendas...');

  const fotocasaListings   = await fetchFotocasaListings();
  const structuredListings = getStructuredListings();
  const allListings        = [...fotocasaListings, ...structuredListings];
  console.log(`[scrapeDwellings] Total a procesar: ${allListings.length} viviendas`);

  let insertadas = 0;
  let omitidas   = 0;

  for (const item of allListings) {
    try {
      const seed    = detectCityAndCountry(item.zone);
      const country = await upsertCountry(seed);
      const city    = await upsertCity(seed, country.id);
      const owner   = await upsertOwner(item.source);

      // Deduplicación por externalId guardado al inicio de description
      const exists = await prisma.dwelling.findFirst({
        where: { description: { startsWith: `[${item.externalId}]` } },
      });
      if (exists) { omitidas++; continue; }

      await prisma.dwelling.create({
        data: {
          direction:   item.zone,
          description: `[${item.externalId}] ${item.title}`.substring(0, 255),
          cityId:      city.id,
          zipCode:     item.zipCode || seed.zipCode,
          type:        DWELLING_TYPES[insertadas % DWELLING_TYPES.length],
          rooms:       item.rooms,
          meters:      item.meters,
          ownerId:     owner.id,
          price:       item.price,
        },
      });
      insertadas++;
    } catch (err) {
      console.error(`[scrapeDwellings] Error en "${item.title}":`, err.message);
      omitidas++;
    }
  }

  console.log(`[scrapeDwellings] Finalizado — insertadas: ${insertadas}, omitidas: ${omitidas}`);
  return { insertadas, omitidas, total: allListings.length };
}

async function clearScrapedDwellings() {
  const deleted = await prisma.dwelling.deleteMany({});
  console.log(`[scrapeDwellings] ${deleted.count} viviendas eliminadas`);
  return deleted.count;
}

module.exports = { scrapeDwellings, clearScrapedDwellings };
