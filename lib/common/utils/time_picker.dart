// ================================================================================
// SÁBANA DIGITAL DE ENFERMERÍA - UCI
// Hospital Universitario Departamental de Nariño (HUDN)
// Desarrollado por: Esneyder Jesús Ibarra Rosero
// Ingeniero de Sistemas - Práctica profesional
// ================================================================================

import 'package:flutter/material.dart';

// muestra un dialogo para seleccionar una hora
Future<TimeOfDay?> pickTime(
  BuildContext context,
  TimeOfDay initialTime,
  String message,
) async {
  TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: initialTime,
    initialEntryMode: TimePickerEntryMode.dial,
    hourLabelText: "HORA",
    minuteLabelText: "MINUTO",
    helpText: message,
  );
  return pickedTime;
}
