import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/notifier/recipes_notifier.dart';
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
    final recipe = Provider.of<RecipeNotifier>(context, listen: false);
    if (recipe.listrecipes.isNotEmpty)
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            HeaderWithSearchBox(),
            //Trending Recipe, can add any kind of recipes in here
            ListViewOfRecipeCardsWithTitle(
              title: AppLocalizations.of(context).trend,
              cards: recipe.listrecipes.take(10).toList(),
            ),
            SizedBox(height: 20),
            ListViewOfRecipeCardsWithTitle(
              title: 'Pasta',
              cards: recipe.listrecipes
                  .where((element) => element.category == 'pasta')
                  .take(10)
                  .toList(),
            ),
            SizedBox(height: 20),
            ListViewOfRecipeCardsWithTitle(
              title: 'Beef',
              cards: recipe.listrecipes
                  .where((element) => element.category == 'beef')
                  .take(10)
                  .toList(),
            ),
            SizedBox(height: 20),
            ListViewOfRecipeCardsWithTitle(
              title: 'Rice',
              cards: recipe.listrecipes
                  .where((element) => element.category == 'rice')
                  .take(10)
                  .toList(),
            ),
            SizedBox(height: 20),
            ListViewOfRecipeCardsWithTitle(
              title: 'Cake',
              cards: recipe.listrecipes
                  .where((element) => element.category == 'cake')
                  .take(10)
                  .toList(),
            ),
            SizedBox(height: 20),
            ListViewOfRecipeCardsWithTitle(
              title: 'Soup',
              cards: recipe.listrecipes
                  .where((element) => element.category == 'soup')
                  .take(10)
                  .toList(),
            ),
            SizedBox(height: 20),
            ListViewOfRecipeCardsWithTitle(
              title: 'Bread',
              cards: recipe.listrecipes
                  .where((element) => element.category == 'bread')
                  .take(10)
                  .toList(),
            ),
            SizedBox(height: 20),
            ListViewOfRecipeCardsWithTitle(
              title: 'Sauce',
              cards: recipe.listrecipes
                  .where((element) => element.category == 'sauce')
                  .take(10)
                  .toList(),
            ),
            SizedBox(height: 20),
            ListViewOfRecipeCardsWithTitle(
              title: 'Chicken',
              cards: recipe.listrecipes
                  .where((element) => element.category == 'chicken')
                  .take(10)
                  .toList(),
            ),
            SizedBox(height: 20),
            ListViewOfRecipeCardsWithTitle(
              title: 'Fish',
              cards: recipe.listrecipes
                  .where((element) => element.category == 'fish')
                  .take(10)
                  .toList(),
            ),
          ],
        ),
      );
    return Scaffold();
  }
}
