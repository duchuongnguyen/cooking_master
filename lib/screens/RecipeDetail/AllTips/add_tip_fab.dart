import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/screens/RecipeDetail/add_tip_screen.dart';
import 'package:cooking_master/screens/RecipeDetail/recipe_detail_screen.dart';
import 'package:flutter/material.dart';

class AddTipFAB extends StatelessWidget {
  final RecipeModel recipe;

  const AddTipFAB({
    Key key,
    @required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddTipScreen(recipe: recipe)));
        },
        label: Text("Add Tip"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        foregroundColor: Colors.white,
        backgroundColor: blue2,
        icon: Icon(Icons.add));
  }
}
