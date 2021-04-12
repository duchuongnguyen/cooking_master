class UserModel {
  String userId;
  String userName;
  String userAddress;
  String userBio;
  String userImage;
  String userFollowed;
  String userFollowing;
  UserModel({
    this.userId,
    this.userName,
    this.userAddress,
    this.userBio,
    this.userImage,
    this.userFollowed,
    this.userFollowing,
  }
  );
  factory UserModel.fromMap(Map data) {
    return UserModel(userId: data['uid'], userName: data['name'],userAddress: data['address'], userBio: data['bio'],userFollowed: data['followed'],userFollowing: data['following'],userImage: data['imageurl']);
  }
}

