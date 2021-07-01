import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyTopicsService {
  final ref = FirebaseFirestore.instance.collection("mytopics");
  Future<List<String>> getMyTopics(String uid) async {
    List<String> listtopics = [];
    await ref.doc(FirebaseAuth.instance.currentUser.uid).get().then((value) {
      if (value.exists) listtopics = value.data()['topics'].cast<String>();
    });
    return listtopics;
  }

  update(List<String> topics) async {
    await ref.doc(FirebaseAuth.instance.currentUser.uid).update({
      'topics': topics,
    });
  }

  Future<List<Map<String, dynamic>>> getAllCategories() async {
    List<Map<String, dynamic>> allCategory = [];
    await FirebaseFirestore.instance
        .collection("categories")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        allCategory.add(element.data());
      });
    });
    print(allCategory.first['cate_id']);
    return allCategory;
  }
}
