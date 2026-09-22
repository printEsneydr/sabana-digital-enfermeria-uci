// ================================================================================
// SÁBANA DIGITAL DE ENFERMERÍA - UCI
// Hospital Universitario Departamental de Nariño (HUDN)
// Desarrollado por: Esneyder Jesús Ibarra Rosero
// Ingeniero de Sistemas - Práctica profesional
// ================================================================================

// extension para convertir un string "yyyy-MM-dd" a DateTime
extension ToDateTime on String {
  DateTime? toDateTime() {
    final parts = split('-').map((e) => int.parse(e)).toList();
    try {
      return DateTime(parts[0], parts[1], parts[2]);
    } catch (error) {
      return null;
    }
  }
}
