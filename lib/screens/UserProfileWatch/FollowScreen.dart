import 'package:flutter/material.dart';

import 'package:cooking_master/screens/UserProfileWatch/FollowersTab.dart';
import 'package:cooking_master/screens/UserProfileWatch/FollowingTab.dart';

class FollowScreen extends StatefulWidget {
  final String tab;

  const FollowScreen({Key key, this.tab}) : super(key: key);

  @override
  _FollowScreenState createState() => _FollowScreenState();
}

class _FollowScreenState extends State<FollowScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
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
      body: TabBarView(
          controller: _tabController,
          children: [FollowersTab(), FollowingTab(),]),
    );
  }
}
