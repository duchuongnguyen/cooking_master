import 'package:cloud_firestore/cloud_firestore.dart';

class TipModel {
  String id;
  String owner;
  String image;
  String content;
  Timestamp createdAt;
  List<String> uidLiked;

  TipModel(
    this.id,
    this.owner,
    this.image,
    this.content,
    this.createdAt,
    this.uidLiked,
  );

  TipModel.fromMap(Map data) {
    id = data['id'] as String;
    owner = data['owner'] as String;
    image = data['image'] as String;
    content = data['content'] as String;
    createdAt = data['createdAt'] as Timestamp;
    uidLiked = data['uidLiked'].cast<String>();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'owner': owner,
      'image': image,
      'content': content,
      'createdAt': createdAt,
      'uidLiked': uidLiked,
    };
  }
}

//Todo: Update Time cooking for right form.

// List<TipModel> tips = tipData
//     .map(
//       (item) => TipModel(
//         item['tipUserName'],
//         item['tipUserImage'],
//         item['tipImage'],
//         item['tipDescription'],
//         item['tipTime'],
//         item['tipLikeCount'],
//       ),
//     )
//     .toList();

// var tipData = [
//   {
//     "tipUserName": "Cardi B",
//     "tipUserImage": "assets/images/user.jpg",
//     "tipImage": "assets/images/recipe1.jpg",
//     "tipDescription":
//         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
//     "tipTime": "2 hours ago",
//     "tipLikeCount": 230,
//   },
//   {
//     "tipUserName": "Gordon",
//     "tipUserImage": "assets/images/user.jpg",
//     "tipImage": "assets/images/recipe1.jpg",
//     "tipDescription":
//         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
//     "tipTime": "3 hours ago",
//     "tipLikeCount": 30,
//   },
//   {
//     "tipUserName": "Jonathan",
//     "tipUserImage": "assets/images/user.jpg",
//     "tipImage": "assets/images/recipe1.jpg",
//     "tipDescription":
//         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
//     "tipTime": "4 hours ago",
//     "tipLikeCount": 20,
//   },
// ];
