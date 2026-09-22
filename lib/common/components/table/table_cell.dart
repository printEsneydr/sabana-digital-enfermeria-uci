// ================================================================================
// SÁBANA DIGITAL DE ENFERMERÍA - UCI
// Hospital Universitario Departamental de Nariño (HUDN)
// Desarrollado por: Esneyder Jesús Ibarra Rosero
// Ingeniero de Sistemas - Práctica profesional
// ================================================================================

import 'package:flutter/material.dart';

class AlignedCell extends StatelessWidget {
  final Widget child;
  final MainAxisAlignment? mainAxisAlignment;
  const AlignedCell(
    this.child, {
    super.key,
    this.mainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [child],
    );
  }
}

DataCell tableCell(Widget child, MainAxisAlignment? alignment) {
  return DataCell(
    AlignedCell(
      child,
      mainAxisAlignment: alignment,
    ),
  );
}
