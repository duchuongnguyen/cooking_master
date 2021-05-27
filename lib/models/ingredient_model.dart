class IngredientModel {
  String ingredientName;
  double ingredientAmount;
  String ingredientUnit;

  IngredientModel(
      this.ingredientName, this.ingredientAmount, this.ingredientUnit);
}

//Todo: Update Time cooking for right form.

List<IngredientModel> ingredient = ingredientData
    .map(
      (item) => IngredientModel(
        item['ingredientName'],
        item['ingredientAmount'],
        item['ingredientUnit'],
      ),
    )
    .toList();

var ingredientData = [
  {
    "ingredientName": "Tomato",
    "ingredientAmount": 2.0,
    "ingredientUnit": "pcs",
  },
  {
    "ingredientName": "Egg",
    "ingredientAmount": 5.0,
    "ingredientUnit": "pcs",
  },
  {
    "ingredientName": "Bread",
    "ingredientAmount": 3.0,
    "ingredientUnit": "slides",
  },
];
