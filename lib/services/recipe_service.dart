import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/models/tip_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class RecipeService {
  final _ref = FirebaseFirestore.instance.collection("recipes");

  Future<List<RecipeModel>> getRecipes() async {
    List<RecipeModel> _recipeList = [];

    await _ref.limit(10).get().then((value) {
      value.docs.forEach((element) {
        RecipeModel recipe = RecipeModel.fromMap(element.data());
        _recipeList.add(recipe);
      });
    });

    return _recipeList;
  }

  Future<List<RecipeModel>> getRecipesByCategory(String category) async {
    List<RecipeModel> _recipeList = [];

    await _ref.limit(10).where('category', isEqualTo: category).get().then((value) {
      value.docs.forEach((element) {
        RecipeModel recipe = RecipeModel.fromMap(element.data());
        _recipeList.add(recipe);
      });
    });

    return _recipeList;
  }

  Future<RecipeModel> getRecipe(String id) async {
    RecipeModel _recipe;
    await _ref.where('id', isEqualTo: id).get().then((value) {
      if (value.docs.length > 0)
        _recipe = RecipeModel.fromMap(value.docs.first.data());
    });
    return _recipe;
  }

  Future<List<RecipeModel>> getRecipesByOwner(String owner) async {
    List<RecipeModel> _recipeList = [];

    await _ref.get().then((value) {
      value.docs.forEach((element) {
        RecipeModel recipe = RecipeModel.fromMap(element.data());
        _recipeList.add(recipe);
      });
    });

    return _recipeList;
  }

  void uploadRecipeAndImage(
      RecipeModel recipe, bool isUpdating, File localFile) async {
    if (localFile != null) {
      var fileExtension = path.extension(localFile.path);

      var uuid = Uuid().v4();

      final Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('recipes/images/$uuid$fileExtension');

      await firebaseStorageRef.putFile(localFile);

      String url = await firebaseStorageRef.getDownloadURL();

      _uploadRecipe(recipe, isUpdating, imageUrl: url);
    } else {
      _uploadRecipe(recipe, isUpdating);
    }
  }

  void _uploadRecipe(RecipeModel recipe, bool isUpdating,
      {String imageUrl}) async {
    if (imageUrl != null) {
      recipe.image = imageUrl;
    }

    if (isUpdating) {
      recipe.updatedAt = Timestamp.now();

      await _ref.doc(recipe.id).update(recipe.toMap());
    } else {
      final _userUid = FirebaseAuth.instance.currentUser.uid;

      recipe.createdAt = Timestamp.now();
      recipe.owner = _userUid;

      DocumentReference documentRef = await _ref.add(recipe.toMap());

      recipe.id = documentRef.id;

      documentRef.set(recipe.toMap());
    }
  }

  Future<List<TipModel>> getTips(String idRecipe) async {
    final _tipRef = _ref.doc(idRecipe).collection("tips");
    List<TipModel> _listTip = [];

    await _tipRef.get().then((value) {
      value.docs.forEach((element) {
        TipModel tip = TipModel.fromMap(element.data());
        _listTip.add(tip);
      });
    });

    _listTip.sort((a, b) {
      int cmp = b.uidLiked.length.compareTo(a.uidLiked.length);
      if (cmp != 0)
        return cmp;
      else {
        return b.createdAt.compareTo(a.createdAt);
      }
    });

    return _listTip;
  }

  uploadTipAndImage(String idRecipe, TipModel tip, File localFile) async {
    if (localFile != null) {
      var fileExtension = path.extension(localFile.path);

      var uuid = Uuid().v4();

      final Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('recipes/$idRecipe/tips/$uuid$fileExtension');

      await firebaseStorageRef.putFile(localFile);

      String url = await firebaseStorageRef.getDownloadURL();

      _uploadTip(idRecipe, tip, imageUrl: url);
    } else {
      _uploadTip(idRecipe, tip);
    }
  }

  void _uploadTip(String idRecipe, TipModel tip, {String imageUrl}) async {
    final _tipRef = _ref.doc(idRecipe).collection("tips");

    if (imageUrl != null) {
      tip.image = imageUrl;
    }

    final _userUid = FirebaseAuth.instance.currentUser.uid;

    if (tip.id == null) {
      tip.owner = _userUid;
      tip.createdAt = Timestamp.now();

      DocumentReference documentRef = await _tipRef.add(tip.toMap());

      tip.id = documentRef.id;

      documentRef.set(tip.toMap());
    } else {
      DocumentReference documentRef = _tipRef.doc(tip.id);
      documentRef.update(tip.toMap());
    }
  }
}
