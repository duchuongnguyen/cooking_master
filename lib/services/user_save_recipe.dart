import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_master/models/nton_user_saved_recipe.dart';
import 'package:cooking_master/models/recipe_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class FirebaseUserSaveRecipe {
  Future<List<NtoNUserSavedRecipe>> getListMyCategory() async {
    List<NtoNUserSavedRecipe> _lists = [];
    await FirebaseFirestore.instance
        .collection('mycategory')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
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
      if (mycategory.idRecipe.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('recipes')
            .where('id', whereIn: mycategory.idRecipe)
            .get()
            .then((value) {
          value.docs.forEach((element) {
            list_recipe.add(RecipeModel.fromMap(element.data()));
            // print(element.data());
          });
          //print(list_recipe.length);
        });
      }
      results.putIfAbsent(mycategory.category, () => list_recipe.toList());
      list_recipe.clear();
    }
    return results;
  }

  Future<String> getIdDoc(String cate) async {
    await FirebaseFirestore.instance
        .collection('mycategory')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .where('category', isEqualTo: cate)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        //print(element.id);
        return element.id;
      });
    });
  }

  createNewCategory(String cateName, List<String> idrecipe) async {
    await FirebaseFirestore.instance
        .collection('mycategory')
        .doc(Uuid().v4())
        .set({
      'uid': FirebaseAuth.instance.currentUser.uid,
      'category': cateName,
      'idrecipe': idrecipe
    });
  }

  removeCategory(String namecate) async {
    await FirebaseFirestore.instance
        .collection('mycategory')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .where('category', isEqualTo: namecate)
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        await FirebaseFirestore.instance
            .collection('mycategory')
            .doc(element.id)
            .delete();
      });
    });
  }

  putInArray(String cateName, String recipeid) async {
    await FirebaseFirestore.instance
        .collection('mycategory')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .where('category', isEqualTo: cateName)
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        await FirebaseFirestore.instance
            .collection('mycategory')
            .doc(element.id)
            .update({
          'idrecipe': FieldValue.arrayUnion([recipeid])
        });
      });
    });
  }

  removeInArray(String cateName, String recipeId) async {
    await FirebaseFirestore.instance
        .collection('mycategory')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .where('category', isEqualTo: cateName)
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        await FirebaseFirestore.instance
            .collection('mycategory')
            .doc(element.id)
            .update({
          'idrecipe': FieldValue.arrayRemove([recipeId])
        });
      });
    });
  }

  removeInAll(String recipeId) async {
    await FirebaseFirestore.instance
        .collection('mycategory')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        await FirebaseFirestore.instance
            .collection('mycategory')
            .doc(element.id)
            .update({
          'idrecipe': FieldValue.arrayRemove([recipeId])
        });
      });
    });
  }

  clearAll() async {
    await FirebaseFirestore.instance
        .collection('mycategory')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        await FirebaseFirestore.instance
            .collection('mycategory')
            .doc(element.id)
            .delete();
      });
    });
  }

  // Using for yourRecipeNotifier
  Future<List<RecipeModel>> getYourRecipes(String uid) async {
    List<RecipeModel> list_recipe = [];
    await FirebaseFirestore.instance
        .collection('recipes')
        .where('owner', isEqualTo: uid)
        .limit(12)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        list_recipe.add(RecipeModel.fromMap(element.data()));
      });
    });
    return list_recipe;
  }

  deleteRecipe(String id) async {
    await FirebaseFirestore.instance
        .collection('recipes')
        .where('id', isEqualTo: id)
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        await FirebaseFirestore.instance
            .collection('recipes')
            .doc(element.id)
            .delete();
      });
    });
  }
}
