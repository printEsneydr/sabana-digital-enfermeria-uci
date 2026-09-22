// ================================================================================
// SÁBANA DIGITAL DE ENFERMERÍA - UCI
// Hospital Universitario Departamental de Nariño (HUDN)
// Desarrollado por: Esneyder Jesús Ibarra Rosero
// Ingeniero de Sistemas - Práctica profesional
// ================================================================================

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:registro_uci/features/antibioticos/data/abstract_repositories/dias_tratamiento_repository.dart';
import 'package:registro_uci/features/antibioticos/data/dto/update_dia_tratamiento_dto.dart';
import 'package:registro_uci/features/antibioticos/domain/models/dia_tratamiento.dart';

class FirebaseDiasTratamientoRepository implements DiasTratamientoRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<DiaTratamiento>> getDiasTratamiento(
    String idIngreso,
    String idTratamientoAntibiotico,
  ) async {
    try {
      final querySnapshot = await _firestore
          .collection('ingresos')
          .doc(idIngreso)
          .collection('tratamientosAntibioticos')
          .doc(idTratamientoAntibiotico)
          .collection('diasTratamiento')
          .get();

      return querySnapshot.docs
          .map((doc) => DiaTratamiento.fromJson(doc.data(), id: doc.id))
          .toList();
    } catch (e) {
      log('Error al obtener los días de tratamiento: $e');
      throw Exception('Error al obtener los días de tratamiento');
    }
  }

  @override
  Future<DiaTratamiento?> getDiaTratamiento(
    String idIngreso,
    String idTratamientoAntibiotico,
    String idDiaTratamiento,
  ) async {
    try {
      final diaTratamientoRef = _firestore
          .collection('ingresos')
          .doc(idIngreso)
          .collection('tratamientosAntibioticos')
          .doc(idTratamientoAntibiotico)
          .collection('diasTratamiento')
          .doc(idDiaTratamiento);

      final diaTratamientoSnapshot = await diaTratamientoRef.get();

      if (diaTratamientoSnapshot.exists) {
        return DiaTratamiento.fromJson(diaTratamientoSnapshot.data()!,
            id: diaTratamientoSnapshot.id);
      } else {
        log('Día de tratamiento no encontrado');
        return null;
      }
    } catch (e) {
      log('Error al obtener el día de tratamiento: $e');
      return null;
    }
  }

  @override
  Future<void> updateDiaTratamiento(
    String idIngreso,
    String idTratamientoAntibiotico,
    String idDiaTratamiento,
    UpdateDiaTratamientoDto dto,
  ) async {
    try {
      final diaTratamientoRef = _firestore
          .collection('ingresos')
          .doc(idIngreso)
          .collection('tratamientosAntibioticos')
          .doc(idTratamientoAntibiotico)
          .collection('diasTratamiento')
          .doc(idDiaTratamiento);

      // Update the diaTratamiento document with the values from the DTO
      await diaTratamientoRef.update(dto);
    } catch (e) {
      log('Error al actualizar el día de tratamiento: $e');
      throw Exception('Error al actualizar el día de tratamiento');
    }
  }

  @override
  Future<void> refreshDiasTratamiento(
    String idIngreso,
    String idTratamientoAntibiotico,
  ) async {
    try {
      final tratamientoRef = _firestore
          .collection('ingresos')
          .doc(idIngreso)
          .collection('tratamientosAntibioticos')
          .doc(idTratamientoAntibiotico);

      final tratamientoSnapshot = await tratamientoRef.get();
      if (!tratamientoSnapshot.exists) {
        throw Exception('Tratamiento antibiótico no encontrado');
      }

      final tratamientoData = tratamientoSnapshot.data()!;
      final int frecuenciaEn24h = tratamientoData['frecuenciaEn24h'];
      final int cantidad = tratamientoData['cantidad'];
      final DateTime fechaInicio =
          (tratamientoData['fechaInicio'] as Timestamp).toDate();

      final int expectedCantidad = frecuenciaEn24h * cantidad;
      final now = DateTime.now();

      // Get existing days
      final diasTratamientoSnapshot =
          await tratamientoRef.collection('diasTratamiento').get();
      final existingDays = diasTratamientoSnapshot.docs
          .map((d) => d.data()['dia'] as int)
          .toSet();

      // Calculate how many days should exist from fechaInicio to now
      final int totalDaysShouldExist =
          now.difference(fechaInicio).inDays ~/ 1 + 1;

      DateTime currentInicio = fechaInicio;

      final batch = _firestore.batch();

      for (int d = 0; d < totalDaysShouldExist; d++) {
        final dayNum = d + 1;
        if (!existingDays.contains(dayNum)) {
          DateTime fin = currentInicio.add(const Duration(hours: 23, minutes: 59));

          final diaTratamientoRef = tratamientoRef
              .collection('diasTratamiento')
              .doc(dayNum.toString());
          batch.set(diaTratamientoRef, {
            'inicio': currentInicio,
            'fin': fin,
            'dia': dayNum,
            'valido': false,
          });

          final dosisInterval =
              Duration(hours: 24 ~/ frecuenciaEn24h);
          DateTime dosisHora = currentInicio;

          for (int i = 0; i < frecuenciaEn24h; i++) {
            final dosisRef = diaTratamientoRef.collection('dosis').doc();
            batch.set(dosisRef, {
              'hora': dosisHora,
              'cantidad': cantidad,
              'dosis': '',
              'comentario': '',
            });
            dosisHora = dosisHora.add(dosisInterval);
          }

        }
        currentInicio = currentInicio.add(const Duration(hours: 24));
      }

      // Update valido flag on existing days
      for (var diaDoc in diasTratamientoSnapshot.docs) {
        final diaTratamientoRef = diaDoc.reference;
        final dosisSnapshot =
            await diaTratamientoRef.collection('dosis').get();

        int actualCantidad =
            dosisSnapshot.docs.fold<int>(0, (suma, dosisDoc) {
          return suma + (dosisDoc.data()['cantidad'] as int);
        });

        batch.update(diaTratamientoRef, {
          'valido': actualCantidad == expectedCantidad,
        });
      }

      await batch.commit();
      log('Dias de tratamiento actualizados exitosamente');
    } catch (e) {
      log('Error al refrescar los días de tratamiento: $e');
      throw Exception('Error al refrescar los días de tratamiento');
    }
  }
}
