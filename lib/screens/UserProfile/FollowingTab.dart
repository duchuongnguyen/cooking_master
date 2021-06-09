import 'package:flutter/material.dart';

class FollowingTab extends StatefulWidget {
  const FollowingTab({Key key}) : super(key: key);

  @override
  _FollowingTabState createState() => _FollowingTabState();
}

class _FollowingTabState extends State<FollowingTab> {
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
                trailing: InkWell(
                  onTap: () => {
                    setState(() {
                      _users.removeAt(index);
                    })
                  },
                  child: Container(
                    width: 130,
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
        name: "Vilma Peura"));
    _users.add(UserFollowModel(
        image: "https://randomuser.me/api/portraits/med/women/20.jpg",
        name: "Paige Patel"));
    _users.add(UserFollowModel(
        image: "https://randomuser.me/api/portraits/med/women/36.jpg",
        name: "Vilma Peura"));
    _users.add(UserFollowModel(
        image: "https://randomuser.me/api/portraits/med/women/20.jpg",
        name: "Paige Patel"));
    _users.add(UserFollowModel(
        image: "https://randomuser.me/api/portraits/med/women/36.jpg",
        name: "Vilma Peura"));
    _users.add(UserFollowModel(
        image: "https://randomuser.me/api/portraits/med/women/20.jpg",
        name: "Paige Patel"));
    _users.add(UserFollowModel(
        image: "https://randomuser.me/api/portraits/med/women/36.jpg",
        name: "Vilma Peura"));
    _users.add(UserFollowModel(
        image: "https://randomuser.me/api/portraits/med/women/20.jpg",
        name: "Paige Patel"));
    _users.add(UserFollowModel(
        image: "https://randomuser.me/api/portraits/med/women/36.jpg",
        name: "Vilma Peura"));
    _users.add(UserFollowModel(
        image: "https://randomuser.me/api/portraits/med/women/20.jpg",
        name: "Paige Patel"));
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
  String image;

  UserFollowModel({this.name, this.image});

  @override
  String toString() {
    return '{ ${this.name}, ${this.image}  }';
  }
}
