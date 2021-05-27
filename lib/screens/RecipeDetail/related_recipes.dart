import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/services/recipe_service.dart';
import 'package:cooking_master/widgets/list_view_of_recipe_cards_with_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RelatedRecipes extends StatelessWidget {
  const RelatedRecipes({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recipe = Provider.of<RecipeService>(context, listen: false);

    return FutureBuilder<List<RecipeModel>>(
      future: recipe.getRecipes(),
      builder: (context, snapshot) {
        return SliverPadding(
            padding: EdgeInsets.only(left: 10.0, right: 20.0, bottom: 30),
            sliver: SliverList(
                delegate: SliverChildListDelegate(<Widget>[
              ListViewOfRecipeCardsWithTitle(
                  cards: snapshot.data,
                  title: "Related Recipes"),
            ])));
      }
    );
  }
}
