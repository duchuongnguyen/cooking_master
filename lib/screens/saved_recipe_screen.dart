import 'package:cooking_master/screens/SavedRecipe/FavoriteTopicTab.dart';
import 'package:cooking_master/screens/SavedRecipe/YourRecipeTab.dart';
import 'package:flutter/material.dart';
import 'SavedRecipe/AppBar.dart';
import 'SavedRecipe/SavedTab.dart';

class SavedRecipeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: buildSavedRecipeAppBar(context),
        body: TabBarView(
            children: [SavedTab(), YourRecipeTab(), FavoriteTopic()]),
      ),
    );
  }
}
