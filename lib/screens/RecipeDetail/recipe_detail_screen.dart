import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/screens/RecipeDetail/preparation_step_list.dart';
import 'package:cooking_master/screens/RecipeDetail/preparation_title.dart';
import 'package:cooking_master/screens/RecipeDetail/related_recipes.dart';
import 'package:cooking_master/screens/RecipeDetail/sliver_ingredient_list.dart';
import 'package:flutter/material.dart';
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
  List<String> _dynamicTopics;

  @override
  void initState() {
    super.initState();
    _dynamicTopics = [
      '#1 cooking recipe this week',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverRecipeAppbar(
              recipe: widget.recipe, dynamicTopics: _dynamicTopics),
          RecipeImageAndAuthor(recipe: widget.recipe),
          buildIngredientTabBar(),
          SliverIngredientList(ingredientList: widget.recipe.ingredients),
          RecipeTip(recipe: widget.recipe),
          RelatedRecipes(),
          PreparationTitle(),
          widget.recipe.directions.isNotEmpty &&
                  widget.recipe.directions != null
              ? PreparationStepList(recipe: widget.recipe)
              : SizedBox(),
        ],
      ),
    );
  }

  SliverPadding buildIngredientTabBar() {
    return SliverPadding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10),
        sliver: SliverList(
            delegate: SliverChildListDelegate(
          <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ingredients for",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  widget.recipe.yields.toString() + " servings",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        )));
  }
}
