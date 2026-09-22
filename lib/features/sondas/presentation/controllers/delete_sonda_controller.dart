// ================================================================================
// SÁBANA DIGITAL DE ENFERMERÍA - UCI
// Hospital Universitario Departamental de Nariño (HUDN)
// Desarrollado por: Esneyder Jesús Ibarra Rosero
// Ingeniero de Sistemas - Práctica profesional
// ================================================================================

import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../data/providers/sonda_provider.dart';

final deleteSondaControllerProvider =
    StateNotifierProvider<DeleteSondaController, AsyncValue<void>>(
  (ref) => DeleteSondaController(ref),
);

class DeleteSondaController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;
  DeleteSondaController(this.ref) : super(const AsyncValue.data(null));

  Future<void> deleteSonda(String idSonda, String idIngreso) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(sondaRepositoryProvider);
      await repository.deleteSonda(idSonda, idIngreso);
      ref.invalidate(sondasProvider(idIngreso));
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
}
