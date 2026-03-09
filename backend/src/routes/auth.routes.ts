import { Router, Request, Response } from 'express';
import { PrismaClient } from '../generated/prisma';

const router = Router();
const prisma = new PrismaClient();

// POST /api/auth/register
router.post('/register', async (req: Request, res: Response) => {
  const { name, surname, email, password, telephone, birthdate, countryId, eu } = req.body;

  try {
    // Verificar si el email ya existe
    const existing = await prisma.user.findUnique({ where: { email } });
    if (existing) {
      return res.status(400).json({ message: 'El email ya está registrado' });
    }

    const user = await prisma.user.create({
      data: {
        name,
        surname,
        email,
        password,       // ⚠️ Más adelante añadiremos bcrypt para encriptar
        telephone,
        birthdate: new Date(birthdate),
        countryId,
        eu,
      },
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
      user: {
        id: user.id.toString(),
        name: user.name,
        email: user.email,
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
});

export default router;