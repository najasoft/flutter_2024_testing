import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/models/favoris_model.dart';
import 'package:testing_app/ui/accueil.dart';

void main() {
  runApp(ApplicationTest());
}

class ApplicationTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Favoris(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Application de Test',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: PageAccueil(),
      ),
    );
  }
}
