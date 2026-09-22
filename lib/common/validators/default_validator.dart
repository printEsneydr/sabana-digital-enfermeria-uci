// ================================================================================
// SÁBANA DIGITAL DE ENFERMERÍA - UCI
// Hospital Universitario Departamental de Nariño (HUDN)
// Desarrollado por: Esneyder Jesús Ibarra Rosero
// Ingeniero de Sistemas - Práctica profesional
// ================================================================================

// validador por defecto que verifica que el campo no este vacio
String? Function(String?) defaultValidator = (String? value) {
  if (value == null || value == '') {
    return 'Este campo es obligatorio';
  }
  return null;
};
