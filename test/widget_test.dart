// ================================================================================
// SÁBANA DIGITAL DE ENFERMERÍA - UCI
// Hospital Universitario Departamental de Nariño (HUDN)
// Desarrollado por: Esneyder Jesús Ibarra Rosero
// Ingeniero de Sistemas - Práctica profesional
// ================================================================================

// PRUEBAS UNITARIAS DEL PROYECTO
//
// CREDITOS: Esneyder Jesús Ibarra Rosero
// Proyecto: Sábana Digital de Enfermería - UCI - HUDN
//
// Pruebas de las extensiones puras de Dart utilizadas en la aplicación.
// Estas pruebas no requieren conexión con Firebase ni ejecutar la app.

import 'package:flutter_test/flutter_test.dart';

import 'package:registro_uci/common/extensions/capitalize.dart';
import 'package:registro_uci/common/extensions/int_to_day_string.dart';
import 'package:registro_uci/common/extensions/string_to_date.dart';
import 'package:registro_uci/common/extensions/string_to_time.dart';

void main() {
  group('extensión capitalize', () {
    test('capitaliza la primera letra de una palabra', () {
      expect('sábana'.capitalize(), 'Sábana');
      expect('enfermeria'.capitalize(), 'Enfermeria');
    });

    test('convierte el resto de la palabra a minúsculas', () {
      expect('HOSPITAL'.capitalize(), 'Hospital');
    });
  });

  group('extensión toDayString', () {
    test('convierte el número del día a su abreviatura en español', () {
      expect(1.toDayString(), 'LUN');
      expect(3.toDayString(), 'MIÉ');
      expect(7.toDayString(), 'DOM');
    });

    test('devuelve cadena vacía para valores fuera de rango', () {
      expect(0.toDayString(), '');
      expect(8.toDayString(), '');
    });
  });

  group('extensión toDateTime', () {
    test('convierte un string fecha "yyyy-MM-dd" a DateTime', () {
      final fecha = '2024-05-10'.toDateTime();
      expect(fecha, isNotNull);
      expect(fecha!.year, 2024);
      expect(fecha.month, 5);
      expect(fecha.day, 10);
    });
  });

  group('extensión toDayTime', () {
    test('convierte un string "HH:mm" a TimeOfDay', () {
      final hora = '08:30'.toDayTime();
      expect(hora.hour, 8);
      expect(hora.minute, 30);
    });
  });
}