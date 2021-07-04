class UserModel {
  String userId;
  String userName;
  String userAddress;
  String userBio;
  String userImage;
  List<String> userFollower;
  List<String> userFollowing;

  UserModel({
    this.userId,
    this.userName,
    this.userAddress,
    this.userBio,
    this.userImage,
    this.userFollower,
    this.userFollowing,
  });

  factory UserModel.fromMap(Map data) {
    return UserModel(
        userId: data['uid'],
        userName: data['name'],
        userAddress: data['address'],
        userBio: data['bio'],
        userFollower: List<String>.from(data['followed']) ?? [],
        userFollowing: List<String>.from(data['following']) ?? [],
        userImage: data['imageurl']);
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": userId,
      "name": userName,
      "address": userAddress,
      "bio": userBio,
      "imageurl": userImage,
      "followed": userFollower,
      "following": userFollowing,
    };
  }
}
