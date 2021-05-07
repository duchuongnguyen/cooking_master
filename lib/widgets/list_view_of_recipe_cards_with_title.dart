import 'package:cooking_master/models/model-recipe-cuahuy.dart';
import 'package:cooking_master/models/recipe_card_model.dart';
import 'ListCards/title_with_custom_underline.dart';
import 'package:flutter/material.dart';

import 'ListCards/list_view_of_recipe_cards.dart';

class ListViewOfRecipeCardsWithTitle extends StatelessWidget {
  const ListViewOfRecipeCardsWithTitle(
      {Key key,
      @required this.size,
      @required this.cards,
      @required this.title,
      this.action,
      this.isEditing,
      this.parent})
      : super(key: key);

  final Size size;
  final List<RecipeCardModelcuahuy> cards;
  final String title;
  final Widget action;
  final bool isEditing;
  final parent;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWithCustomUnderline(
          text: title,
          action: action,
        ),
        cards.length == 0
            ? Container()
            : ListViewOfRecipeCards(
                size: size,
                cards: cards,
                action: action,
                isEditing: isEditing,
                parent: parent),
      ],
    );
  }
}
