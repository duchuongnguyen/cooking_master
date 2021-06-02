import 'package:flutter/material.dart';

class RecipeSearch {
  final String name;
  final String author;
  final String image;
  const RecipeSearch({
    @required this.name,
    @required this.author,
    this.image,
  })  : assert(name != null),
        assert(author != null);

  bool get hasauthor => author?.isNotEmpty == true;

  bool get isauthor => hasauthor && name == author;

  factory RecipeSearch.fromJson(Map<String, dynamic> map) {
    return RecipeSearch(
      name: map['name'] ?? '',
      author: map['yields'] ?? '',
      image: map['thumbnail_url'] ?? '',
    );
  }

  String get address {
    if (isauthor) return author;
    return '$name, $level2Address';
  }

  String get addressShort {
    if (isauthor) return author;
    return '$name, $author';
  }

  String get level2Address {
    if (isauthor) return author;
    return '$author';
  }

  @override
  String toString() =>
      'RecipeSearch(name: $name, author: $author, image: $image)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RecipeSearch && o.name == name && o.author == author;
  }

  @override
  int get hashCode => name.hashCode ^ author.hashCode;
}
