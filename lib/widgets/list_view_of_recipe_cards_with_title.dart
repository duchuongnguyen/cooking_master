import 'package:cooking_master/models/recipe_card_model.dart';
import 'file:///D:/MyFlutterApplication/cooking_master/widgets/ListCards/title_with_custom_underline.dart';
import 'package:flutter/material.dart';

import 'ListCards/list_view_of_recipe_cards.dart';

class ListViewOfRecipeCardsWithTitle extends StatelessWidget {
  const ListViewOfRecipeCardsWithTitle({
    Key key,
    @required this.size,
    @required this.cards,
    @required this.title,
  }) : super(key: key);

  final Size size;
  final List<RecipeCardModel> cards;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWithCustomUnderline(text: title,),
        ListViewOfRecipeCards(size: size, cards: cards,),
      ],
    );
  }
}
