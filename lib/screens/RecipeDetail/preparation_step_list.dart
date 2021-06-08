import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/screens/RecipeDetail/preparation_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class PreparationStepList extends StatelessWidget {
  final RecipeModel recipe;

  const PreparationStepList({
    Key key,
    @required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final int itemIndex = (index) ~/ 2;
            if (index.isEven) {
              return Ink(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: blue5),
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  splashColor: blue4,
                  highlightColor: blue4,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PreparationScreen(
                                startIndex: itemIndex,
                                directions: recipe.directions)));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            (itemIndex + 1).toString(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 9,
                          child: Text(
                            recipe.directions[itemIndex],
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            return SizedBox(height: 10);
          },
          semanticIndexCallback: (Widget widget, int localIndex) {
            if (localIndex.isEven) {
              return localIndex ~/ 2;
            }
            return null;
          },
          childCount: math.max(0, recipe.directions.length * 2 - 1),
        ),
      ),
    );
  }
}
