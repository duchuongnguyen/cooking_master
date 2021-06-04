import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeModel {
  String id;
  String owner;
  String name;
  String description;
  String category;
  int yields;
  int prepTime;
  int cookTime;
  List<String> ingredients = [];
  List<String> directions = [];
  List<String> directionImage = [];
  String image;
  Timestamp createdAt;
  Timestamp updatedAt;
  bool isSelected = false;
  RecipeModel();

  RecipeModel.fromMap(Map data) {
    id = data['id'] as String;
    owner = data['owner'] as String;
    name = data['name'] as String;
    description = data['description'] as String;
    category = data['category'] as String;
    yields = data['yields'] as int;
    prepTime = data['prepTime'] as int;
    cookTime = data['cookTime'] as int;
    ingredients = data['ingredients'].cast<String>();
    directions = data['directions'].cast<String>();
    //directionImage = data['directionImage'].cast<String>();
    image = data['image'] as String;
    createdAt = data['createdAt'] as Timestamp ?? Timestamp.now();
    updatedAt = data['updatedAt'] as Timestamp ?? Timestamp.now();
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

setNoSelected(List<RecipeModel> cards) {
  cards.forEach((element) {
    element.isSelected = false;
  });
}

setAllSelected(List<RecipeModel> cards) {
  cards.forEach((element) {
    element.isSelected = true;
  });
}

removeSelectedCards(List<RecipeModel> cards) {
  cards.removeWhere((element) => element.isSelected == true);
}
