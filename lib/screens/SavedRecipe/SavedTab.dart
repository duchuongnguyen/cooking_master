import 'package:cooking_master/notifier/user_saved_recipe.dart';
import 'package:cooking_master/widgets/list_view_of_recipe_cards_with_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedTab extends StatefulWidget {
  const SavedTab({
    Key key,
  }) : super(key: key);
  @override
  SavedTabState createState() => SavedTabState();
}

class SavedTabState extends State<SavedTab> {
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
                    ),
                    SizedBox(height: 10),
                  ],
                );
              }),
          onRefresh: onRefresh);
    }));
  }
}

// class CategoryPopupMenu extends StatelessWidget {
//   CategoryPopupMenu({
//     this.onDelete,
//     this.keyitem,
//   });
//   VoidCallback onDelete;
//   final keyitem;
//   @override
//   Widget build(BuildContext context) {
//     final db = Provider.of<SavedRecipeProvider>(context, listen: false);
//     return PopupMenuButton(
//       child: Icon(Icons.more_horiz),
//       itemBuilder: (context) {
//         return [
//           PopupMenuItem(
//             child: Text('Add recipe'),
//             value: 'Add',
//           ),
//           PopupMenuItem(
//             child: Text('Delete Category'),
//             value: 'Delete',
//           ),
//         ];
//       },
//       onSelected: (value) {
//         switch (value) {
//           case 'Delete':
//             {
//               //db.removeCategory(keyitem);
//               onDelete();
//             }
//             break;
//           default:
//         }
//       },
//     );
//   }
// }
