
import 'package:cooking_master/screens/landing_page.dart';
import 'package:cooking_master/services/auth.dart';
import 'package:cooking_master/screens/detail_recipe_screen.dart';
import 'package:cooking_master/services/firebase_storage.dart';
import 'package:cooking_master/services/firebase_userprofile.dart';
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
    //return MaterialApp(home: EmailSignInPage());
    return  MultiProvider(
      providers: [
        Provider<AuthBase>(
          create: (_) => Auth(),
        ),
        Provider<StorageRepo>(
          create: (_) => StorageRepo(),
        ),
        Provider(
            create:(_) => UserProfile()
        )
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

