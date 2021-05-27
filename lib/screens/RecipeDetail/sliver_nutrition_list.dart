import 'package:cooking_master/models/nutrition_model.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SliverNutritionList extends StatelessWidget {
  const SliverNutritionList({
    Key key,
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
              return Container(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      nutrition[itemIndex].nutritionName,
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      nutrition[itemIndex].nutritionAmount,
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              );
            }
            return Divider(height: 0, color: Colors.grey);
          },
          semanticIndexCallback: (Widget widget, int localIndex) {
            if (localIndex.isEven) {
              return localIndex ~/ 2;
            }
            return null;
          },
          childCount: math.max(0, nutrition.length * 2 - 1),
        ),
      ),
    );
  }
}
