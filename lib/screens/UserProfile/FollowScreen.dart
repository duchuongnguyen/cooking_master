import 'package:flutter/material.dart';

import 'package:cooking_master/screens/UserProfile/FollowersTab.dart';
import 'package:cooking_master/screens/UserProfile/FollowingTab.dart';

class FollowScreen extends StatefulWidget {
  final String tab;
  final List<String> followers;
  final List<String> following;

  const FollowScreen({
    Key key,
    this.tab,
    @required this.followers,
    @required this.following,
  }) : super(key: key);

  @override
  _FollowScreenState createState() => _FollowScreenState();
}

class _FollowScreenState extends State<FollowScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => _tabController.animateTo(widget.tab == "following" ? 1 : 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
                child: Text(
              "Followers",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            )),
            Tab(
                child: Text(
              "Following",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            )),
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        FollowersTab(followers: widget.followers),
        FollowingTab(following: widget.following),
      ]),
    );
  }
}
