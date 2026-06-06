const express = require('express');
const router  = express.Router();
const prisma  = require('../config/prisma');

// GET /api/jobs → devuelve todas las ofertas en el formato que espera Flutter
router.get('/', async (req, res) => {
  try {
    const jobs = await prisma.jobOffer.findMany({
      include: {
        company: { include: { city: true } },
        country: true,
        city:    true,
      },
      orderBy: { timestampStart: 'desc' },
      take: 50,
    });

    // Mapeamos al formato que espera EmpleoCard en Flutter
    const result = jobs.map(job => ({
      id:          job.id.toString(),
      titulo:      job.title,
      empresa:     `${job.company.name}${job.city ? ' - ' + job.city.name : ''}`,
      salario:     job.salary ? job.salary.toFixed(0) : '0',
      tipo:        job.workday,
      ubicacion:   job.city
                     ? `${job.city.name}, ${job.country.name}`
                     : job.country.name,
      descripcion: job.description,
      experiencia: job.experience,
      sector:      job.workSector,
      contrato:    job.contract,
      requisitos:  job.requirements || '',
    }));

    res.json(result);
  } catch (err) {
    console.error('[GET /jobs]', err);
    res.status(500).json({ error: err.message });
  }
});

// GET /api/jobs/:id → detalle de una oferta
router.get('/:id', async (req, res) => {
  try {
    const job = await prisma.jobOffer.findUnique({
      where:   { id: BigInt(req.params.id) },
      include: { company: true, country: true, city: true },
    });
    if (!job) return res.status(404).json({ error: 'Oferta no encontrada' });

    res.json({
      id:          job.id.toString(),
      titulo:      job.title,
      empresa:     job.company.name,
      salario:     job.salary ? job.salary.toFixed(0) : '0',
      tipo:        job.workday,
      ubicacion:   job.city ? `${job.city.name}, ${job.country.name}` : job.country.name,
      descripcion: job.description,
      experiencia: job.experience,
      sector:      job.workSector,
      contrato:    job.contract,
      requisitos:  job.requirements || '',
    });
  } catch (err) {
    console.error('[GET /jobs/:id]', err);
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
