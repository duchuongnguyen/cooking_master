import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/models/model-recipe-cuahuy.dart';
import 'package:cooking_master/models/nton_user_saved_recipe.dart';
import 'package:cooking_master/models/recipe_card_model.dart';
import 'package:cooking_master/services/user_save_recipe.dart';
import 'package:cooking_master/widgets/list_view_of_recipe_cards_with_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'SearchBox.dart';

class SavedTab extends StatelessWidget {
  const SavedTab({
    Key key,
    this.parent,
  }) : super(key: key);
  final parent;

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<FirebaseUserSaveRecipe>(context, listen: false);
    var map = new Map<String, List<RecipeCardModelcuahuy>>();
    return Scaffold(
        body: StreamBuilder<Map<String, List<RecipeCardModelcuahuy>>>(
            stream: db.mapListCardStream(),
            builder: (context, snapshot2) {
              if (snapshot2.hasData) {
                map = snapshot2.data;
                print(map);
                return ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: map.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          index == 0 ? SearchBox() : SizedBox(height: 0),
                          ListViewOfRecipeCardsWithTitle(
                            title: map.keys.elementAt(index),
                            size: MediaQuery.of(context).size,
                            cards: map.values.elementAt(index),
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
                      );
                    });
              }
              return LinearProgressIndicator();
            }));
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
