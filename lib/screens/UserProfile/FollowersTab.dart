import 'package:flutter/material.dart';

class FollowersTab extends StatefulWidget {
  const FollowersTab({Key key}) : super(key: key);

  @override
  _FollowersTabState createState() => _FollowersTabState();
}

class _FollowersTabState extends State<FollowersTab> {
  List<UserFollowModel> _users = [];
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            itemCount: _users.length,
            itemBuilder: (context, int index) => ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(_users[index].image),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_users[index].name),
                    if (_users[index].isFollowed != "true")
                      Container(
                          width: 4,
                          height: 4,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.black)),
                    _users[index].isFollowed == "true"
                        ? Text(
                            "",
                          )
                        : _users[index].isFollowed == "notFollowBack"
                            ? GestureDetector(
                                onTap: () => setState(() {
                                  _users[index].isFollowed = "followBack";
                                }),
                                child: Text(
                                  "Follow",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                              )
                            : GestureDetector(
                                onTap: () => setState(() {
                                  _users[index].isFollowed = "notFollowBack";
                                }),
                                child: Text(
                                  "Following",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                  ],
                ),
                trailing: InkWell(
                  onTap: () => {
                    setState(() {
                      _users.removeAt(index);
                    })
                  },
                  child: Container(
                    width: 110,
                    height: 30,
                    padding: EdgeInsets.only(right: 20.0, left: 26.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black.withOpacity(0.6), width: 1.5),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Text(
                      "Remove",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ))));
  }

  @override
  initState() {
    super.initState();
    _getUsers();
  }

  void _getUsers() {
    _users.add(UserFollowModel(
        image: "https://randomuser.me/api/portraits/med/women/36.jpg",
        name: "Vilma Peura",
        isFollowed: "notFollowBack"));
    _users.add(UserFollowModel(
        image: "https://randomuser.me/api/portraits/med/women/20.jpg",
        name: "Paige Patel"));
  }
}

class UserFollowModel {
  String name;
  String isFollowed;
  String image;

  UserFollowModel({this.name, this.isFollowed = "true", this.image});

  @override
  String toString() {
    return '{ ${this.name}, ${this.isFollowed}, ${this.image}  }';
  }
}
