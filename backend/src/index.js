require('dotenv').config();
const express = require('express');
const cors    = require('cors');

const scrapeRoutes   = require('./routes/scrapeRoutes');
const jobRoutes      = require('./routes/jobRoutes');
const dwellingRoutes = require('./routes/dwellingRoutes');

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
