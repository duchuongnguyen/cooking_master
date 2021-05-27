import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/models/model-recipe-cuahuy.dart';
import 'package:cooking_master/models/recipe_card_model.dart';
import 'package:cooking_master/notifier/user_saved_recipe.dart';
import 'package:cooking_master/widgets/list_view_of_recipe_cards_with_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'SearchBox.dart';

class SavedTab extends StatefulWidget {
  const SavedTab({
    Key key,
    this.parent,
  }) : super(key: key);
  final parent;
  @override
  SavedTabState createState() => SavedTabState();
}

class SavedTabState extends State<SavedTab> {
  var map = new Map<String, List<RecipeCardModelcuahuy>>();

  @override
  initState() {
    SavedRecipeProvider db =
        Provider.of<SavedRecipeProvider>(context, listen: false);
    //db.loadMapRecipe();
    map = db.mapSavedRecipe;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SavedRecipeProvider db =
        Provider.of<SavedRecipeProvider>(context, listen: false);
    Future<void> onRefresh() async {
      setState(() {});
    }

    if (db.mapSavedRecipe.length == 0) return Scaffold();
    //map = db.mapSaveRecipe;
    return RefreshIndicator(
        child: ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: db.mapSavedRecipe.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  index == 0 ? SearchBox() : SizedBox(height: 0),
                  ListViewOfRecipeCardsWithTitle(
                    title: db.mapSavedRecipe.keys.elementAt(index),
                    size: MediaQuery.of(context).size,
                    cards: db.mapSavedRecipe.values.elementAt(index),
                    action: Row(
                      children: [
                        CategoryPopupMenu(
                          keyitem: db.mapSavedRecipe.keys.elementAt(index),
                          onDelete: () => onRefresh(),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    isEditing: widget.parent.isEditing,
                    parent: widget.parent,
                  ),
                  SizedBox(height: 10),
                ],
              );
            }),
        onRefresh: onRefresh);
  }
}

class CategoryPopupMenu extends StatelessWidget {
   CategoryPopupMenu({
    this.onDelete,
    this.keyitem,
  });
 VoidCallback onDelete;
  final keyitem;
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<SavedRecipeProvider>(context, listen: false);
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
            {
              db.removeCategory(keyitem);
              onDelete();
            }
            break;
          default:
        }
      },
    );
  }
}
