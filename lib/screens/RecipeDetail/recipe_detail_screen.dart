import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/screens/RecipeDetail/SaveRecipeDrawer/add_category_drawer.dart';
import 'package:cooking_master/screens/RecipeDetail/preparation_step_list.dart';
import 'package:cooking_master/screens/RecipeDetail/preparation_title.dart';
import 'package:cooking_master/screens/RecipeDetail/related_recipes.dart';
import 'package:cooking_master/screens/RecipeDetail/sliver_ingredient_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'recipe_image_and_author.dart';
import 'recipe_tip.dart';
import 'sliver_recipe_appbar.dart';

class RecipeDetailScreen extends StatefulWidget {
  final RecipeModel recipe;

  const RecipeDetailScreen({Key key, @required this.recipe}) : super(key: key);

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //systemNavigationBarColor: Colors.blue,
      statusBarColor: Colors.transparent,
      //statusBarBrightness: Brightness.dark,
    ));
  }

  Color currentColor = Colors.black54;

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      borderRadius: 20.0,
      key: _innerDrawerKey,
      onTapClose: false,
      tapScaffoldEnabled: true,
      velocity: 20,
      swipeChild: true,
      scale: IDOffset.horizontal(0.9),
      offset: IDOffset.horizontal(0.6),
      swipe: true,
      colorTransitionChild: Colors.black54,
      colorTransitionScaffold: Colors.black87,
      rightAnimationType: InnerDrawerAnimation.linear,
      rightChild: AddCategoryDrawer(idRecipe: widget.recipe.id),
      scaffold: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 0.0,
          elevation: 0.0,
          backgroundColor: Colors.cyan[100],
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            end: Alignment.topRight,
            begin: Alignment.bottomLeft,
            colors: [
              Colors.indigo[100],
              Colors.cyan[200],
            ],
          )),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverRecipeAppbar(
                recipe: widget.recipe,
                innerDrawerKey: _innerDrawerKey,
              ),
              RecipeImageAndAuthor(recipe: widget.recipe),
              buildIngredientTabBar(),
              SliverIngredientList(
                ingredientList: widget.recipe.ingredients,
              ),
              RecipeTip(recipe: widget.recipe),
              RelatedRecipes(),
              PreparationTitle(recipe: widget.recipe),
              PreparationStepList(recipe: widget.recipe)
            ],
          ),
        ),
      ),
    );
  }

  SliverPadding buildIngredientTabBar() {
    return SliverPadding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 15),
        sliver: SliverList(
            delegate: SliverChildListDelegate(
          <Widget>[
            Text(
              "Time",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.42,
                  decoration: BoxDecoration(
                      color: Colors.amber[400],
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                        end: Alignment.topRight,
                        begin: Alignment.bottomLeft,
                        colors: [
                          Colors.indigo,
                          Colors.cyan,
                        ],
                      )),
                  child: Row(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.2)),
                        alignment: Alignment.center,
                        child: Text(
                          widget.recipe.prepTime.toString(),
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        margin: EdgeInsets.only(left: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Prepare",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 1),
                            Text(
                              "mins",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.42,
                  decoration: BoxDecoration(
                      color: Colors.amber[400],
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                        end: Alignment.topRight,
                        begin: Alignment.bottomLeft,
                        colors: [
                          Colors.deepOrange,
                          Colors.red[200],
                        ],
                      )),
                  child: Row(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.2)),
                        alignment: Alignment.center,
                        child: Text(
                          widget.recipe.cookTime.toString(),
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        margin: EdgeInsets.only(left: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cooking",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 1),
                            Text(
                              "mins",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Ingredients",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 22,
                      color: Colors.black.withOpacity(0.7),
                    ),
                    Text(
                      " " +
                          widget.recipe.yields.toString() +
                          (widget.recipe.yields > 1 ? " servings" : " serving"),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        )));
  }
}
