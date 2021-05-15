class TipModel {
  String tipUserName;
  String tipUserImage;
  String tipImage;
  String tipDescription;
  String tipTime;
  int tipLikeCount;

  TipModel(this.tipUserName, this.tipUserImage, this.tipImage,
      this.tipDescription, this.tipTime, this.tipLikeCount);
}

//Todo: Update Time cooking for right form.

List<TipModel> tips = tipData
    .map(
      (item) => TipModel(
        item['tipUserName'],
        item['tipUserImage'],
        item['tipImage'],
        item['tipDescription'],
        item['tipTime'],
        item['tipLikeCount'],
      ),
    )
    .toList();

var tipData = [
  {
    "tipUserName": "Cardi B",
    "tipUserImage": "assets/images/user.jpg",
    "tipImage": "assets/images/recipe1.jpg",
    "tipDescription":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    "tipTime": "2 hours ago",
    "tipLikeCount": 230,
  },
  {
    "tipUserName": "Gordon",
    "tipUserImage": "assets/images/user.jpg",
    "tipImage": "assets/images/recipe1.jpg",
    "tipDescription":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    "tipTime": "3 hours ago",
    "tipLikeCount": 30,
  },
  {
    "tipUserName": "Jonathan",
    "tipUserImage": "assets/images/user.jpg",
    "tipImage": "assets/images/recipe1.jpg",
    "tipDescription":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    "tipTime": "4 hours ago",
    "tipLikeCount": 20,
  },
];
