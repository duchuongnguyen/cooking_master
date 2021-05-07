import 'package:cooking_master/notifier/recipe_notifier.dart';
import 'package:cooking_master/screens/landing_page.dart';
import 'package:cooking_master/services/auth_service.dart';
import 'package:cooking_master/services/firebase_storage.dart';
import 'package:cooking_master/services/firebase_userprofile.dart';
import 'package:cooking_master/services/user_save_recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CookingMasterApp());
}

class CookingMasterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthBase>(
          create: (_) => Auth(),
        ),
        Provider<StorageRepo>(
          create: (_) => StorageRepo(),
        ),
        Provider(create: (_) => UserProfile()),
        Provider(create: (_) => FirebaseUserSaveRecipe()),
        ChangeNotifierProvider(
          create: (_) => RecipeNotifier(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        home: LandingPage(),
      ),
    );
  }
}
