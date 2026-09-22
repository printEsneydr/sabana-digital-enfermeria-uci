// ================================================================================
// SÁBANA DIGITAL DE ENFERMERÍA - UCI
// Hospital Universitario Departamental de Nariño (HUDN)
// Desarrollado por: Esneyder Jesús Ibarra Rosero
// Ingeniero de Sistemas - Práctica profesional
// ================================================================================

// valida que el campo de contrasena no este vacio
String? Function(String?) passwordValidator = (String? value) {
  if (value == null || value == '') {
    return 'Este campo es obligatorio';
  }
  return null;
};
