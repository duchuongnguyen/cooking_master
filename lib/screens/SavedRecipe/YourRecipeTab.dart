import 'package:cooking_master/notifier/user_saved_recipe.dart';
import 'package:cooking_master/widgets/list_view_of_recipe_cards_with_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YourRecipeTab extends StatefulWidget {
  const YourRecipeTab({
    Key key,
  }) : super(key: key);
  @override
  YourRecipeTabState createState() => YourRecipeTabState();
}

class YourRecipeTabState extends State<YourRecipeTab> {
  @override
  Widget build(BuildContext context) {
    Future<void> onRefresh() async {
      setState(() {});
    }

    return Container(child:
        Consumer<SavedRecipeProvider>(builder: (context, recipelist, child) {
      return RefreshIndicator(
          child: ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: recipelist.mapSavedRecipe.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    index == 0 ? SizedBox(height: 20) : SizedBox(height: 0),
                    ListViewOfRecipeCardsWithTitle(
                      title: recipelist.mapSavedRecipe.keys.elementAt(index),
                      size: MediaQuery.of(context).size,
                      cards: recipelist.mapSavedRecipe.values.elementAt(index),
                      action: Row(
                        children: [
                          // CategoryPopupMenu(
                          //   keyitem: recipelist.mapSavedRecipe.keys.elementAt(index),
                          //   onDelete: () => onRefresh(),
                          // ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      isEditing: true,
                    ),
                    SizedBox(height: 10),
                  ],
                );
              }),
          onRefresh: onRefresh);
    }));
  }
}