class RecipeCardModel {
  String recipeName;
  String recipeCookTime;
  String recipeKind;
  int recipeServingNumber;
  bool recipeIsSaved;
  String recipeOwner;
  String recipeImage;
  String image;
  bool isSelected;

  RecipeCardModel(
    this.recipeName,
    this.recipeCookTime,
    this.recipeKind,
    this.recipeServingNumber,
    this.recipeIsSaved,
    this.recipeOwner,
    this.recipeImage,
    this.isSelected,
    this.image,
  );
}

//Todo: Update Time cooking for right form.

setNoSelected(List<RecipeCardModel> cards) {
  cards.forEach((element) {
    element.isSelected = false;
  });
}

setAllSelected(List<RecipeCardModel> cards) {
  cards.forEach((element) {
    element.isSelected = true;
  });
}

removeSelectedCards(List<RecipeCardModel> cards) {
  cards.removeWhere((element) => element.isSelected == true);
}

List<RecipeCardModel> getListRecipe(var data) {
  List<RecipeCardModel> cards = data
      .frommap(
        (item) => RecipeCardModel(
            item['recipeName'],
            item['recipeCookTime'],
            item['recipeKind'],
            item['recipeServingNumber'],
            item['recipeIsSaved'],
            item['recipeOwner'],
            item['recipeImage'],
            item['isSelected'],
            item['image']),
      )
      .toList();
  return cards;
}

List<RecipeCardModel> cards = cardData
    .map(
      (item) => RecipeCardModel(
          item['recipeName'],
          item['recipeCookTime'],
          item['recipeKind'],
          item['recipeServingNumber'],
          item['recipeIsSaved'],
          item['recipeOwner'],
          item['recipeImage'],
          item['isSelected'],
          item['image']),
    )
    .toList();

var cardData = [
  {
    "recipeName": "Spagetti with Shrimp sause",
    "recipeCookTime": "20 mins",
    "recipeKind": "Pasta",
    "recipeServingNumber": 2,
    "recipeIsSaved": true,
    "recipeOwner": "Duc Huong",
    "recipeImage": "assets/images/recipe1.jpg",
    "isSelected": false,
    'image':
        'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
  },
  {
    "recipeName": "Spagetti with Coffee sause",
    "recipeCookTime": "20 mins",
    "recipeKind": "Pasta",
    "recipeServingNumber": 2,
    "recipeIsSaved": true,
    "recipeOwner": "Minh Huy",
    "recipeImage": "assets/images/recipe2.jpg",
    "isSelected": false,
    'image':
        'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
  },
  {
    "recipeName": "Spagetti with Coffee sause",
    "recipeCookTime": "20 mins",
    "recipeKind": "Pasta",
    "recipeServingNumber": 2,
    "recipeIsSaved": true,
    "recipeOwner": "Minh Huy",
    "recipeImage": "assets/images/recipe2.jpg",
    "isSelected": false,
    'image':
        'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
  },
  {
    "recipeName": "Spagetti with Shrimp sause",
    "recipeCookTime": "20 mins",
    "recipeKind": "Pasta",
    "recipeServingNumber": 2,
    "recipeIsSaved": true,
    "recipeOwner": "Duc Huong",
    "recipeImage": "assets/images/recipe1.jpg",
    "isSelected": false,
    'image':
        'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
  },
];
