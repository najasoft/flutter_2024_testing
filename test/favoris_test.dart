import 'package:testing_app/models/favoris_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tests de la classe Favoris', () {
    late Favoris favoris;

    setUp(() {
      favoris = Favoris();
    });

    test('Un élément peut être ajouté aux favoris', () {
      final numeroElement = 42;
      favoris.ajouter(numeroElement);

      expect(favoris.elements.contains(numeroElement), isTrue);
    });
    test('Un élément peut être supprimé des favoris', () {
      final numeroElement = 42;
      favoris.ajouter(numeroElement);
      favoris.supprimer(numeroElement);

      expect(favoris.elements.contains(numeroElement), isFalse);
    });

    test('Ajouter un élément déjà présent ne le duplique pas', () {
      final numeroElement = 42;
      favoris.ajouter(numeroElement);
      favoris.ajouter(numeroElement);

      expect(favoris.elements.length, 1);
    });

    test('Supprimer un élément absent ne génère pas d\'erreur', () {
      final numeroElement = 42;
      favoris.supprimer(numeroElement);

      expect(favoris.elements.isEmpty, isTrue);
    });
    test('L\'ordre des favoris est préservé lorsqu\'ils sont ajoutés', () {
      final elements = [10, 42, 7];
      for (var element in elements) {
        favoris.ajouter(element);
      }

      expect(favoris.elements, equals(elements));
    });
  });
}
