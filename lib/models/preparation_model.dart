class PreparationModel {
  String preparationStepNumber;
  String preparationDetail;
  String preparationImage;

  PreparationModel(this.preparationStepNumber, this.preparationDetail, this.preparationImage);
}

//Todo: Update Time cooking for right form.

List<PreparationModel> preparation = preparationData
    .map(
      (item) => PreparationModel(
        item['preparationStepNumber'],
        item['preparationDetail'],
        item['preparationImage'],
      ),
    )
    .toList();

var preparationData = [
  {
    "preparationStepNumber": "1",
    "preparationDetail":
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    "preparationImage": "assets/images/recipe1.jpg",
  },
  {
    "preparationStepNumber": "2",
    "preparationDetail":
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    "preparationImage": "assets/images/recipe1.jpg",
  },
  {
    "preparationStepNumber": "3",
    "preparationDetail":
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    "preparationImage": "assets/images/recipe1.jpg",
  },
  {
    "preparationStepNumber": "4",
    "preparationDetail":
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    "preparationImage": "assets/images/recipe1.jpg",
  },
];
