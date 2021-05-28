// ignore: unused_import
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_master/models/model-recipe-cuahuy.dart';
import 'package:cooking_master/models/nton_user_saved_recipe.dart';
import 'package:cooking_master/models/recipe_card_model.dart';
import 'package:cooking_master/models/recipe_model.dart';

class FirebaseUserSaveRecipe {

  Future<List<NtoNUserSavedRecipe>> getListMyCategory() async {
    List<NtoNUserSavedRecipe> _lists = [];
    await FirebaseFirestore.instance
        .collection('mycategory')
        .where('uid', isEqualTo: '123')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        _lists.add(NtoNUserSavedRecipe.fromMap(element.data()));
      });
    });
    return _lists;
  }

  Future<Map<String, List<RecipeModel>>> getmaprecipe() async {

    List<NtoNUserSavedRecipe> _list = await getListMyCategory();
      List<RecipeModel> list_recipe = [];
     Map<String, List<RecipeModel>> results = new HashMap();
    for (var mycategory in _list) {
      await FirebaseFirestore.instance
          .collection('recipes')
          .where('id',whereIn: mycategory.idRecipe)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          list_recipe.add(RecipeModel.fromMap(element.data()));
          print(element.data());
        });
        print(list_recipe.length);
      });
      results.putIfAbsent(mycategory.category, () =>  list_recipe.toList());
      list_recipe.clear();
    }
    return results;
  }

}
