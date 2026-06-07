require('dotenv').config();
const express = require('express');
const cors    = require('cors');

const scrapeRoutes   = require('./routes/scrapeRoutes');
const jobRoutes      = require('./routes/jobRoutes');
const dwellingRoutes = require('./routes/dwellingRoutes');
const { scrapeJobs }      = require('./services/jobScraper');
const { scrapeDwellings } = require('./services/dwellingScraper');
const prisma = require('./config/prisma');

const app  = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

// Health check
app.get('/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

// Rutas
app.use('/api/scrape',    scrapeRoutes);
app.use('/api/jobs',      jobRoutes);
app.use('/api/dwellings', dwellingRoutes);

app.listen(PORT, () => {
  console.log(`NovaCasa backend corriendo en http://localhost:${PORT}`);
  console.log('Endpoints disponibles:');
  console.log('  GET  /health');
  console.log('  POST /api/scrape/jobs       → scraping empleos');
  console.log('  POST /api/scrape/dwellings  → scraping viviendas');
  console.log('  POST /api/scrape/all        → ambos a la vez');
  console.log('  GET  /api/jobs              → listar empleos');
  console.log('  GET  /api/dwellings         → listar viviendas');
});

// Scraping automático al arrancar si la BD está vacía
async function autoScrape() {
  try {
    // Espera 3 segundos para asegurarse de que la BD está lista
    await new Promise(resolve => setTimeout(resolve, 3000));

    const jobCount      = await prisma.jobOffer.count();
    const dwellingCount = await prisma.dwelling.count();

    if (jobCount === 0 || dwellingCount === 0) {
      console.log(`[autoScrape] BD vacía (${jobCount} empleos, ${dwellingCount} viviendas), iniciando scraping...`);
      await scrapeJobs();
      await scrapeDwellings();
      console.log('[autoScrape] Scraping automático completado');
    } else {
      console.log(`[autoScrape] BD ya tiene datos (${jobCount} empleos, ${dwellingCount} viviendas), omitiendo scraping`);
    }
  } catch (err) {
    console.error('[autoScrape] Error:', err.message);
  }
}

autoScrape();

// Actualización periódica cada 24 horas
setInterval(async () => {
  console.log('[autoScrape] Actualización periódica de datos...');
  try {
    await scrapeJobs();
    await scrapeDwellings();
    console.log('[autoScrape] Actualización periódica completada');
  } catch (err) {
    console.error('[autoScrape] Error en actualización periódica:', err.message);
  }
}, 24 * 60 * 60 * 1000);