import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/models/recipe_card_model.dart';
import 'package:cooking_master/widgets/list_view_of_recipe_cards_with_title.dart';
import 'package:flutter/material.dart';

import 'SearchBox.dart';

class SavedTab extends StatelessWidget {
  const SavedTab({
    Key key,
    this.parent,
  }) : super(key: key);
  final parent;

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
            action: Row(
              children: [
                CategoryPopupMenu(parent: parent),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            isEditing: parent.isEditing,
            parent: parent,
          ),
          SizedBox(height: 10),
          ListViewOfRecipeCardsWithTitle(
            title: "Easy to cook",
            size: MediaQuery.of(context).size,
            cards: cards,
            action: Row(
              children: [
                CategoryPopupMenu(parent: parent),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            isEditing: parent.isEditing,
            parent: parent,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class CategoryPopupMenu extends StatelessWidget {
  const CategoryPopupMenu({
    Key key,
    @required this.parent,
  }) : super(key: key);

  final parent;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: Icon(Icons.more_horiz),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: Text('Delete Category'),
            value: 'Delete',
          ),
        ];
      },
      onSelected: (value) {
        switch (value) {
          case 'Delete':
            parent.setState(() {
              //Delete category here
            });
            break;
          default:
        }
      },
    );
  }
}
