const express = require('express');
const router  = express.Router();
const { scrapeJobs, clearScrapedJobs }           = require('../services/jobScraper');
const { scrapeDwellings, clearScrapedDwellings } = require('../services/dwellingScraper');

// POST /api/scrape/jobs
router.post('/jobs', async (req, res) => {
  try {
    const result = await scrapeJobs();
    res.json({ ok: true, message: 'Scraping de empleos completado', ...result });
  } catch (err) {
    console.error('[POST /scrape/jobs]', err);
    res.status(500).json({ ok: false, error: err.message });
  }
});

// POST /api/scrape/dwellings
router.post('/dwellings', async (req, res) => {
  try {
    const result = await scrapeDwellings();
    res.json({ ok: true, message: 'Scraping de viviendas completado', ...result });
  } catch (err) {
    console.error('[POST /scrape/dwellings]', err);
    res.status(500).json({ ok: false, error: err.message });
  }
});

// POST /api/scrape/all
router.post('/all', async (req, res) => {
  try {
    const [jobs, dwellings] = await Promise.all([scrapeJobs(), scrapeDwellings()]);
    res.json({ ok: true, message: 'Scraping completo', jobs, dwellings });
  } catch (err) {
    console.error('[POST /scrape/all]', err);
    res.status(500).json({ ok: false, error: err.message });
  }
});

// POST /api/scrape/reset → limpia datos de scraping y vuelve a insertar desde cero
router.post('/reset', async (req, res) => {
  try {
    const [deletedJobs, deletedDwellings] = await Promise.all([
      clearScrapedJobs(),
      clearScrapedDwellings(),
    ]);
    const [jobs, dwellings] = await Promise.all([scrapeJobs(), scrapeDwellings()]);
    res.json({
      ok: true,
      message: 'Reset y scraping completo',
      deleted:  { jobs: deletedJobs, dwellings: deletedDwellings },
      inserted: { jobs, dwellings },
    });
  } catch (err) {
    console.error('[POST /scrape/reset]', err);
    res.status(500).json({ ok: false, error: err.message });
  }
});

module.exports = router;