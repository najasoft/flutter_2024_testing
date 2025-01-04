import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/models/favoris_model.dart';
import 'package:testing_app/ui/accueil.dart';

Widget creerPageAccueil() => ChangeNotifierProvider<Favoris>(
      create: (context) => Favoris(),
      child: MaterialApp(
        home: PageAccueil(),
      ),
    );
void main() {
  group("Tests de la page d'accueil", () {
    testWidgets('Affichage de la page d\'accueil', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => Favoris(),
          child: MaterialApp(home: PageAccueil()),
        ),
      );
      // Vérifie que le titre est affiché
      expect(find.text('Liste des Éléments'), findsOneWidget);

      // Vérifie qu'au moins un widget ListTile est visible
      expect(find.byType(ListTile), findsWidgets);
    });
    testWidgets('Cliquer sur le bouton favori change son état',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => Favoris(),
          child: MaterialApp(home: PageAccueil()),
        ),
      );

      // Trouver le bouton favori du premier élément
      final boutonFavoris = find.byIcon(Icons.favorite_border).first;
      expect(boutonFavoris, findsOneWidget);

      // Cliquer sur le bouton favori
      await tester.tap(boutonFavoris);
      await tester.pump();

      // Vérifier que l'icône a changé
      expect(find.byIcon(Icons.favorite).first, findsOneWidget);
    });
    testWidgets('Navigation vers la page Favoris', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => Favoris(),
          child: MaterialApp(home: PageAccueil()),
        ),
      );

      final boutonNavigation = find.byIcon(Icons.favorite);
      expect(boutonNavigation, findsOneWidget);

      await tester.tap(boutonNavigation);
      await tester.pumpAndSettle();

      expect(find.text('Mes Favoris'), findsOneWidget);
    });

    testWidgets('Les favoris ajoutés s\'affichent sur la page Favoris',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => Favoris(),
          child: MaterialApp(home: PageAccueil()),
        ),
      );
      // Vérifie que 'Élément 0' est visible au début
      expect(find.text('Élément 0'), findsOneWidget);

      // Simule un défilement vers le haut
      await tester.fling(
        find.byType(ListView), // Cible le ListView
        const Offset(0, -200), // Défilement vers le haut
        3000, // Vitesse du défilement
      );
      // Attend que le défilement soit terminé
      await tester.pumpAndSettle();

      // Vérifie que 'Élément 0' n'est plus visible
      expect(find.text('Élément 0'), findsNothing);
      expect(find.text('Élément 27'), findsOneWidget);
    });
  });
}
