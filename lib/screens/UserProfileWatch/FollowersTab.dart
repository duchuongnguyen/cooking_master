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
                  title: Text(_users[index].name),
                  trailing: _users[index].isFollowed
                      ? InkWell(
                          onTap: () => {
                            setState(() {
                              _users[index].isFollowed = false;
                            })
                          },
                          child: Container(
                            width: 130,
                                height: 30,
                            padding: EdgeInsets.only(right: 20.0, left: 26.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.6),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Text(
                              "Following",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        )
                      : Ink(
                          decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  _users[index].isFollowed = true;
                                });
                              },
                              child: Container(
                                width: 130,
                                height: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(5.0)),
                                child: Text(
                                  "Follow",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              )),
                        ),
                )));
  }

  @override
  initState() {
    super.initState();
    _getUsers();
  }

  void _getUsers() {
    _users.add(UserFollowModel(
        image: "https://randomuser.me/api/portraits/med/women/36.jpg",
        name: "Vilma Peura"));
    _users.add(UserFollowModel(
        image: "https://randomuser.me/api/portraits/med/women/20.jpg",
        name: "Paige Patel"));
  }
}

class UserFollowModel {
  String name;
  bool isFollowed;
  String image;

  UserFollowModel({this.name, this.isFollowed = false, this.image});

  @override
  String toString() {
    return '{ ${this.name}, ${this.isFollowed}, ${this.image}  }';
  }
}
