import 'package:cooking_master/notifier/mytopics_notifier.dart';
import 'package:cooking_master/notifier/recipes_notifier.dart';
import 'package:cooking_master/screens/landing_page.dart';
import 'package:cooking_master/services/auth_service.dart';
import 'package:cooking_master/services/firebase_storage.dart';
import 'package:cooking_master/services/userprofile_service.dart';
import 'package:cooking_master/services/recipe_service.dart';
import 'package:cooking_master/notifier/user_saved_recipe.dart';
import 'package:cooking_master/services/user_save_recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'notifier/your_recipes_notifier.dart';

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
        Provider<AuthBase>(create: (_) => Auth()),
        Provider<StorageRepo>(create: (_) => StorageRepo()),
        Provider(create: (_) => UserProfileService()),
        Provider(create: (_) => RecipeService()),
        Provider(create: (_) => FirebaseUserSaveRecipe()),
        ChangeNotifierProvider(create: (_) => SavedRecipeProvider()),
        ChangeNotifierProvider(create: (_) => RecipeNotifier()),
        ChangeNotifierProvider(create: (_) => MyTopicsNotifier()),
        ChangeNotifierProvider(create: (_) => YourRecipeNotifier()),
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
