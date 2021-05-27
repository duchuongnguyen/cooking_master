import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/screens/RecipeDetail/add_tip_screen.dart';
import 'package:cooking_master/screens/recipe_detail_screen.dart';
import 'package:flutter/material.dart';

class AddTipFAB extends StatelessWidget {
  const AddTipFAB({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddTipScreen()));
        },
        label: Text("Add Tip"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        foregroundColor: Colors.white,
        backgroundColor: blue2,
        icon: Icon(Icons.add));
  }
}
