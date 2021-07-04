import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_master/models/notification_model.dart';

class NotificationService {
  final _ref = FirebaseFirestore.instance.collection("notifications");

  Stream<List<NotificationModel>> getNewNotifications(String receiverId) {
    final _oneDayBefore = DateTime.now().subtract(Duration(days: 1));

    return _ref
        .where('receiver', isEqualTo: receiverId)
        .where('createdAt', isGreaterThan: _oneDayBefore)
        .orderBy('createdAt', descending: true)
        .snapshots(includeMetadataChanges: true)
        .map((snapshot) => snapshot.docs
            .map((doc) => NotificationModel.fromMap(doc.data()))
            .toList());
  }

  Stream<List<NotificationModel>> getEarlierNotifications(String receiverId) {
    final _oneDayBefore = DateTime.now().subtract(Duration(days: 1));

    return _ref
        .where('receiver', isEqualTo: receiverId)
        .where('createdAt', isLessThanOrEqualTo: _oneDayBefore)
        .orderBy('createdAt', descending: true)
        .snapshots(includeMetadataChanges: true)
        .map((snapshot) => snapshot.docs
            .map((doc) => NotificationModel.fromMap(doc.data()))
            .toList());
  }

  Future pushNotification(NotificationModel notification) async {
    notification.createdAt = Timestamp.now();

    DocumentReference documentRef = await _ref.add(notification.toMap());

    notification.id = documentRef.id;

    documentRef.set(notification.toMap());
  }

  Future deleteNotification(NotificationModel notification) async {
    var query = _ref
        .where('owner', isEqualTo: notification.owner)
        .where('receiver', isEqualTo: notification.receiver)
        .where('content', isEqualTo: notification.content)
        .where('id', isEqualTo: notification.id);
    {}
    query.get().then((value) {
      value.docs.forEach((element) {
        element.reference.delete();
      });
    });
  }
}
