import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String id;
  String owner;
  String receiver;
  String content;
  Timestamp createdAt;
  bool seen;
  String idRecipe;
  NotificationModel();

  NotificationModel.fromMap(Map data) {
    idRecipe = data['idrecipe'] ?? '';
    id = data['id'];
    owner = data['owner'];
    receiver = data['receiver'];
    content = data['content'];
    createdAt = data['createdAt'];
    seen = data['seen'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'owner': owner,
      'receiver': receiver,
      'content': content,
      'createdAt': createdAt,
      'seen': seen,
      'idrecipe': idRecipe,
    };
  }
}
