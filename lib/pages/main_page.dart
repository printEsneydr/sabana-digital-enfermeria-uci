// ================================================================================
// SÁBANA DIGITAL DE ENFERMERÍA - UCI
// Hospital Universitario Departamental de Nariño (HUDN)
// Desarrollado por: Esneyder Jesús Ibarra Rosero
// Ingeniero de Sistemas - Práctica profesional
// ================================================================================

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:registro_uci/common/components/buttons/primary_button.dart';
import 'package:registro_uci/common/extensions/async_value_ui.dart';
import 'package:registro_uci/features/auth/data/providers/user_role_provider.dart';
import 'package:registro_uci/features/auth/domain/enums/user_role.dart';
import 'package:registro_uci/features/auth/presentation/controllers/auth_controller.dart';

// pagina principal temporal que muestra el rol y boton de logout
class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  // construye la interfaz principal con el rol del usuario y boton de cerrar sesion
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // obtiene el rol del usuario desde el provider
    final role = ref.watch(roleProvider);
    // estado del controlador de autenticacion
    final AsyncValue<void> state = ref.watch(authControllerProvider);
    // escucha errores de autenticacion y muestra dialogo si ocurre alguno
    ref.listen<AsyncValue<void>>(authControllerProvider, (prev, state) {
      state.dialogOnError(context);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Página principal"),
      ),
      body: Column(
        children: [
          Text("Rol: ${role?.roleToString()}"),
          PrimaryButton(
            isLoading: state.isLoading,
            enabled: !state.isLoading,
            child: const Text("Cerrar sesión"),
            onTap: () {
              ref.read(authControllerProvider.notifier).logout();
            },
          )
        ],
      ),
    );
  }
}
