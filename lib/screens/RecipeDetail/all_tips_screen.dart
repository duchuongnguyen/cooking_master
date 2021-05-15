import 'package:cooking_master/models/recipe_card_model.dart';
import 'package:cooking_master/models/tip_model.dart';
import 'package:cooking_master/screens/RecipeDetail/AllTips/add_tip_fab.dart';
import 'package:cooking_master/screens/RecipeDetail/AllTips/tip.dart';
import 'package:cooking_master/screens/RecipeDetail/AllTips/tip_appbar.dart';
import 'package:flutter/material.dart';

class AllTipsScreen extends StatelessWidget {
  final RecipeCardModel recipe;

  const AllTipsScreen({Key key, @required this.recipe}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTipAppBar(context),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            if (index == tips.length - 1)
              return Column(children: [
                Tip(tip: tips[index]),
                SizedBox(
                  height: 50,
                )
              ]);
            else
              return Tip(tip: tips[index]);
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: tips.length),
      floatingActionButton: AddTipFAB(recipe: recipe),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
