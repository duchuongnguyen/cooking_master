import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  String id;
  //String owner;
  String name;
  String description;
  int min;
  String category;
  // int yields;
  // int prepTime;
  // int cookTime;
  List ingredients = [];
  //List directions = [];
  String image;
  Timestamp createdAt;
  Timestamp updatedAt;

  Recipe(
      {this.id,
      this.name,
      this.description,
      this.min,
      this.category,
      this.ingredients,
      this.image,
      this.createdAt,
      this.updatedAt});
  factory Recipe.fromMap(Map<String, dynamic> data) {
    return Recipe(
        id: data['id'],
        //owner = data['owner'];
        name: data['name'],
        description: data['description'],
        min: data['min'],
        category: data['category'],
        //yields = data['yields'];
        //prepTime = data['prepTime'];
        //cookTime = data['cookTime'];
        ingredients: data['ingredients'],
        //directions = data['directions'];
        image: data['image'],
        createdAt: data['createdAt'],
        updatedAt: data['updatedAt']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      //'owner': owner,
      'name': name,
      //'description': description,
      'category': category,
      //'yields': yields,
      //'prepTime': prepTime,
      //'cookTime': cookTime,
      'ingredients': ingredients,
      // 'directions': directions,
      'image': image,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
