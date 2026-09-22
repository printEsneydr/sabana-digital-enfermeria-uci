// ================================================================================
// SÁBANA DIGITAL DE ENFERMERÍA - UCI
// Hospital Universitario Departamental de Nariño (HUDN)
// Desarrollado por: Esneyder Jesús Ibarra Rosero
// Ingeniero de Sistemas - Práctica profesional
// ================================================================================

import 'package:flutter/material.dart';

// muestra un dialogo para seleccionar una fecha
Future<DateTime?> pickDate(DateTime? initialDate, BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
      locale: const Locale('es', "ES"),
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: initialDate ?? DateTime.now(),
      errorInvalidText: "Fecha Invalida");
  return pickedDate;
}
