// ================================================================================
// SÁBANA DIGITAL DE ENFERMERÍA - UCI
// Hospital Universitario Departamental de Nariño (HUDN)
// Desarrollado por: Esneyder Jesús Ibarra Rosero
// Ingeniero de Sistemas - Práctica profesional
// ================================================================================

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:registro_uci/common/providers/repository_providers.dart';
import 'package:registro_uci/features/ingresos/domain/models/ingreso.dart';

// provider familiar que obtiene los ingresos filtrados por sala
final ingresosBySalaProvider =
    FutureProvider.family<List<Ingreso>, Sala>((ref, sala) async {
  return await ref.watch(ingresosRepositoryProvider).getIngresosBySala(sala);
});
