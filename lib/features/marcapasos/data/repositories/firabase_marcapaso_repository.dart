// ================================================================================
// SÁBANA DIGITAL DE ENFERMERÍA - UCI
// Hospital Universitario Departamental de Nariño (HUDN)
// Desarrollado por: Esneyder Jesús Ibarra Rosero
// Ingeniero de Sistemas - Práctica profesional
// ================================================================================

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:registro_uci/features/marcapasos/data/constants/firebase_collection_names.dart';
import 'package:registro_uci/features/marcapasos/data/dto/create_marcapaso_dto.dart';
import 'package:registro_uci/features/marcapasos/data/dto/update_marcapaso_dto.dart';
import 'package:registro_uci/features/marcapasos/domain/models/marcapaso.dart';
import 'package:registro_uci/features/marcapasos/data/abstract_repositories/marcapasos_repository.dart';

class FirebaseMarcapasosRepository implements MarcapasosRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// 🔥 **Registrar un marcapaso vinculado a un ingreso**
  @override
  Future<void> createMarcapaso(CreateMarcapasoDto dto) async {
    try {
      await _firestore
          .collection(FirebaseCollectionNames.ingresos)
          .doc(dto.idIngreso)
          .collection(FirebaseCollectionNames.marcapasos)
          .add(dto.toJson());
      log('✅ Marcapaso registrado correctamente para el ingreso ${dto.idIngreso}');
    } catch (e) {
      log('❌ Error al registrar el marcapaso: $e');
      throw Exception('Error al registrar el marcapaso');
    }
  }

  /// 🔥 **Obtener todos los marcapasos registrados en la base de datos**
  @override
  Future<List<Marcapaso>> getAllMarcapasos() async {
    try {
      final querySnapshot = await _firestore
          .collectionGroup(FirebaseCollectionNames.marcapasos)
          .get();

      return querySnapshot.docs.map((doc) {
        return Marcapaso.fromJson(doc.data()..addAll({'id': doc.id}));
      }).toList();
    } catch (e) {
      log('❌ Error al obtener todos los marcapasos: $e');
      throw Exception('Error al obtener los marcapasos');
    }
  }

  @override
  Stream<List<Marcapaso>> getMarcapasosByIngreso(String idIngreso) {
    return _firestore
        .collection('ingresos')
        .doc(idIngreso)
        .collection('marcapasos')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((doc) {
              return Marcapaso.fromJson(doc.data()..addAll({'id': doc.id}));
            }).toList());
  }

  @override
  Future<Marcapaso?> getMarcapasoById(
      String idIngreso, String idMarcapaso) async {
    try {
      log("📡 Buscando marcapaso con ID: $idMarcapaso en el ingreso: $idIngreso");

      final docSnapshot = await _firestore
          .collection('ingresos')
          .doc(idIngreso)
          .collection('marcapasos')
          .doc(idMarcapaso)
          .get();

      if (docSnapshot.exists) {
        log("✅ Marcapaso encontrado: ${docSnapshot.data()}");
        return Marcapaso.fromJson(
            docSnapshot.data()!..addAll({'id': docSnapshot.id}));
      } else {
        log("⚠️ No se encontró el marcapaso con ID: $idMarcapaso");
        return null;
      }
    } catch (e) {
      log("❌ Error al obtener el marcapaso: $e");
      throw Exception('Error al obtener el marcapaso');
    }
  }

  /// 🔥 **Actualizar un marcapaso**
  @override
  Future<void> updateMarcapaso(
      String idIngreso, String idMarcapaso, UpdateMarcapasoDto dto) async {
    try {
      await _firestore
          .collection(FirebaseCollectionNames.ingresos)
          .doc(idIngreso)
          .collection(FirebaseCollectionNames.marcapasos)
          .doc(idMarcapaso)
          .update(dto.toJson());
      log('✅ Marcapaso $idMarcapaso actualizado correctamente');
    } catch (e) {
      log('❌ Error al actualizar el marcapaso $idMarcapaso: $e');
      throw Exception('Error al actualizar el marcapaso');
    }
  }

  /// 🔥 **Eliminar un marcapaso**
  @override
  Future<void> deleteMarcapaso(String idIngreso, String idMarcapaso) async {
    try {
      await _firestore
          .collection(FirebaseCollectionNames.ingresos)
          .doc(idIngreso)
          .collection(FirebaseCollectionNames.marcapasos)
          .doc(idMarcapaso)
          .delete();
      log('✅ Marcapaso $idMarcapaso eliminado correctamente');
    } catch (e) {
      log('❌ Error al eliminar el marcapaso $idMarcapaso: $e');
      throw Exception('Error al eliminar el marcapaso');
    }
  }
}
