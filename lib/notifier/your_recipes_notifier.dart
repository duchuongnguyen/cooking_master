import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/services/user_save_recipe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class YourRecipeNotifier with ChangeNotifier {
  List<RecipeModel> _yourRecipe;

  List<RecipeModel> get youRecipes => this._yourRecipe;
  FirebaseUserSaveRecipe _yourService = FirebaseUserSaveRecipe();
  loadYourRecipes() async {
    this._yourRecipe = await _yourService
        .getYourRecipes(FirebaseAuth.instance.currentUser.uid);
    notifyListeners();
  }

  deleteRecipe(int index) {
    _yourService.deleteRecipe(this._yourRecipe.elementAt(index).id);
    this._yourRecipe.removeAt(index);
    notifyListeners();
  }
}
