class RecipeCardModel {
  String recipeName;
  String recipeCookTime;
  String recipeKind;
  int recipeServingNumber;
  bool recipeIsSaved;
  String recipeOwner;
  String recipeImage;

  RecipeCardModel(this.recipeName, this.recipeCookTime, this.recipeKind,
      this.recipeServingNumber, this.recipeIsSaved, this.recipeOwner, this.recipeImage);
}

//Todo: Update Time cooking for right form.

List<RecipeCardModel> cards = cardData.map(
    (item) => RecipeCardModel(
        item['recipeName'],
        item['recipeCookTime'],
        item['recipeKind'],
        item['recipeServingNumber'],
        item['recipeIsSaved'],
        item['recipeOwner'],
        item['recipeImage'],
    ),
).toList();

var cardData = [
  {
    "recipeName": "Spagetti with Shrimp sause",
    "recipeCookTime": "20 mins",
    "recipeKind": "Pasta",
    "recipeServingNumber": 2,
    "recipeIsSaved": true,
    "recipeOwner": "Duc Huong",
    "recipeImage": "assets/images/recipe1.jpg",
  },

  {
    "recipeName": "Spagetti with Coffee sause",
    "recipeCookTime": "20 mins",
    "recipeKind": "Pasta",
    "recipeServingNumber": 2,
    "recipeIsSaved": true,
    "recipeOwner": "Minh Huy",
    "recipeImage": "assets/images/recipe2.jpg",
  },

  {
    "recipeName": "Spagetti with Coffee sause",
    "recipeCookTime": "20 mins",
    "recipeKind": "Pasta",
    "recipeServingNumber": 2,
    "recipeIsSaved": true,
    "recipeOwner": "Minh Huy",
    "recipeImage": "assets/images/recipe2.jpg",
  },

];