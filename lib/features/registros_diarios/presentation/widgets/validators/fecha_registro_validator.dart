// ================================================================================
// SÁBANA DIGITAL DE ENFERMERÍA - UCI
// Hospital Universitario Departamental de Nariño (HUDN)
// Desarrollado por: Esneyder Jesús Ibarra Rosero
// Ingeniero de Sistemas - Práctica profesional
// ================================================================================

// validador de campo obligatorio para la fecha de registro
String? Function(String?) fechaRegistroValidator = (String? value) {
  if (value == null || value.isEmpty) {
    return 'Este campo es obligatorio';
  }
  return null;
};
