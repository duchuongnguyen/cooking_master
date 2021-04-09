import 'dart:collection';
import 'package:cooking_master/models/recipe_model.dart';
import 'package:flutter/cupertino.dart';

class RecipeNotifier with ChangeNotifier {
  List<Recipe> _recipeList = [];
  Recipe _currentRecipe;

  UnmodifiableListView<Recipe> get recipeList => UnmodifiableListView(_recipeList);

  Recipe get currentRecipe => _currentRecipe;

  set recipeList(List<Recipe> recipeList) {
    _recipeList = recipeList;
    notifyListeners();
  }

  set currentRecipe(Recipe recipe) {
    _currentRecipe = recipe;
    notifyListeners();
  }

  addRecipe(Recipe recipe) {
    _recipeList.insert(0, recipe);
    notifyListeners();
  }

  deleteRecipe(Recipe recipe) {
    _recipeList.removeWhere((_recipe) => _recipe.id == recipe.id);
    notifyListeners();
  }
}