import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/notifier/recipe_notifier.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

getRecipes(RecipeNotifier recipeNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Recipes')
      .orderBy("createdAt", descending: true)
      .get();

  List<Recipe> _recipeList = [];

  snapshot.docs.forEach((document) {
    Recipe recipe = Recipe.fromMap(document.data());
    _recipeList.add(recipe);
  });

  recipeNotifier.recipeList = _recipeList;
}

uploadRecipeAndImage(Recipe recipe, bool isUpdating, File localFile) async {
  if (localFile != null) {
    print("uploading file");

    var fileExtension = path.extension(localFile.path);
    print(fileExtension);

    var uuid = Uuid().v4();

    final Reference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('recipes/images/$uuid$fileExtension');

    await firebaseStorageRef.putFile(localFile);

    String url = await firebaseStorageRef.getDownloadURL();
    print("download url: $url");
    _uploadRecipe(recipe, isUpdating, imageUrl: url);
  } else {
    print("skipping image upload");
    _uploadRecipe(recipe, isUpdating);
  }
}

_uploadRecipe(Recipe recipe, bool isUpdating, {String imageUrl}) async {
  CollectionReference recipeRef =
      FirebaseFirestore.instance.collection('Recipes');

  if (imageUrl != null) {
    recipe.image = imageUrl;
  }

  if (isUpdating) {
    recipe.updatedAt = Timestamp.now();

    await recipeRef.doc(recipe.id).update(recipe.toMap());
    print("updated recipe with id: ${recipe.id}");
  } else {
    recipe.createdAt = Timestamp.now();

    DocumentReference documentRef = await recipeRef.add(recipe.toMap());

    recipe.id = documentRef.id;

    print("uploaded recipe successfully: ${recipe.toString()}");

    await documentRef.set(recipe.toMap());
  }
}
