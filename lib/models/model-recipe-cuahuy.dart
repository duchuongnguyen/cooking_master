class RecipeCardModelcuahuy {
  String recipeName;
  String recipeCookTime;
  String recipeKind;
  String recipeServingNumber;
  bool recipeIsSaved;
  String recipeOwner;
  String recipeImage;
  bool isSelected;

  RecipeCardModelcuahuy(
      {
      this.recipeName,
      this.recipeCookTime,
      this.recipeKind,
      this.recipeServingNumber,
      this.recipeIsSaved,
      this.recipeOwner,
      this.recipeImage,
      this.isSelected
      });
  factory RecipeCardModelcuahuy.fromMap(Map<String, dynamic> item) {
    return RecipeCardModelcuahuy(
        recipeName: item['recipeName'],
        recipeCookTime: item['recipeCookTime'],
        recipeKind: item['recipeKind'],
        recipeServingNumber: item['recipeServingNumber'],
        recipeIsSaved: item['recipeIsSaved'],
        recipeOwner: item['recipeOwner'],
        recipeImage: item['recipeImage'],
        isSelected: item['isSelected']);
  }
}

setNoSelected(List<RecipeCardModelcuahuy> cards) {
  cards.forEach((element) {
    element.isSelected = false;
  });
}

setAllSelected(List<RecipeCardModelcuahuy> cards) {
  cards.forEach((element) {
    element.isSelected = true;
  });
}

removeSelectedCards(List<RecipeCardModelcuahuy> cards) {
  cards.removeWhere((element) => element.isSelected == true);
}
