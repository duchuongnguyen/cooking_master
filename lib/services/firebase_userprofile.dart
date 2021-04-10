import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_master/models/user_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserProfile {
  final Ref = FirebaseFirestore.instance.collection("userprofile");
  UserModel user;
  // ignore: non_constant_identifier_names
  Stream<UserModel> LoadProfile(String id)
  {
   return Ref.doc(id).snapshots().map((snapshot) => UserModel.fromMap(snapshot.data()));
  }
  Future<bool> updateUser(String uid, String Field, String value) async {
    var result_update = false;
    await Ref
        .doc(uid)
        .update({Field : value})
        .then((value) => result_update = true)
        .catchError((error) => result_update = false);
    return result_update;
  }
  Future<bool> addUser(String uid) async {
  var result_create = false;
  await  Ref
        .doc(uid)
        .set({
      'uid': uid,
      'name': "Tên hiển thị",
      'bio': "Thêm tiểu sử của bạn",
      'address': "Thêm địa chỉ của bạn",
      'followed': "0",
      'following': "0",
      'imageurl': "https://firebasestorage.googleapis.com/v0/b/cooking-master-5dc52.appspot.com/o/user%2Fno_avatar.jpg?alt=media&token=98aeb858-f003-47ca-8bf7-a9bb82cc59c8"

    })
        .then((value) =>  result_create = true)
        .catchError((error) => result_create = false);
    return result_create;
  }

}


