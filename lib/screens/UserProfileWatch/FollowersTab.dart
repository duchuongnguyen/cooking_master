import 'package:cooking_master/models/user_model.dart';
import 'package:cooking_master/services/auth_service.dart';
import 'package:cooking_master/services/userprofile_service.dart';
import 'package:flutter/material.dart';

class FollowersTab extends StatefulWidget {
  final List<String> followers;

  const FollowersTab({
    Key key,
    @required this.followers,
  }) : super(key: key);

  @override
  _FollowersTabState createState() => _FollowersTabState();
}

class _FollowersTabState extends State<FollowersTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            itemCount: widget.followers.length,
            itemBuilder: (context, int index) {
              return StreamBuilder<UserModel>(
                  stream:
                      UserProfileService().loadProfile(widget.followers[index]),
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
