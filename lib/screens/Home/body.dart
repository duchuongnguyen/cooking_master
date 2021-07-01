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
            FutureBuilder<List<RecipeModel>>(
              future: RecipeService().getRecipesByCategory('pasta'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListViewOfRecipeCardsWithTitle(
                    title: 'Pasta',
                    cards: snapshot.data,
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            SizedBox(height: 20),
            FutureBuilder<List<RecipeModel>>(
              future: RecipeService().getRecipesByCategory('beef'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListViewOfRecipeCardsWithTitle(
                    title: 'Beef',
                    cards: snapshot.data,
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            SizedBox(height: 20),
            FutureBuilder<List<RecipeModel>>(
              future: RecipeService().getRecipesByCategory('rice'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListViewOfRecipeCardsWithTitle(
                    title: 'Rice',
                    cards: snapshot.data,
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            SizedBox(height: 20),
            FutureBuilder<List<RecipeModel>>(
              future: RecipeService().getRecipesByCategory('cake'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListViewOfRecipeCardsWithTitle(
                    title: 'Cake',
                    cards: snapshot.data,
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            SizedBox(height: 20),
            FutureBuilder<List<RecipeModel>>(
              future: RecipeService().getRecipesByCategory('soup'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListViewOfRecipeCardsWithTitle(
                    title: 'Soup',
                    cards: snapshot.data,
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            SizedBox(height: 20),
            FutureBuilder<List<RecipeModel>>(
              future: RecipeService().getRecipesByCategory('bread'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListViewOfRecipeCardsWithTitle(
                    title: 'Bread',
                    cards: snapshot.data,
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            SizedBox(height: 20),
            FutureBuilder<List<RecipeModel>>(
              future: RecipeService().getRecipesByCategory('sauce'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListViewOfRecipeCardsWithTitle(
                    title: 'Sauce',
                    cards: snapshot.data,
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            SizedBox(height: 20),
            FutureBuilder<List<RecipeModel>>(
              future: RecipeService().getRecipesByCategory('chicken'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListViewOfRecipeCardsWithTitle(
                    title: 'Chicken',
                    cards: snapshot.data,
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            SizedBox(height: 20),
            FutureBuilder<List<RecipeModel>>(
              future: RecipeService().getRecipesByCategory('fish'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListViewOfRecipeCardsWithTitle(
                    title: 'Fish',
                    cards: snapshot.data,
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      );
    return Scaffold();
  }
}
