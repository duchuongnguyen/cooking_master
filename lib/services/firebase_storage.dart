import 'dart:io';
import 'package:cooking_master/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'auth.dart';

class StorageRepo {
  FirebaseStorage _storage = FirebaseStorage.instance;
  Future<String> uploadFile(File file, String uid) async {
    _storage.bucket = "gs://cooking-master-5dc52.appspot.com";
    try {
      await _storage.ref().child("user/profile/$uid").delete();
      var storageRef = _storage.ref().child("user/profile/$uid");
      await storageRef.putFile(file);
      var imageUrl = await storageRef.getDownloadURL();
      return imageUrl.toString();
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }
}
