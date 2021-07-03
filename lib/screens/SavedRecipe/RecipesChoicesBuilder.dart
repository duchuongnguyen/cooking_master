import 'package:cooking_master/models/recipe_card_model.dart';
import 'package:cooking_master/notifier/user_saved_recipe.dart';
import 'package:cooking_master/screens/Search/recipe_search_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class RecipesChoicesBuilder extends StatefulWidget {
  @override
  _RecipesChoicesBuilderState createState() => _RecipesChoicesBuilderState();
}

class _RecipesChoicesBuilderState extends State<RecipesChoicesBuilder> {
  bool isCheck;
  int selectedCount;
  @override
  void initState() {
    super.initState();
    isCheck = false;
    selectedCount = 0;
  }

  ThemeData get theme => Theme.of(context);
  @override
  Widget build(BuildContext context) {
    final savedRecipeNotifier =
        Provider.of<SavedRecipeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: selectedCount > 0
            ? Text("$selectedCount selected")
            : Text("Choose recipe"),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        actions: selectedCount > 0
            ? [
                GestureDetector(
                    onTap: () {
                      savedRecipeNotifier.updateListRecipe();
                      Navigator.pop(context);
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 7),
                        child: Icon(Icons.check)))
              ]
            : [Container()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StaggeredGridView.countBuilder(
            staggeredTileBuilder: (index) => StaggeredTile.fit(1),
            padding: EdgeInsets.only(top: 80, left: 10, right: 10, bottom: 30),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            crossAxisCount: 2,
            itemCount: savedRecipeNotifier.mapSavedRecipe['All'].length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (savedRecipeNotifier.mapSavedRecipe['All']
                            .elementAt(index)
                            .isSelected ==
                        false) {
                      isCheck = true;
                      selectedCount++;
                    } else {
                      selectedCount--;
                    }
                    String id = savedRecipeNotifier.mapSavedRecipe['All']
                        .elementAt(index)
                        .id;
                    savedRecipeNotifier.setSelected(id);
                  });
                },
                child: RecipeSearchItem(
                  image: savedRecipeNotifier.mapSavedRecipe['All']
                      .elementAt(index)
                      .image,
                  name: savedRecipeNotifier.mapSavedRecipe['All']
                      .elementAt(index)
                      .name,
                  isSelected: savedRecipeNotifier.mapSavedRecipe['All']
                      .elementAt(index)
                      .isSelected,
                ),
              );
            }),
      ),
    );
  }
}
