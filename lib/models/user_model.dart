class UserModel {
  String userId;
  String userName;
  String userAddress;
  String userBio;
  String userImage;
  int userFollowed;
  int userFollowing;
  UserModel(
    this.userId,
    this.userName,
    this.userAddress,
    this.userBio,
    this.userImage,
    this.userFollowed,
    this.userFollowing,
  );
}

List<UserModel> users = userData
    .map((user) => UserModel(
          user['userId'],
          user['userName'],
          user['userAddress'],
          user['userBio'],
          user['userImage'],
          user['userFollowed'],
          user['userFollowing'],
        ))
    .toList();
var userData = [
  {
    'userId': "001",
    'userName': "Nguyễn Đức Hướng",
    'userAddress': "Thị trấn Chư Sê, huyện Chư Sê, Gia Lai",
    'userBio':
        "Lấy đam mê làm ánh mặt trời để tâm hồn này không mất phương hướng",
    'userImage': "assets/images/user.jpg",
    'userFollowed': 20,
    'userFollowing': 21,
  },
  {
    'userId': "002",
    'userName': "Bùi Minh Huy",
    'userAddress': "Huyện Tiên Phước, Quảng Nam",
    'userBio': "Aydo whatsssup",
    'userImage': "assets/images/user.jpg",
    'userFollowed': 69,
    'userFollowing': 96,
  }
];
