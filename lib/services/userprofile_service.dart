import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_master/models/user_model.dart';

class UserProfileService {
  final _ref = FirebaseFirestore.instance.collection("userprofile");

  Future<UserModel> loadProfile(String id) async {
    return await _ref.doc(id).get().then((value) {
      return UserModel.fromMap(value.data());
    });
  }

  List<UserModel> loadListProfile(List<String> listUid) {
    List<UserModel> listUser = [];

    _ref.get().then((value) {
      value.docs.forEach((element) {
        listUser.add(UserModel.fromMap(element.data()));
      });
    });

    return listUser;
  }

  Future<bool> updateUser(String uid, String field, String value) async {
    var resultUpdate = false;
    await _ref
        .doc(uid)
        .update({field: value})
        .then((value) => resultUpdate = true)
        .catchError((error) => resultUpdate = false);
    return resultUpdate;
  }

  Future<bool> addUser(String uid) async {
    var resultCreate = false;
    await _ref
        .doc(uid)
        .set({
          'uid': uid,
          'name': "Tên hiển thị",
          'bio': "Thêm tiểu sử của bạn",
          'address': "Thêm địa chỉ của bạn",
          'followed': "0",
          'following': "0",
          'imageurl':
              "https://firebasestorage.googleapis.com/v0/b/cooking-master-5dc52.appspot.com/o/user%2Fno_avatar.jpg?alt=media&token=98aeb858-f003-47ca-8bf7-a9bb82cc59c8"
        })
        .then((value) => resultCreate = true)
        .catchError((error) => resultCreate = false);
    return resultCreate;
  }
}
