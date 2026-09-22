// ================================================================================
// SÁBANA DIGITAL DE ENFERMERÍA - UCI
// Hospital Universitario Departamental de Nariño (HUDN)
// Desarrollado por: Esneyder Jesús Ibarra Rosero
// Ingeniero de Sistemas - Práctica profesional
// ================================================================================

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:registro_uci/common/components/tile.dart';
import 'package:registro_uci/common/extensions/async_value_ui.dart';
import 'package:registro_uci/features/auth/presentation/controllers/auth_controller.dart';

class LogoutTile extends ConsumerWidget {
  const LogoutTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authControllerProvider);

    ref.listen<AsyncValue<void>>(authControllerProvider, (prev, state) {
      state.dialogOnError(context);
    });

    return Tile(
      iconData: Icons.logout,
      title: "Cerrar sesión",
      subtitle: "¡Hasta pronto!",
      onTap: () async {
        await ref.read(authControllerProvider.notifier).logout();
      },
    );
  }
}
