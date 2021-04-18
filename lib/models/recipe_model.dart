import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  String id;
  String owner;
  String name;
  String description;
  String category;
  int yields;
  int prepTime;
  int cookTime;
  List ingredients = [];
  List directions = [];
  List directionImage = [];
  String image;
  Timestamp createdAt;
  Timestamp updatedAt;

  Recipe();

  Recipe.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    owner = data['owner'];
    name = data['name'];
    description = data['description'];
    category = data['category'];
    yields = data['yields'];
    prepTime = data['prepTime'];
    cookTime = data['cookTime'];
    ingredients = data['ingredients'];
    directions = data['directions'];
    directionImage = data['directionImage'];
    image = data['image'];
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'owner': owner,
      'name': name,
      'description': description,
      'category': category,
      'yields': yields,
      'prepTime': prepTime,
      'cookTime': cookTime,
      'ingredients': ingredients,
      'directions': directions,
      'directionImage': directionImage,
      'image': image,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
