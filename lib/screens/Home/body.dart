import 'dart:ui';
import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/services/recipe_service.dart';
import 'package:cooking_master/widgets/list_view_of_recipe_cards_with_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'header_with_searchbox.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recipe = Provider.of<RecipeService>(context, listen: false);

    return FutureBuilder<List<RecipeModel>>(
      future: recipe.getRecipes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: <Widget>[
              HeaderWithSearchBox(),
              //Trending Recipe, can add any kind of recipes in here
              ListViewOfRecipeCardsWithTitle(
                title: AppLocalizations.of(context).trend,
                cards: snapshot.data,
              ),
            ],
          );
        } else if (snapshot.connectionState == ConnectionState.none) {
          return Container(child: Center(child: Text("No data")));
        }
        return Container(child: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
