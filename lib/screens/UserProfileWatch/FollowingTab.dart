import 'package:cooking_master/models/user_model.dart';
import 'package:cooking_master/services/auth_service.dart';
import 'package:cooking_master/services/userprofile_service.dart';
import 'package:flutter/material.dart';

class FollowingTab extends StatefulWidget {
  final List<String> following;

  const FollowingTab({
    Key key,
    @required this.following,
  }) : super(key: key);

  @override
  _FollowingTabState createState() => _FollowingTabState();
}

class _FollowingTabState extends State<FollowingTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            itemCount: widget.following.length,
            itemBuilder: (context, int index) {
              return StreamBuilder<UserModel>(
                  stream:
                      UserProfileService().loadProfile(widget.following[index]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(snapshot.data.userImage),
                        ),
                        title: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              snapshot.data.userId == Auth().currentUser.uid
                                  ? '${snapshot.data.userName} (me)'
                                  : '${snapshot.data.userName}'),
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  });
            }));
  }
}
