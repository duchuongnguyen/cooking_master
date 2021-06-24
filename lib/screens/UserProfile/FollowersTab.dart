import 'package:cooking_master/models/user_model.dart';
import 'package:cooking_master/services/auth_service.dart';
import 'package:cooking_master/services/userprofile_service.dart';
import 'package:flutter/material.dart';

class   FollowersTab extends StatefulWidget {
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
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(snapshot.data.userName),
                            ],
                          ),
                          trailing: InkWell(
                            onTap: () async {
                              await UserProfileService().unfollowUser(
                                  widget.followers[index],
                                  Auth().currentUser.uid);
                              setState(() {
                                widget.followers.removeAt(index);
                              });
                            },
                            child: Container(
                              width: 110,
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
