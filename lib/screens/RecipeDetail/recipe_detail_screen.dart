import 'package:cooking_master/constants/color_constant.dart';
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 0.0,
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: CustomScrollView(
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
            PreparationTitle(),
            PreparationStepList(
              recipe: widget.recipe,
            )
          ],
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Ingredients for",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 16,
                        ),
                        Text(
                          " " + widget.recipe.yields.toString() + " servings",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Prep time",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_outlined,
                          size: 16,
                        ),
                        Text(
                          " " + widget.recipe.prepTime.toString() + " mins",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Cook time",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_outlined,
                          size: 16,
                        ),
                        Text(
                          " " + widget.recipe.cookTime.toString() + " mins",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        )));
  }
}
