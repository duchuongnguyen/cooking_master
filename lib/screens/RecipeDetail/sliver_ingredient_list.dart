import 'package:cooking_master/models/ingredient_model.dart';
import 'package:cooking_master/screens/RecipeDetail/ingredient_item.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../recipe_detail_screen.dart';

class SliverIngredientList extends StatelessWidget {
  const SliverIngredientList({
    Key key,
    @required this.servings,
    @required this.widget,
  }) : super(key: key);

  final int servings;
  final RecipeDetailScreen widget;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final int itemIndex = index ~/ 2;
            if (index.isEven) {
              // return Ingredient(
              //     name: ingredient[itemIndex].ingredientName,
              //     amount: ingredient[itemIndex].ingredientAmount,
              //     unit: ingredient[itemIndex].ingredientUnit,
              //     proportion: servings / widget.recipe.recipeServingNumber);
            }
            return SizedBox(height: 5);
          },
          semanticIndexCallback: (Widget widget, int localIndex) {
            if (localIndex.isEven) {
              return localIndex ~/ 2;
            }
            return null;
          },
          childCount: math.max(0, ingredient.length * 2 - 1),
        ),
      ),
    );
  }
}
