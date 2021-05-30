import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/services/recipe_service.dart';
import 'package:flutter/cupertino.dart';

class RecipeNotifier extends ChangeNotifier {
  RecipeService _recipeService = RecipeService();
  List<RecipeModel> _listrecipes;

  List<RecipeModel> get listrecipes => _listrecipes;
  loadListRecipes() async {
    _listrecipes = await _recipeService.getRecipes();
    notifyListeners();
  }
}
