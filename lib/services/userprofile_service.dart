import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_master/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileService {
  final _ref = FirebaseFirestore.instance.collection("userprofile");

  Stream<UserModel> loadProfile(String id) {
    return _ref.doc(id).snapshots(includeMetadataChanges: true).map((snapshot) {
      // FirebaseAuth.instance.currentUser.updateProfile(
      //     displayName: snapshot.data()["name"],
      //     photoURL: snapshot.data()["imageurl"]);
       return UserModel.fromMap(snapshot.data());
    });
  }

  Stream<bool> isFollow(String idFollower, String idFollowing) {
    return _ref.doc(idFollower).snapshots(includeMetadataChanges: true).map(
        (value) => UserModel.fromMap(value.data())
            .userFollowing
            .contains(idFollowing));
  }

  Future<void> unfollowUser(String idFollower, String idFollowing) async {
    final _followerRef = _ref.doc(idFollower);
    final _followingRef = _ref.doc(idFollowing);

    await _followerRef.update({
      "following": FieldValue.arrayRemove([idFollowing])
    });
    await _followingRef.update({
      "followed": FieldValue.arrayRemove([idFollower])
    });
  }

  Future<void> followUser(String idFollower, String idFollowing) async {
    final _followerRef = _ref.doc(idFollower);
    final _followingRef = _ref.doc(idFollowing);

    await _followerRef.update({
      "following": FieldValue.arrayUnion([idFollowing])
    });
    await _followingRef.update({
      "followed": FieldValue.arrayUnion([idFollower])
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
    if (field == 'name') {
      await FirebaseAuth.instance.currentUser.updateProfile(displayName: value);
    }
    if (field == 'imageurl') {
      await FirebaseAuth.instance.currentUser.updateProfile(photoURL: value);
    }
    // print(FirebaseAuth.instance.currentUser.displayName);
    return resultUpdate;
  }

  Future<bool> addUser(String uid) async {
    var resultCreate = false;
    await _ref
        .doc(uid)
        .set({
          'uid': uid,
          'name': "New friend",
          'bio': " Add your Bio",
          'address': "Add your Address",
          'followed': [],
          'following': [],
          'imageurl':
              "https://firebasestorage.googleapis.com/v0/b/cooking-master-5dc52.appspot.com/o/user%2Fno_avatar.jpg?alt=media&token=98aeb858-f003-47ca-8bf7-a9bb82cc59c8"
        })
        .then((value) => resultCreate = true)
        .catchError((error) => resultCreate = false);
    await FirebaseAuth.instance.currentUser.updateProfile(
        displayName: "New friend",
        photoURL:
            'https://firebasestorage.googleapis.com/v0/b/cooking-master-5dc52.appspot.com/o/user%2Fno_avatar.jpg?alt=media&token=98aeb858-f003-47ca-8bf7-a9bb82cc59c8');
    return resultCreate;
  }
}
