import 'package:flutter/material.dart';
import 'dart:math' as math;

class SliverIngredientList extends StatelessWidget {
  final List<String> ingredientList;

  const SliverIngredientList({
    Key key,
    @required this.ingredientList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final int itemIndex = index ~/ 2;
            if (index.isEven) {
              return Text("${ingredientList[itemIndex]}");
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
          childCount: math.max(0, ingredientList.length * 2 - 1),
        ),
      ),
    );
  }
}
