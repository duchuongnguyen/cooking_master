import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyTopicsService {
  final ref = FirebaseFirestore.instance.collection("mytopics");
  Future<List<String>> getMyTopics(String uid) async {
    List<String> listtopics = [];
    await ref.where('uid', isEqualTo: uid).get().then((value) {
      listtopics = List.from(value.docs.first.data()['topics']);
    });
    return listtopics;
  }
}
