import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';
import 'layouts/tramite_card.dart';

class TramitesPage extends StatelessWidget {
  const TramitesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos hardcodeados
    final List<Map<String, dynamic>> tramites = [
      {
        'titulo': 'Permiso de Residencia - Alemania',
        'duracion': '30 días',
        'costo': '220',
        'tipo': 'Documentación',
        'descripcion':
            'Solicitud de autorización de residencia en Alemania. Válido por un año renovable. Necesario para trabajadores extranjeros.',
        'imagen': 'assets/images/tramites.jpg',
        'requisitos': ['Pasaporte válido', 'Contrato de trabajo', 'Comprobante de vivienda'],
        'dependencia': 'Amt für Migration und Flüchtlinge - Berlin',
      },
      {
        'titulo': 'Visa de Trabajo - Francia',
        'duracion': '10 días hábiles',
        'costo': '380',
        'tipo': 'Visados',
        'descripcion':
            'Visa de trabajo para profesionales cualificados. Oportunidades en múltiples sectores. Tramitación en prefectura de París.',
        'imagen': 'assets/images/tramites.jpg',
        'requisitos': ['Pasaporte', 'Oferta de trabajo', 'Certificado de calificaciones'],
        'dependencia': 'Préfecture de Police - Île-de-France',
      },
      {
        'titulo': 'Tarjeta de Residente - Italia',
        'duracion': '15 días',
        'costo': '450',
        'tipo': 'Documentación',
        'descripcion':
            'Carnet di soggiorno para ciudadanos extracomunitarios. Válido por 5 años. Acceso a servicios sociales y sanidad pública italiana.',
        'imagen': 'assets/images/tramites.jpg',
        'requisitos': ['Documento de identidad', 'Comprobante de domicilio', 'Contrato de trabajo'],
        'dependencia': 'Questura - Roma',
      },
      {
        'titulo': 'Permiso de Trabajo - Austria',
        'duracion': '20 días',
        'costo': '380',
        'tipo': 'Laboral',
        'descripcion':
            'Arbeitserlaubnis para trabajar en Austria. Requerido para extracomunitarios. Válido por el período de contrato.',
        'imagen': 'assets/images/tramites.jpg',
        'requisitos': ['Pasaporte válido', 'Contrato de empleo', 'Examen médico'],
        'dependencia': 'Arbeitsmarktservice - Wien',
      },
      {
        'titulo': 'Registro de Residencia - Países Bajos',
        'duracion': '5 días',
        'costo': '120',
        'tipo': 'Documentación',
        'descripcion':
            'Inschrijving en el registro municipal. Requisito obligatorio para empadronamiento y acceso a servicios. Proceso simple en Ámsterdam.',
        'imagen': 'assets/images/tramites.jpg',
        'requisitos': ['Pasaporte', 'Comprobante de alquiler', 'Formulario BSN'],
        'dependencia': 'Gemeente Amsterdam - Burgerzaken',
      },
      {
        'titulo': 'Permiso de Residencia D7 - Portugal',
        'duracion': '60 días',
        'costo': '4500',
        'tipo': 'Visados',
        'descripcion':
            'Visto de residencia para rentistas e inversores. Válido por 1 año, renovable. Acceso a Schengen. Requiere comprobante de ingresos.',
        'imagen': 'assets/images/tramites.jpg',
        'requisitos': ['Pasaporte', 'Comprobante de fondos', 'Contrato de arrendamiento'],
        'dependencia': 'SEF - Serviço de Estrangeiros e Fronteiras, Lisboa',
      },
      {
        'titulo': 'Carte de Résident Belge - Bélgica',
        'duracion': '10 días hábiles',
        'costo': '160',
        'tipo': 'Documentación',
        'descripcion':
            'Tarjeta de residente anual en Bélgica. Renovable. Acceso completo a seguridad social y servicios públicos. Trámite en Bruselas.',
        'imagen': 'assets/images/tramites.jpg',
        'requisitos': ['DNI/Pasaporte', 'Comprobante de ingresos', 'Certificado policial'],
        'dependencia': 'Office des Étrangers - Bruxelles',
      },
    ];

    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: isMobile
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tramites.length,
                  itemBuilder: (context, index) {
                    return TramiteCard(tramite: tramites[index]);
                  },
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        MediaQuery.of(context).size.width > 1200 ? 3 : 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: tramites.length,
                  itemBuilder: (context, index) {
                    return TramiteCard(tramite: tramites[index]);
                  },
                ),
        ),
      ),
    );
  }
}
