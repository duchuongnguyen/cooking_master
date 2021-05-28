class NtoNUserSavedRecipe {
  String uId;
  String category;
  List idRecipe;
  NtoNUserSavedRecipe({this.uId, this.category, this.idRecipe});
  factory NtoNUserSavedRecipe.fromMap(Map item) {
    return NtoNUserSavedRecipe(
        uId: item['uid'],
        category: item['category'],
        idRecipe: item['idrecipe']);
  }
}
