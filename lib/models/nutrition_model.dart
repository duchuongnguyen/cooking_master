class NutritionModel {
  String nutritionName;
  String nutritionAmount;

  NutritionModel(this.nutritionName, this.nutritionAmount);
}

//Todo: Update Time cooking for right form.

List<NutritionModel> nutrition = nutritionData
    .map(
      (item) => NutritionModel(
        item['nutritionName'],
        item['nutritionAmount'],
      ),
    )
    .toList();

var nutritionData = [
  {
    "nutritionName": "calories",
    "nutritionAmount": "202",
  },
  {
    "nutritionName": "fat",
    "nutritionAmount": "15 g",
  },
  {
    "nutritionName": "carbohydrates",
    "nutritionAmount": "33 g",
  },
];
