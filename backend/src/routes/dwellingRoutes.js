const express = require('express');
const router  = express.Router();
const prisma  = require('../config/prisma');

// GET /api/dwellings → devuelve todas las viviendas en el formato que espera Flutter
router.get('/', async (req, res) => {
  try {
    const dwellings = await prisma.dwelling.findMany({
      include: {
        city:  { include: { country: true } },
        owner: true,
      },
      orderBy: { id: 'desc' },
      take: 50,
    });

    // Mapeamos al formato que espera ViviendaCard en Flutter
    const result = dwellings.map(d => ({
      id:           d.id.toString(),
      titulo:       d.description,
      precio:       d.price.toFixed(0),
      metros:       d.meters.toFixed(0),
      habitaciones: d.rooms.toString(),
      bathrooms:    '1',          // No está en el schema, valor por defecto
      tipo:         d.type,
      descripcion:  d.description,
      ciudad:       d.city ? `${d.city.name}, ${d.city.country.name}` : 'Europe',
      portal:       d.owner.name,
      direccion:    d.direction,
      zipCode:      d.zipCode,
    }));

    res.json(result);
  } catch (err) {
    console.error('[GET /dwellings]', err);
    res.status(500).json({ error: err.message });
  }
});

// GET /api/dwellings/:id → detalle de una vivienda
router.get('/:id', async (req, res) => {
  try {
    const d = await prisma.dwelling.findUnique({
      where:   { id: BigInt(req.params.id) },
      include: { city: { include: { country: true } }, owner: true },
    });
    if (!d) return res.status(404).json({ error: 'Vivienda no encontrada' });

    res.json({
      id:           d.id.toString(),
      titulo:       d.description,
      precio:       d.price.toFixed(0),
      metros:       d.meters.toFixed(0),
      habitaciones: d.rooms.toString(),
      bathrooms:    '1',
      tipo:         d.type,
      descripcion:  d.description,
      ciudad:       d.city ? `${d.city.name}, ${d.city.country.name}` : 'Europe',
      portal:       d.owner.name,
      direccion:    d.direction,
      zipCode:      d.zipCode,
    });
  } catch (err) {
    console.error('[GET /dwellings/:id]', err);
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
