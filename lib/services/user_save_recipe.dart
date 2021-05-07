// ignore: unused_import
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_master/models/model-recipe-cuahuy.dart';
import 'package:cooking_master/models/nton_user_saved_recipe.dart';
import 'package:cooking_master/models/recipe_card_model.dart';

class FirebaseUserSaveRecipe {
  Stream<List<RecipeCardModelcuahuy>> getCardsStream(List idRecipe) {
    Query query = FirebaseFirestore.instance
        .collection('recipes')
        .where('recipeOwner', whereIn: idRecipe);
    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      return snapshot.docs
          .map((snapshot) {
            return RecipeCardModelcuahuy.fromMap(snapshot.data());
          })
          .where((value) => value != null)
          .toList();
    });
  }

  Stream<List<NtoNUserSavedRecipe>> getListMyCategory() {
    Query query = FirebaseFirestore.instance
        .collection('mycategory')
        .where('uid', isEqualTo: '123');
    final snapshots = query.snapshots();
    List<NtoNUserSavedRecipe>
        lists; // lists of mycategory {NtoNuserSavedRecipe}
    return snapshots.map((snapshot) {
      //get my category an  convert to lists
      lists = snapshot.docs
          .map((snapshot) {
            return NtoNUserSavedRecipe.fromMap(snapshot.data());
          })
          .where((value) => value != null)
          .toList();
      return lists;
    });
  }

  Stream<Map<String, List<RecipeCardModelcuahuy>>> mapListCardStream() async* {
    var categoryStream = FirebaseFirestore.instance
        .collection('mycategory')
        .where('uid', isEqualTo: '123')
        .snapshots();
    final Map<String, List<RecipeCardModelcuahuy>> results = new HashMap();
    // ignore: deprecated_member_use
    final lists = new List<RecipeCardModelcuahuy>.empty(growable: true);
    var begin, end;
    await for (var categorysnapshot in categoryStream) {
      for (var categorydoc in categorysnapshot.docs) {
        if (categorydoc['uid'] != null) {
            begin = lists.length;
          var queryOfRecipe = await FirebaseFirestore.instance
              .collection('recipes')
              .where('recipeOwner', whereIn: categorydoc['idrecipe'])
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              lists.add(RecipeCardModelcuahuy(
                isSelected: doc['isSelected'],
                recipeCookTime: doc['recipeCookTime'],
                recipeImage: doc['recipeImage'],
                recipeIsSaved: doc['recipeIsSaved'],
                recipeKind: doc['recipeKind'],
                recipeName: doc['recipeName'],
                recipeOwner: doc['recipeOwner'],
                recipeServingNumber: doc['recipeServingNumber'],
              ));
            });
          }).whenComplete(() {
            print(lists.length);
            results.putIfAbsent(categorydoc['category'], () => lists.getRange(begin, lists.indexOf(lists.last)+1).toList());
            print(results.values);
          });
          yield results;
          //lists.clear();
        }
      }
    }
  }
  // List<NtoNUserSavedRecipe>
  //     lists; // lists of mycategory {NtoNuserSavedRecipe}
  // return snapshots.map((snapshot) {
  //   String categoryName;
  //   List categoryList; // save list of category to get data-recipe in these
  //   Map<String, List<RecipeCardModelcuahuy>> result;
  //   //get my category an  convert to lists
  //   lists = snapshot.docs
  //       .map((snapshot) {
  //         return NtoNUserSavedRecipe.fromMap(snapshot.data());
  //       })
  //       .where((value) => value != null)
  //       .toList();
  //   // foreach to get recipe flow mycategory
  //   var snapshots1;
  //   var items;
  //   List<RecipeCardModelcuahuy> temp;
  //   lists.forEach((element) {
  //     categoryName = element.category; // get a name
  //     categoryList = element.idRecipe; // get a list id-recipe
  //     Query queryOfRecipe = FirebaseFirestore.instance
  //         .collection('recipes')
  //         .where('recipeOwner', isEqualTo: 'Huong');
  //     snapshots1 = queryOfRecipe.snapshots();
  //     if (snapshots1 != null) print('ccccc');
  //     items = snapshots1.map((snapshot) {
  //       temp = snapshot.docs
  //           .map((snapshot) {
  //             if (snapshot != null) print(snapshot.data());
  //             return RecipeCardModelcuahuy.fromMap(snapshot.data());
  //           })
  //           .where((value) => value != null)
  //           .toList();

  //       print("aloooo");
  //       result.putIfAbsent(categoryName, () => temp);
  //       return temp;
  //     });
  //   });

  //   return result;
  // });
  //}
}
