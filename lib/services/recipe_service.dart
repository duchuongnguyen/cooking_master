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

    _listTip.sort((a, b) => b.uidLiked.length.compareTo(a.uidLiked.length));
    print(_listTip);
    return _listTip;
  }

  uploadTipAndImage(RecipeModel recipe, TipModel tip, File localFile) async {
    if (localFile != null) {
      var fileExtension = path.extension(localFile.path);

      var uuid = Uuid().v4();

      final Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('recipes/${recipe.id}/tips/$uuid$fileExtension');

      await firebaseStorageRef.putFile(localFile);

      String url = await firebaseStorageRef.getDownloadURL();

      _uploadTip(tip, imageUrl: url);
    } else {
      _uploadTip(tip);
    }
  }

  void _uploadTip(TipModel tip, {String imageUrl}) async {
    if (imageUrl != null) {
      tip.image = imageUrl;
    }

    tip.createdAt = Timestamp.now();

    DocumentReference documentRef = await _ref.add(tip.toMap());

    tip.id = documentRef.id;

    documentRef.set(tip.toMap());
  }
}
