// ignore: unused_import
import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_master/models/nton_user_saved_recipe.dart';
import 'package:cooking_master/models/recipe_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

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
          .where('id', whereIn: mycategory.idRecipe)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          list_recipe.add(RecipeModel.fromMap(element.data()));
          print(element.data());
        });
        print(list_recipe.length);
      });
      results.putIfAbsent(mycategory.category, () => list_recipe.toList());
      list_recipe.clear();
    }
    return results;
  }

  Future<bool> addrecipe(String uid) async {
    var resultCreate = false;
    list.forEach((element) async {
      await FirebaseFirestore.instance
          .collection('recipes')
          .doc(Uuid().v4())
          .set(element)
          .then((value) => resultCreate = true)
          .catchError((error) => resultCreate = false);
    });

    return resultCreate;
  }

  var list = [
    {
      "id": "2658855f961c4c1ba3ec",
      "owner": "4z8fgVtO4YfY54NNBixmJH9Djyv2",
      "name": "Golden Crescent Rolls Recipe ",
      "description": "a",
      "category": "bread",
      "yields": 0,
      "prepTime": 25,
      "cookTime": 15,
      "ingredients": [
        "yeast",
        "water",
        "white sugar",
        "salt",
        "egg",
        "butter",
        "flour",
        "butter"
      ],
      "directions": [
        "Dissolve yeast in warm water.",
        "Stir in sugar, salt, eggs, butter, and 2 cups of flour. Beat until smooth. Mix in remaining flour until smooth. Scrape dough from side of bowl. Knead dough, then cover it and let rise in a warm place until double (about 1 1/2 hours).",
        "Punch down dough. Divide in half. Roll each half into a 12-inch circle. Spread with butter. Cut into 10 to 15 wedge. Roll up the wedges starting with the wide end. Place rolls with point under on a greased baking sheet. Cover and let rise until double (about 1 hour).",
        "Bake at 400 degrees F (205 degrees C) for 12-15 minute or until golden brown. Brush tops with butter when they come out of the oven."
      ],
      "directionImage": null,
      "image":
          "https://images.media-allrecipes.com/userphotos/560x315/4465807.jpg",
      "isSelected": false
    },
    {
      "id": "a337e1d4f6be452e9379",
      "owner": "4z8fgVtO4YfY54NNBixmJH9Djyv2",
      "name": "Poppy Seed Bread with Glaze Recipe ",
      "description": "a",
      "category": "bread",
      "yields": 0,
      "prepTime": 15,
      "cookTime": 60,
      "ingredients": [
        "flour",
        "salt",
        "baking powder",
        "poppy",
        "butter",
        "vegetable oil",
        "egg",
        "milk",
        "white sugar",
        "vanilla",
        "almond",
        "orange juice",
        "butter",
        "almond",
        "vanilla",
        "sugar"
      ],
      "directions": [
        "Preheat oven to 350 degrees F (175 degrees C). Grease bottoms of two 9-inch loaf pans.",
        "Mix together flour, salt, baking powder, poppy seeds, butter flavoring, oil, eggs, milk, sugar, vanilla, and almond flavoring. Pour into prepared pans.",
        "Bake at 350 degrees F (175 degrees C) for one hour. Cool 5 minutes. Poke holes in top of loaves and pour glaze over.",
        "To make glaze: Mix orange juice, 1/2 teaspoon butter flavoring, 1/2 teaspoon almond flavoring, and 1 teaspoon vanilla. Add enough confectioners sugar to make glaze."
      ],
      "directionImage": null,
      "image":
          "https://images.media-allrecipes.com/userphotos/560x315/34726.jpg",
      "isSelected": false
    },
    {
      "id": "da00581018b14a0db32e",
      "owner": "4z8fgVtO4YfY54NNBixmJH9Djyv2",
      "name": "Applesauce Bread I Recipe ",
      "description": "a",
      "category": "bread",
      "yields": 0,
      "prepTime": 10,
      "cookTime": 80,
      "ingredients": [
        "flour",
        "egg",
        "white sugar",
        "vegetable oil",
        "applesauce",
        "raisin",
        "cinnamon",
        "baking soda",
        "baking powder",
        "sour cream"
      ],
      "directions": [
        "Preheat oven to 350 degrees F (175 degrees C).",
        "Grease and flour two 9 x 5 inch loaf pans.",
        "Beat together eggs, sugar, and oil.",
        "Blend in applesauce, and then sour cream or buttermilk.",
        "Mix in flour, baking powder, soda, and cinnamon. Stir in raisins. Pour batter into prepared pans.",
        "Bake for 80 minutes.",
        "Cool on wire racks."
      ],
      "directionImage": null,
      "image":
          "https://images.media-allrecipes.com/userphotos/560x315/1024884.jpg",
      "isSelected": false
    },
    {
      "id": "5baa4391629d4dc3b274",
      "owner": "4z8fgVtO4YfY54NNBixmJH9Djyv2",
      "name": "Apple Raisin Bread Recipe ",
      "description": "a",
      "category": "bread",
      "yields": 0,
      "prepTime": 15,
      "cookTime": 60,
      "ingredients": [
        "flour",
        "baking powder",
        "baking soda",
        "salt",
        "cinnamon",
        "nutmeg",
        "brown sugar",
        "oat",
        "apple",
        "walnut",
        "raisin",
        "egg",
        "milk",
        "vegetable oil"
      ],
      "directions": [
        "Preheat oven to 350 degrees F (175 degrees C).",
        "Grease and flour an 8 1/2 x 4 1/2 inch loaf pan.",
        "In a large bowl, combine flour, baking powder, baking soda, salt, cinnamon, nutmeg, brown sugar, and",
        "oats.",
        "Add apple, nuts, raisins, eggs, milk, and oil.",
        "Mix until dry ingredients are moistened.",
        "Bake for 55 to 60 minutes, or until done.",
        "Cool on wire rack."
      ],
      "directionImage": null,
      "image":
          "https://images.media-allrecipes.com/userphotos/560x315/21563.jpg",
      "isSelected": false
    },
    {
      "id": "6ea2f3237bf54455ae04",
      "owner": "4z8fgVtO4YfY54NNBixmJH9Djyv2",
      "name": "Buttermilk Oatmeal Bread Recipe ",
      "description": "a",
      "category": "bread",
      "yields": 0,
      "prepTime": 10,
      "cookTime": 60,
      "ingredients": [
        "oat",
        "buttermilk",
        "vegetable oil",
        "egg",
        "brown sugar",
        "flour",
        "baking powder",
        "baking soda",
        "salt"
      ],
      "directions": [
        "Mix oats with buttermilk.",
        "Let stand for 1/2 hour.",
        "Stir oil, egg, and brown sugar into oat mixture. Stir together flour, baking powder, soda, and salt: mix into oat mixture.",
        "Pour batter into a greased and floured 8 1/2 x 4 1/2 inch loaf pan.",
        "Bake at 350 degrees F (175 degrees C) for 55 to 60 minutes, or until done."
      ],
      "directionImage": null,
      "image":
          "https://images.media-allrecipes.com/userphotos/560x315/1149697.jpg",
      "isSelected": false
    },
    {
      "id": "ecd496ffb5184fbe999c",
      "owner": "4z8fgVtO4YfY54NNBixmJH9Djyv2",
      "name": "Kolaches II Recipe ",
      "description": "a",
      "category": "bread",
      "yields": 0,
      "prepTime": 30,
      "cookTime": 20,
      "ingredients": [
        "shortening",
        "white sugar",
        "salt",
        "milk",
        "egg",
        "lemon",
        "yeast",
        "flour",
        "fruit"
      ],
      "directions": [
        "Cream shortening and sugar together.",
        "Stir in salt, hot milk, beaten egg yolks, and flavoring.",
        "When lukewarm, add yeast to mixture.",
        "Let stand 5 minutes.",
        "Add flour, beating well.",
        "Knead down into bowl.",
        "The dough will be slightly sticky.",
        "Let rise 1 hour.",
        "Cut off small balls of dough.",
        "Roll into rounds in your hands, and place on greased cookie sheets 2 inches apart.",
        "Let rise 15 minutes.",
        "Make a depression into the center of each roll.",
        "Fill with fruit preserves.",
        "Bake at 450 degrees F (230 degrees C) until brown.",
        "Watch carefully.",
        "Cool on wire racks."
      ],
      "directionImage": null,
      "image":
          "https://images.media-allrecipes.com/userphotos/250x250/943400.jpg",
      "isSelected": false
    },
    {
      "id": "ed56b7198f5c4e2e8473",
      "owner": "4z8fgVtO4YfY54NNBixmJH9Djyv2",
      "name": "Whole Wheat Bread II Recipe ",
      "description": "bread",
      "category": "a",
      "yields": 0,
      "prepTime": 20,
      "cookTime": 35,
      "ingredients": [
        "shortening",
        "water",
        "brown sugar",
        "yeast",
        "water",
        "white sugar",
        "salt",
        "bread",
        "whole wheat"
      ],
      "directions": [
        "Dissolve brown sugar in 1 cup hot water.",
        "Add shortening, and stir to melt.",
        "Let cool.",
        "In a large bowl, dissolve yeast in 4 cups warm water.",
        "Add white sugar, salt, and bread flour.",
        "Beat well.",
        "Stir in shortening mixture.",
        "Stir in enough whole wheat flour to make a stiff but not dry dough.",
        "Turn out onto a lightly floured surface.",
        "Knead until smooth and elastic.",
        "Place in a large, well oiled bowl.",
        "Cover, and allow to rise until dough doubles in bulk.",
        "Divide dough into four equal parts.",
        "Shape into loaves.",
        "Place in greased, 9 x 5 inch pans,",
        "turning each loaf over in pan to grease top.",
        "Allow to rise until dough doubles in bulk.",
        "Bake at 350 degrees F (175 degrees C) for 35 minutes. Let cool before slicing."
      ],
      "directionImage": null,
      "image":
          "https://images.media-allrecipes.com/userphotos/560x315/5504282.jpg",
      "isSelected": false
    },
    {
      "id": "299e335e6e3047f6b00a",
      "owner": "4z8fgVtO4YfY54NNBixmJH9Djyv2",
      "name": "Cottage Cheese Bread II Recipe ",
      "description": "a",
      "category": "bread",
      "yields": 0,
      "prepTime": 5,
      "cookTime": 180,
      "ingredients": [
        "water",
        "cottage cheese",
        "vegetable oil",
        "egg",
        "flour",
        "white sugar",
        "baking soda",
        "salt",
        "yeast"
      ],
      "directions": null,
      "directionImage": null,
      "image":
          "https://images.media-allrecipes.com/userphotos/560x315/3129162.jpg",
      "isSelected": false
    }
  ];
}
