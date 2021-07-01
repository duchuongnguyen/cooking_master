import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_master/models/notification_model.dart';

class NotificationService {
  final _ref = FirebaseFirestore.instance.collection("notifications");

  Future<List<NotificationModel>> getNotifications(String receiverId) async {
    List<NotificationModel> _notificationList = [];

    await _ref.where('receiver', isEqualTo: receiverId).get().then((value) {
      value.docs.forEach((element) {
        NotificationModel notification =
            NotificationModel.fromMap(element.data());
        _notificationList.add(notification);
      });
    });

    return _notificationList;
  }

  Future pushNotification(NotificationModel notification) async {
    DocumentReference documentRef = await _ref.add(notification.toMap());

    notification.id = documentRef.id;

    documentRef.set(notification.toMap());
  }

  Future deleteNotification(NotificationModel notification) async {
    var query = _ref
        .where('owner', isEqualTo: notification.owner)
        .where('receiver', isEqualTo: notification.receiver)
        .where('content', isEqualTo: notification.content);

    query.get().then((value) {
      value.docs.forEach((element) {
        element.reference.delete();
      });
    });
  }
}
