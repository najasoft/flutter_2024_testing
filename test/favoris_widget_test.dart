import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/models/favoris_model.dart';
import 'package:testing_app/ui/favoris_screen.dart';

late Favoris listeFavoris;

Widget creerPageFavoris() => ChangeNotifierProvider<Favoris>(
      create: (context) {
        listeFavoris = Favoris();
        return listeFavoris;
      },
      child: MaterialApp(
        home: PageFavoris(),
      ),
    );

void ajouterElements() {
  for (var i = 0; i < 10; i += 2) {
    listeFavoris.ajouter(i);
  }
}

void main() {
  testWidgets('La liste des favoris s\'affiche correctement',
      (WidgetTester tester) async {
    await tester.pumpWidget(creerPageFavoris());
    ajouterElements();
    await tester.pumpAndSettle();

    // Vérifie que la liste des favoris est un ListView
    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Suppression d\'un élément de la liste des favoris',
      (WidgetTester tester) async {
    await tester.pumpWidget(creerPageFavoris());
    ajouterElements();
    await tester.pumpAndSettle();

    // Vérifie le nombre d'éléments avant la suppression
    var nombreTotal = tester.widgetList(find.byIcon(Icons.delete)).length;

    // Clique sur le bouton "supprimer" du premier élément
    await tester.tap(find.byIcon(Icons.delete).first);
    await tester.pumpAndSettle();

    // Vérifie que le nombre d'éléments a diminué
    expect(tester.widgetList(find.byIcon(Icons.delete)).length,
        lessThan(nombreTotal));
  });
}
