import 'package:cooking_master/screens/SavedRecipe/FavoriteTopicTab.dart';
import 'package:cooking_master/screens/SavedRecipe/YourRecipeTab.dart';
import 'package:flutter/material.dart';
import 'SavedRecipe/AppBar.dart';
import 'SavedRecipe/SavedTab.dart';

class SavedRecipeScreen extends StatefulWidget {
  @override
  SavedRecipeScreenState createState() => SavedRecipeScreenState();
}

class SavedRecipeScreenState extends State<SavedRecipeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  TextEditingController _categoryController;
  bool isEditing;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _categoryController = TextEditingController();
    isEditing = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSavedRecipeAppBar(
          context, _tabController, _categoryController, this),
      body: TabBarView(
          controller: _tabController,
          children: [SavedTab(parent: this), YourRecipeTab(), FavoriteTopic()]),
    );
  }
}
