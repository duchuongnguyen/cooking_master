import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_master/models/notification_model.dart';
import 'package:cooking_master/models/user_model.dart';
import 'package:cooking_master/services/notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class UserProfileService {
  final _ref = FirebaseFirestore.instance.collection("userprofile");

  Stream<UserModel> loadProfile(String id) {
    return _ref.doc(id).snapshots(includeMetadataChanges: true).map((snapshot) {
      return UserModel.fromMap(snapshot.data());
    });
  }

  Future<UserModel> loadProfileFuture(String id) async {
    return await _ref
        .doc(id)
        .get()
        .then((value) => UserModel.fromMap(value.data()));
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

    NotificationModel notification = NotificationModel();

    notification.content = "started following you.\n";
    notification.owner = idFollower;
    notification.receiver = idFollowing;

    await NotificationService().deleteNotification(notification);

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

    NotificationModel notification = NotificationModel();

    notification.content = "started following you.\n";
    notification.owner = idFollower;
    notification.receiver = idFollowing;
    notification.seen = false;

    NotificationService().pushNotification(notification);

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
    List<String> array = [];
    await _ref
        .doc(uid)
        .set({
          'uid': uid,
          'name': "Cutie Chef",
          'bio': " Your bio",
          'address': "Your address",
          'followed': [],
          'following': [],
          'imageurl':
              "https://firebasestorage.googleapis.com/v0/b/cooking-master-5dc52.appspot.com/o/user%2Fno_avatar.jpg?alt=media&token=98aeb858-f003-47ca-8bf7-a9bb82cc59c8"
        })
        .then((value) => resultCreate = true)
        .catchError((error) => resultCreate = false);
    await FirebaseFirestore.instance
        .collection('mycategory')
        .doc(Uuid().v4())
        .set({
      'uid': uid,
      'category': 'All',
      'idrecipe': array,
    });
    return resultCreate;
  }
}
