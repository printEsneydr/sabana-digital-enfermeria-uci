// ================================================================================
// SÁBANA DIGITAL DE ENFERMERÍA - UCI
// Hospital Universitario Departamental de Nariño (HUDN)
// Desarrollado por: Esneyder Jesús Ibarra Rosero
// Ingeniero de Sistemas - Práctica profesional
// ================================================================================

// extension para convertir un numero de dia a su abreviatura en español
extension ToDayString on int {
  // 1=lunes, 2=martes, ..., 7=domingo
  String toDayString() {
    switch (this) {
      case 7:
        return 'DOM';
      case 1:
        return 'LUN';
      case 2:
        return 'MAR';
      case 3:
        return 'MIÉ';
      case 4:
        return 'JUE';
      case 5:
        return 'VIE';
      case 6:
        return 'SÁB';
      default:
        return '';
    }
  }
}