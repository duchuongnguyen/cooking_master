import 'package:cooking_master/models/recipe_card_model.dart';
import 'package:cooking_master/widgets/list_view_of_recipe_cards_with_title.dart';
import 'package:flutter/material.dart';

class RelatedRecipes extends StatelessWidget {
  const RelatedRecipes({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: EdgeInsets.only(left: 10.0, right: 20.0, bottom: 30),
        sliver: SliverList(
            delegate: SliverChildListDelegate(<Widget>[
          ListViewOfRecipeCardsWithTitle(
              size: MediaQuery.of(context).size * 0.9,
              cards: cards,
              title: "Related Recipes"),
        ])));
  }
}