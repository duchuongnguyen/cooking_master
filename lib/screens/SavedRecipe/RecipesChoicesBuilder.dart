import 'package:cooking_master/models/recipe_card_model.dart';
import 'package:cooking_master/screens/Search/recipe_search_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
                      //Add recipe into category
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
            itemCount: cards.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (cards[index].isSelected == false) {
                      isCheck = true;
                      selectedCount++;
                    } else {
                      selectedCount--;
                    }
                    cards[index].isSelected = !cards[index].isSelected;
                  });
                },
                child: RecipeSearchItem(
                  image: cards[index].image,
                  name: cards[index].recipeName,
                  isSelected: cards[index].isSelected,
                ),
              );
            }),
      ),
    );
  }
}
