import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/screens/RecipeDetail/recipe_detail_screen.dart';
import 'package:cooking_master/screens/Search/recipe_search_item.dart';
import 'package:cooking_master/screens/recipe_form/recipe_form_screen.dart';
import 'package:cooking_master/services/recipe_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

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

    return RefreshIndicator(
        child: StreamBuilder<List<RecipeModel>>(
            stream: Stream.fromFuture(RecipeService()
                .getRecipesByOwner(FirebaseAuth.instance.currentUser.uid)),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return StaggeredGridView.countBuilder(
                    staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                    padding: EdgeInsets.only(
                        top: 15, left: 10, right: 10, bottom: 30),
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    crossAxisCount: 2,
                    itemCount: snapshot.data.length,
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
                                        currentRecipe: snapshot.data[index],
                                      );
                                    },
                                  ),
                                );
                              },
                              trailingIcon: Icon(Icons.edit_outlined)),
                          FocusedMenuItem(
                              title: Text("Delete"),
                              onPressed: () {
                                RecipeService()
                                    .deleteRecipe(snapshot.data[index]);
                                setState(() {});
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
                                        recipe: snapshot.data[index])));
                          },
                          child: RecipeSearchItem(
                              image: snapshot.data[index].image,
                              name: snapshot.data[index].name),
                        ),
                      );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
        onRefresh: onRefresh);
  }
}
