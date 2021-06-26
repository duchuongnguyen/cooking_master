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
                          title: Text(snapshot.data.userName),
                          trailing: InkWell(
                            onTap: () async {
                              await UserProfileService().unfollowUser(
                                  Auth().currentUser.uid,
                                  widget.following[index]);
                              setState(() {
                                widget.following.removeAt(index);
                              });
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
                                "Remove",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  });
            }));
  }
}
