import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_master/models/history_model.dart';
import 'package:cooking_master/screens/Search/recipe_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SearchService {
  final ref = FirebaseFirestore.instance.collection('recipes');
  Future<List<RecipeSearch>> searchBy(String cate, String name) async {
    List<RecipeSearch> list = [];
    if (name != '' && cate != 'all') {
      await ref
          .where('category', isEqualTo: cate)
          .where('name', isGreaterThanOrEqualTo: name)
          .limit(6)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          list.add(RecipeSearch.fromMap(element.data()));
        });
      });
    } else {
      await ref
          .where('name', isGreaterThanOrEqualTo: name)
          .limit(6)
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
      await ref
          .where('category', isEqualTo: cate)
          .limit(15)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          list.add(RecipeSearch.fromMap(element.data()));
        });
      });
    }
    return list;
  }

  Future<List<RecipeSearch>> getHistory() async {
    List<RecipeSearch> list = [];
    print(FirebaseAuth.instance.currentUser.uid);
    await FirebaseFirestore.instance
        .collection('history_search')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      if (!value.exists) return list;
      var re = value.data().values.first as List<Map>;
      re.forEach((element) {
        list.add(RecipeSearch.fromMap(element));
      });
    }).catchError((onError) {
      print(onError);
      return list;
    });
    //print(list.first);
    return list;
  }

  updateHistory(List<HistoryModel> list) async {
    final uid = FirebaseAuth.instance.currentUser.uid;
    await FirebaseFirestore.instance
        .collection('history_search')
        .doc(uid)
        .set({'history': list}).catchError((err) => print(err));
  }
}
