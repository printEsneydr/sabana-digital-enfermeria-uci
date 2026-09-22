// ================================================================================
// SÁBANA DIGITAL DE ENFERMERÍA - UCI
// Hospital Universitario Departamental de Nariño (HUDN)
// Desarrollado por: Esneyder Jesús Ibarra Rosero
// Ingeniero de Sistemas - Práctica profesional
// ================================================================================

class CreateMarcapasoDto {
  final String idIngreso; // 🔥 Asociar marcapaso a un Ingreso
  final String fechaColocacion;
  final String modo;
  final String via;
  final int frecuencia;
  final double sensibilidad;
  final double salida;

  CreateMarcapasoDto({
    required this.idIngreso,
    required this.fechaColocacion,
    required this.modo,
    required this.via,
    required this.frecuencia,
    required this.sensibilidad,
    required this.salida,
  });

  Map<String, dynamic> toJson() {
    return {
      "idIngreso": idIngreso, // 🔥 Se guarda el Ingreso asociado
      "fechaColocacion": fechaColocacion,
      "modo": modo,
      "via": via,
      "frecuencia": frecuencia,
      "sensibilidad": sensibilidad,
      "salida": salida,
    };
  }
}
