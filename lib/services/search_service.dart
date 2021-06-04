import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_master/screens/Search/recipe_search.dart';
import 'package:cooking_master/screens/Search/search_model.dart';

class SearchService {
  final ref = FirebaseFirestore.instance.collection('recipes');
  Future<List<RecipeSearch>> searchBy(String cate, String name) async {
    List<RecipeSearch> list = [];
    if (name != '' && cate != '') {
      await ref
          .where('category', isEqualTo: cate)
          .where('name', isGreaterThanOrEqualTo: name)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          list.add(RecipeSearch.fromMap(element.data()));
        });
      });
    }
    return list;
  }

  Future<List<RecipeSearch>> searchByCate(String cate) async {
    List<RecipeSearch> list = [];
    if (cate != '') {
      await ref.where('category', isEqualTo: cate).get().then((value) {
        value.docs.forEach((element) {
          list.add(RecipeSearch.fromMap(element.data()));
        });
      });
    }
    return list;
  }

  Future<List<RecipeSearch>> getHistory(String uid) async {
    List<RecipeSearch> list = [];

    await ref.where('uid', isEqualTo: uid).get().then((value) {
      var re = value.docs.first.get('history') as List<Map>;
      re.forEach((element) {
        list.add(RecipeSearch.fromMap(element));
      });
    });
    print(list.first);
    return list;
  }

  updateHistory(List<RecipeSearch> list) {}
}
