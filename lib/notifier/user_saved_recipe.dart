import 'package:cooking_master/models/nton_user_saved_recipe.dart';
import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/services/user_save_recipe.dart';
import 'package:flutter/cupertino.dart';

class SavedRecipeProvider with ChangeNotifier {
  FirebaseUserSaveRecipe _saveRecipeService = FirebaseUserSaveRecipe();
  Map<String, List<RecipeModel>> _mapSavedRecipe = Map();
  List<NtoNUserSavedRecipe> _listMyCategory = [];
  String _curCategoryName;
  List<RecipeModel> _curCategoryList = [];
  List<NtoNUserSavedRecipe> get listMyCategory => this._listMyCategory;
  // ignore: non_constant_identifier_names
  set CurCategoryList(List<RecipeModel> list) {
    this._curCategoryList = list;
  }

  List<RecipeModel> get curCategoryList => this._curCategoryList;

  String get curCategoryName => this._curCategoryName;
  Map<String, List<RecipeModel>> get mapSavedRecipe => _mapSavedRecipe;
  // load for render
  loadMapRecipe() async {
    this._mapSavedRecipe = await _saveRecipeService.getmaprecipe();
    this._listMyCategory = await this._saveRecipeService.getListMyCategory();
    this._curCategoryList = List.from([]);
    notifyListeners();
  }

  loadListMyCategory() async {
    this._listMyCategory.clear();
    this._listMyCategory = await this._saveRecipeService.getListMyCategory();
  }

  // using add recipe detail
  addRecipeToMycategory(String idRecipe, String nameMyCategory) async {
    if (!this._mapSavedRecipe.containsKey(nameMyCategory)) {
      this._saveRecipeService.createNewCategory(nameMyCategory, [idRecipe]);
    } else {
      this._mapSavedRecipe[nameMyCategory].forEach((element) {
        if (element.id == idRecipe) return;
      });
      await this._saveRecipeService.putInArray(nameMyCategory, idRecipe);
    }
    this._mapSavedRecipe['All'].forEach((element) async {
      if (element.id == idRecipe) {
        await loadMapRecipe();
        //return;
      }
    });
    await this._saveRecipeService.putInArray('All', idRecipe);
    await loadMapRecipe();
    this._curCategoryList = this._mapSavedRecipe[this.curCategoryName];
    notifyListeners();
  }

  removeRecipeFromMycategory(String idRecipe, String nameMyCategory) {
    if (nameMyCategory == 'All') {
      this._mapSavedRecipe[nameMyCategory].forEach((element) async {
        if (element.id == idRecipe) {
          await this._saveRecipeService.removeInAll(idRecipe);
          await loadMapRecipe();
        }
      });
    } else {
      this._mapSavedRecipe[nameMyCategory].forEach((element) async {
        if (element.id == idRecipe) {
          await this._saveRecipeService.removeInArray(nameMyCategory, idRecipe);
          await loadMapRecipe();
        }
      });
      notifyListeners();
    }
  }

  setCurCategory(String name) async {
    this._curCategoryName = name;
    if (this._mapSavedRecipe.containsKey(name)) {
      this._curCategoryList = List.from(this.mapSavedRecipe[name]);
    } else {
      await this._saveRecipeService.createNewCategory(name, []);
      await this.loadMapRecipe();
      this._curCategoryList = List.from(this._mapSavedRecipe[name]);
    }
    notifyListeners();
  }

  /// using delete item in mycategory list
  deleterecipe(int index) async {
    if (this._curCategoryName == 'All') {
      RecipeModel recipe =
          this._mapSavedRecipe[this._curCategoryName].removeAt(index);
      notifyListeners();
      await this._saveRecipeService.removeInAll(recipe.id);
      this._curCategoryList.removeAt(index);
      for (MapEntry<String, List<RecipeModel>> me
          in this._mapSavedRecipe.entries) {
        if (me.key != 'All')
          me.value.removeWhere((element) => element.id == recipe.id);
      }
    } else {
      await this._saveRecipeService.removeInArray(
          this._curCategoryName, this._curCategoryList.elementAt(index).id);
      this._mapSavedRecipe[this._curCategoryName].removeAt(index);
      this._curCategoryList.removeAt(index);
    }
    await loadListMyCategory();
    notifyListeners();
  }

  deleteCatergory(String name) async {
    if (name != "All") {
      await this._saveRecipeService.removeCategory(name);
      this._mapSavedRecipe.remove(name);
    } else {
      await this._saveRecipeService.clearAll();
      await this._saveRecipeService.createNewCategory('All', []);
      this._curCategoryName = "All";
    }
    await this.loadMapRecipe();
    notifyListeners();
  }

  setSelected(String idrecipe) {
    this._mapSavedRecipe['All'].forEach((element) {
      if (element.id == idrecipe) {
        element.isSelected = !element.isSelected;
      }
    });
  }

  unSelected() {
    this._mapSavedRecipe['All'].forEach((element) {
      element.isSelected = false;
    });
  }

  updateListRecipe() async {
    if (this._mapSavedRecipe.containsKey(this._curCategoryName)) {
      this._mapSavedRecipe['All'].forEach((element) {
        bool add = true;
        if (element.isSelected == true) {
          this._curCategoryList.forEach((e) {
            if (e.id == element.id) add = false;
          });
          if (add) {
            this._mapSavedRecipe[this._curCategoryName].add(element);
            this.curCategoryList.add(element);
            this
                ._saveRecipeService
                .putInArray(this._curCategoryName, element.id);
          }
          add = true;
        }
      });
      unSelected();
      await loadListMyCategory();
      notifyListeners();
    }
  }

  String checkNameCategoryExist(String name) {
    if (name.length > 30) return "Name is too long";
    if (name == "") return "Name is not blank";
    if (this._mapSavedRecipe.containsKey(name)) return "Name already exists";
    return "OK";
  }
}
// removeCategory(String keyy) {
//   _mapSavedRecipe.removeWhere((key, value) => key == keyy);
//   notifyListeners();
// }
// removeRecipe() {
//   _mapSavedRecipe.forEach((key, value) {
//     value.removeWhere((element) => element.isSelected == true);
//     if (value.isEmpty) _mapSavedRecipe.remove(key);
//   });
//   notifyListeners();
// }

// setUnselected() {
//   _mapSavedRecipe.forEach((key, value) {
//     value.forEach((element) {
//       element.isSelected = false;
//     });
//   });
//   notifyListeners();
// }
