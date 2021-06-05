import 'package:flutter/material.dart';

class RecipeSearch {
  final String id;
  final String name;
  final int serving;
  final String image;
  const RecipeSearch({
    @required this.name,
    @required this.serving,
    this.image,
    this.id,
  })  : assert(name != null);


  factory RecipeSearch.fromJson(Map<String, dynamic> map) {
    return RecipeSearch(
      name: map['name'] ?? '',
      serving: map['yields'] ?? '',
      image: map['thumbnail_url'] ?? '',
    );
  }
  factory RecipeSearch.fromMap(Map map) {
    return RecipeSearch(
      name: map['name'] ?? '',
      serving: map['yields'] ?? 2,
      image: map['image'] ?? '',
      id: map['id'] ?? '',
    );
  }
  

}
