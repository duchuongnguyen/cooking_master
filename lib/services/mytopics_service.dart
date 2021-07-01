import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyTopicsService {
  final ref = FirebaseFirestore.instance.collection("mytopics");
  Future<List<String>> getMyTopics(String uid) async {
    List<String> listtopics = [];
    await ref.doc(FirebaseAuth.instance.currentUser.uid).get().then((value) {
      if(value.exists)
      listtopics = value.data()['topics'].cast<String>();
    });
    return listtopics;
  }
  update(List<String> topics) async {
    await 
    ref.doc(FirebaseAuth.instance.currentUser.uid).update({
      'topics' : topics,
    });
  }
}
