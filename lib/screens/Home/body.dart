import 'package:cooking_master/notifier/mytopics_notifier.dart';
import 'package:cooking_master/notifier/recipes_notifier.dart';
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
    final myFavoriteTopic =
        Provider.of<MyTopicsNotifier>(context, listen: false);
    var lenght = myFavoriteTopic.myTopicsString.length;
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
              title: lenght-- <= 0
                  ? 'Pasta'
                  : toUpcaseFist(myFavoriteTopic.myTopicsString[0]),
              cards: recipe.listrecipes
                  .where((element) =>
                      element.category ==
                      (lenght < 0
                          ? 'pasta'
                          : myFavoriteTopic.myTopicsString[0]))
                  .take(10)
                  .toList(),
            ),
            SizedBox(height: 20),
            ListViewOfRecipeCardsWithTitle(
              title: lenght-- <= 0
                  ? 'Beef'
                  : toUpcaseFist(myFavoriteTopic.myTopicsString[1]),
              cards: recipe.listrecipes
                  .where((element) =>
                      element.category ==
                      (lenght < 0 ? 'beef' : myFavoriteTopic.myTopicsString[1]))
                  .take(10)
                  .toList(),
            ),
            SizedBox(height: 20),
            ListViewOfRecipeCardsWithTitle(
              title: lenght-- < 0
                  ? 'Rice'
                  : toUpcaseFist(myFavoriteTopic.myTopicsString[2]),
              cards: recipe.listrecipes
                  .where((element) =>
                      element.category ==
                      (lenght <= 0
                          ? 'rice'
                          : myFavoriteTopic.myTopicsString[2]))
                  .take(10)
                  .toList(),
            ),
            SizedBox(height: 20),
            ListViewOfRecipeCardsWithTitle(
              title: lenght-- <= 0
                  ? 'Cake'
                  : toUpcaseFist(myFavoriteTopic.myTopicsString[3]),
              cards: recipe.listrecipes
                  .where((element) =>
                      element.category ==
                      (lenght < 0 ? 'cake' : myFavoriteTopic.myTopicsString[3]))
                  .take(10)
                  .toList(),
            ),
            SizedBox(height: 20),
            ListViewOfRecipeCardsWithTitle(
              title: lenght-- <= 0
                  ? 'Soup'
                  : toUpcaseFist(myFavoriteTopic.myTopicsString[4]),
              cards: recipe.listrecipes
                  .where((element) =>
                      element.category ==
                      (lenght < 0 ? 'soup' : myFavoriteTopic.myTopicsString[4]))
                  .take(10)
                  .toList(),
            ),
            SizedBox(height: 20),
            ListViewOfRecipeCardsWithTitle(
              title: lenght-- <= 0
                  ? 'Bread'
                  : toUpcaseFist(myFavoriteTopic.myTopicsString[5]),
              cards: recipe.listrecipes
                  .where((element) =>
                      element.category ==
                      (lenght < 0
                          ? 'bread'
                          : myFavoriteTopic.myTopicsString[5]))
                  .take(10)
                  .toList(),
            ),
            SizedBox(height: 20),
            ListViewOfRecipeCardsWithTitle(
              title: lenght-- <= 0
                  ? 'Sauce'
                  : toUpcaseFist(myFavoriteTopic.myTopicsString[6]),
              cards: recipe.listrecipes
                  .where((element) =>
                      element.category ==
                      (lenght < 0
                          ? 'sauce'
                          : myFavoriteTopic.myTopicsString[6]))
                  .take(10)
                  .toList(),
            ),
            SizedBox(height: 20),
            ListViewOfRecipeCardsWithTitle(
              title: lenght-- <= 0
                  ? 'Chicken'
                  : toUpcaseFist(myFavoriteTopic.myTopicsString[7]),
              cards: recipe.listrecipes
                  .where((element) =>
                      element.category ==
                      (lenght < 0
                          ? 'chicken'
                          : myFavoriteTopic.myTopicsString[7]))
                  .take(10)
                  .toList(),
            ),
            SizedBox(height: 20),
            ListViewOfRecipeCardsWithTitle(
              title: lenght-- <= 0
                  ? 'Fish'
                  : toUpcaseFist(myFavoriteTopic.myTopicsString[8]),
              cards: recipe.listrecipes
                  .where((element) =>
                      element.category ==
                      (lenght < 0 ? 'fish' : myFavoriteTopic.myTopicsString[8]))
                  .take(10)
                  .toList(),
            ),
          ],
        ),
      );
    return Scaffold();
  }

  String toUpcaseFist(String item) {
    return item[0].toUpperCase() + item.substring(1, item.length);
  }
}
