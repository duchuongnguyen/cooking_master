import 'package:cooking_master/screens/detail_recipe_screen.dart';
import 'package:flutter/material.dart';
import 'package:cooking_master/screens/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
void main() {
  runApp(CookingMasterApp());
}

class CookingMasterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

