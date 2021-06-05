import 'package:cooking_master/screens/Search/recipe_search.dart';
import 'package:cooking_master/screens/Search/search_model.dart';

class HistoryModel {
  String idRecipe;
  String name;
  int serving;
  HistoryModel({this.idRecipe, this.name, this.serving});
  factory HistoryModel.fromMap(Map data) {
    return HistoryModel(
        idRecipe: data['id'] ?? '',
        name: data['name'] ?? '',
        serving: data['yields'] as int ?? 2);
  }
  factory HistoryModel.fromRecipe(RecipeSearch data) {
    return HistoryModel(
      idRecipe: data.id,
      name: data.name,
      serving: data.serving
    );
  }
}
