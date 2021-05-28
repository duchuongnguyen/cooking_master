import 'package:cooking_master/models/model-recipe-cuahuy.dart';
import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/services/user_save_recipe.dart';
import 'package:flutter/cupertino.dart';

class SavedRecipeProvider with ChangeNotifier {
  FirebaseUserSaveRecipe _saveRecipeService = FirebaseUserSaveRecipe();
  Map<String, List<RecipeModel>>
      _mapSavedRecipe; //= new Map<String, List<RecipeCardModelcuahuy>>();

  loadMapRecipe() async {
    _mapSavedRecipe = await _saveRecipeService.getmaprecipe();
    notifyListeners();
  }

  Map<String, List<RecipeModel>> get mapSavedRecipe =>
      _mapSavedRecipe;

  removeRecipe() {
    _mapSavedRecipe.forEach((key, value) {
      value.removeWhere((element) => element.isSelected == true);
      if (value.isEmpty) _mapSavedRecipe.remove(key);
    });
    notifyListeners();
  }

  setUnselected() {
    _mapSavedRecipe.forEach((key, value) {
      value.forEach((element) {
        element.isSelected = false;
      });
    });
    notifyListeners();
  }

  removeCategory(String keyy) {
    _mapSavedRecipe.removeWhere((key, value) => key == keyy);
    notifyListeners();
  }
}
