import 'package:cooking_master/models/recipe_card_model.dart';
import 'package:cooking_master/widgets/list_view_of_recipe_cards_with_title.dart';
import 'package:flutter/material.dart';

import 'SearchBox.dart';

class YourRecipeTab extends StatelessWidget {
  const YourRecipeTab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          SearchBox(),
          SizedBox(height: 10),
          ListViewOfRecipeCardsWithTitle(
            title: "All",
            size: MediaQuery.of(context).size,
            cards: cards,
          ),
          SizedBox(height: 10),
          ListViewOfRecipeCardsWithTitle(
            title: "Easy to cook",
            size: MediaQuery.of(context).size,
            cards: cards,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
