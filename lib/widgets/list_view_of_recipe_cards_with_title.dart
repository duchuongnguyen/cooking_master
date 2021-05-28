import 'package:cooking_master/models/recipe_model.dart';
import 'ListCards/title_with_custom_underline.dart';
import 'package:flutter/material.dart';

import 'ListCards/list_view_of_recipe_cards.dart';

class ListViewOfRecipeCardsWithTitle extends StatelessWidget {

   ListViewOfRecipeCardsWithTitle(
      {Key key,
      this.size,
      @required this.cards,
      @required this.title,
      this.action,
      this.isEditing,
      this.parent})
      : super(key: key);
   final List<RecipeModel> cards;
  Size size;
  final String title; 
  // ignore: avoid_init_to_null
  Widget action;
  bool isEditing = false;
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
