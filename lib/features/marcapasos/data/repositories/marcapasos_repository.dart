// ================================================================================
// SÁBANA DIGITAL DE ENFERMERÍA - UCI
// Hospital Universitario Departamental de Nariño (HUDN)
// Desarrollado por: Esneyder Jesús Ibarra Rosero
// Ingeniero de Sistemas - Práctica profesional
// ================================================================================

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:registro_uci/features/marcapasos/data/dto/create_marcapaso_dto.dart';
import 'package:registro_uci/features/marcapasos/data/dto/update_marcapaso_dto.dart';
import 'package:registro_uci/features/marcapasos/domain/models/marcapaso.dart';

class MarcapasosRepository {
  final FirebaseFirestore firestore;

  MarcapasosRepository({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  /// 🔥 **Registrar un marcapaso vinculado a un ingreso**
  Future<void> registrarMarcapaso(CreateMarcapasoDto dto) async {
    await firestore
        .collection(
            'ingresos') // 🔥 Se asocia con un ingreso, no con un paciente
        .doc(dto.idIngreso) // 🔥 Usa idIngreso en lugar de idPaciente
        .collection('marcapasos') // 🔥 Subcolección correcta
        .add(dto.toJson());
  }

  /// 🔥 **Obtener todos los marcapasos de un ingreso**
  Future<List<Marcapaso>> getMarcapasosByIngreso(String idIngreso) async {
    final querySnapshot = await firestore
        .collection('ingresos') // 🔥 Se asegura de buscar en ingresos
        .doc(idIngreso)
        .collection('marcapasos')
        .get();

    return querySnapshot.docs
        .map((doc) => Marcapaso.fromJson(doc.data()..addAll({'id': doc.id})))
        .toList();
  }

  /// 🔥 **Obtener un marcapaso específico de un ingreso**
  Future<Marcapaso?> getMarcapaso(String idIngreso, String idMarcapaso) async {
    final docSnapshot = await firestore
        .collection('ingresos') // 🔥 Se asegura de buscar en ingresos
        .doc(idIngreso)
        .collection('marcapasos')
        .doc(idMarcapaso)
        .get();

    if (docSnapshot.exists) {
      return Marcapaso.fromJson(
          docSnapshot.data()!..addAll({'id': docSnapshot.id}));
    } else {
      return null;
    }
  }

  /// 🔥 **Actualizar datos de un marcapaso**
  Future<void> updateMarcapaso(
      String idIngreso, String idMarcapaso, UpdateMarcapasoDto dto) async {
    await firestore
        .collection('ingresos') // 🔥 Se asegura de actualizar en ingresos
        .doc(idIngreso)
        .collection('marcapasos')
        .doc(idMarcapaso)
        .update(dto.toJson());
  }

  /// 🔥 **Eliminar un marcapaso**
  Future<void> deleteMarcapaso(String idIngreso, String idMarcapaso) async {
    await firestore
        .collection('ingresos') // 🔥 Se asegura de eliminar desde ingresos
        .doc(idIngreso)
        .collection('marcapasos')
        .doc(idMarcapaso)
        .delete();
  }
}
