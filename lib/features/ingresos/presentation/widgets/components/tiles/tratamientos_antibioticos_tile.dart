// ================================================================================
// SÁBANA DIGITAL DE ENFERMERÍA - UCI
// Hospital Universitario Departamental de Nariño (HUDN)
// Desarrollado por: Esneyder Jesús Ibarra Rosero
// Ingeniero de Sistemas - Práctica profesional
// ================================================================================

import 'package:flutter/material.dart';
import 'package:registro_uci/common/components/tile.dart';
import 'package:registro_uci/pages/tratamiento_antibioticos/tratamientos_antibioticos_page.dart';

// tile que navega a la pagina de tratamientos con antibioticos
class TratamientosAntibioticosTile extends StatelessWidget {
  const TratamientosAntibioticosTile({
    super.key,
    required this.idIngreso,
  });
  final String idIngreso;

  @override
  Widget build(BuildContext context) {
    return Tile(
      iconData: Icons.medication_liquid_sharp,
      title: "Antibióticos",
      subtitle: "Tratamientos con antibióticos",
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return TratamientosAntibioticosPage(
              idIngreso: idIngreso,
            );
          },
        ));
      },
    );
  }
}
