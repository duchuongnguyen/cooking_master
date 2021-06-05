import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/models/tip_model.dart';
import 'package:cooking_master/screens/RecipeDetail/AllTips/add_tip_fab.dart';
import 'package:cooking_master/screens/RecipeDetail/AllTips/tip.dart';
import 'package:cooking_master/widgets/CustomBackButton.dart';
import 'package:flutter/material.dart';

class AllTipsScreen extends StatelessWidget {
  final RecipeModel recipe;
  final List<TipModel> listTip;

  const AllTipsScreen({
    Key key,
    @required this.recipe,
    @required this.listTip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTipAppBar(context),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            if (index == listTip.length - 1)
              return Column(children: [
                Tip(recipe: recipe, tip: listTip[index]),
                SizedBox(height: 50),
              ]);
            else
              return Tip(recipe: recipe, tip: listTip[index]);
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: listTip.length),
      floatingActionButton: AddTipFAB(recipe: recipe),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  AppBar buildTipAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        "${listTip.length.toString()} tips", //Todo: Update tips count from database
        style: TextStyle(color: blue1, fontWeight: FontWeight.bold),
      ),
      leading: CustomBackButton(
        tapEvent: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
