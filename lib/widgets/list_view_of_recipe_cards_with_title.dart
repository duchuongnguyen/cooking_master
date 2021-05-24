import 'package:cooking_master/models/recipe_model.dart';
import 'ListCards/title_with_custom_underline.dart';
import 'package:flutter/material.dart';

import 'ListCards/list_view_of_recipe_cards.dart';

class ListViewOfRecipeCardsWithTitle extends StatelessWidget {
  const ListViewOfRecipeCardsWithTitle({
    Key key,
    @required this.cards,
    @required this.title,
  }) : super(key: key);

  final List<RecipeModel> cards;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWithCustomUnderline(text: title),
        ListViewOfRecipeCards(cards: cards),
      ],
    );
  }
}
