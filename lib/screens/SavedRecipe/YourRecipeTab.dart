import 'package:cooking_master/models/recipe_card_model.dart';
import 'package:cooking_master/notifier/user_saved_recipe.dart';
import 'package:cooking_master/screens/RecipeDetail/recipe_detail_screen.dart';
import 'package:cooking_master/screens/Search/recipe_search_item.dart';
import 'package:cooking_master/screens/recipe_form/recipe_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
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
          // child: ListView.separated(
          //     separatorBuilder: (context, index) => Divider(),
          //     itemCount: recipelist.mapSavedRecipe.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       return Column(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           index == 0 ? SizedBox(height: 20) : SizedBox(height: 0),
          //           ListViewOfRecipeCardsWithTitle(
          //             title: recipelist.mapSavedRecipe.keys.elementAt(index),
          //             size: MediaQuery.of(context).size,
          //             cards: recipelist.mapSavedRecipe.values.elementAt(index),
          //             action: Row(
          //               children: [
          //                 // CategoryPopupMenu(
          //                 //   keyitem: recipelist.mapSavedRecipe.keys.elementAt(index),
          //                 //   onDelete: () => onRefresh(),
          //                 // ),
          //                 SizedBox(
          //                   width: 10,
          //                 ),
          //               ],
          //             ),
          //             isEditing: true,
          //           ),
          //           SizedBox(height: 10),
          //         ],
          //       );
          //     }),
          child: StaggeredGridView.countBuilder(
              staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              padding:
                  EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 30),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              crossAxisCount: 2,
              itemCount: recipelist.mapSavedRecipe.values.elementAt(0).length,
              itemBuilder: (context, index) {
                return FocusedMenuHolder(
                  menuWidth: MediaQuery.of(context).size.width * 0.5,
                  menuItems: [
                    FocusedMenuItem(
                        title: Text("Edit"),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return RecipeFormScreen(
                                  isUpdating: true,
                                  currentRecipe: recipelist
                                      .mapSavedRecipe.values
                                      .elementAt(0)[index],
                                );
                              },
                            ),
                          );
                        },
                        trailingIcon: Icon(Icons.edit_outlined)),
                    FocusedMenuItem(
                        title: Text("Delete"),
                        onPressed: () {
                          recipelist.mapSavedRecipe.values
                              .elementAt(0)
                              .removeAt(index);
                          setState(() {
                            //cards.removeAt(index);
                            //db.mapSavedRecipe
                          });
                        },
                        trailingIcon: Icon(Icons.delete_outline)),
                  ],
                  blurBackgroundColor: Colors.grey[900],
                  menuOffset: 20,
                  openWithTap: false,
                  onPressed: () {},
                  duration: Duration(seconds: 0),
                  animateMenuItems: false,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecipeDetailScreen(
                                    recipe: recipelist.mapSavedRecipe.values
                                        .elementAt(0)[index],
                                  )));
                    },
                    child: RecipeSearchItem(
                        image: recipelist.mapSavedRecipe.values
                            .elementAt(0)[index]
                            .image,
                        name: recipelist.mapSavedRecipe.values
                            .elementAt(0)[index]
                            .name),
                  ),
                );
              }),
          onRefresh: onRefresh);
    }));
  }
}
