import { Router, Request, Response } from 'express';
import { PrismaClient } from '../generated/prisma';
import { Pool } from 'pg';
import { PrismaPg } from '@prisma/adapter-pg';

const pool = new Pool({
  host: '127.0.0.1',
  port: 5432,
  user: 'casanova',
  password: 'estocolmo_rubias',
  database: 'novacasadb',
});

const adapter = new PrismaPg(pool);
const prisma = new PrismaClient({ adapter });

const router = Router();

// POST /api/auth/register
router.post('/register', async (req: Request, res: Response) => {
  const { name, surname, email, password, telephone, birthdate, countryId, eu } = req.body;
  try {
    const existing = await prisma.user.findUnique({ where: { email } });
    if (existing) {
      return res.status(400).json({ message: 'El email ya está registrado' });
    }
    const user = await prisma.user.create({
      data: { name, surname, email, password, telephone, birthdate: new Date(birthdate), countryId, eu },
    });
    res.status(201).json({ message: 'Usuario creado', userId: user.id.toString() });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
});

// POST /api/auth/login
router.post('/login', async (req: Request, res: Response) => {
  const { email, password } = req.body;
  try {
    const user = await prisma.user.findUnique({ where: { email } });
    if (!user || user.password !== password) {
      return res.status(401).json({ message: 'Email o contraseña incorrectos' });
    }
    res.status(200).json({
      message: 'Login exitoso',
      user: { id: user.id.toString(), name: user.name, email: user.email },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
});

export default router;