import 'package:cooking_master/screens/user_profile_watch_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModalInsideModal extends StatelessWidget {
  final String name;
  final UserProfileWatchScreenState parent;
  const ModalInsideModal({Key key, this.name, this.parent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: CupertinoPageScaffold(
      navigationBar:
          CupertinoNavigationBar(leading: Container(), middle: Text(name)),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
                title: Text('Unfollow'),
                leading: Icon(Icons.unsubscribe),
                onTap: () => {
                      parent.setState(() {
                        parent.isFollowed = false;
                      }),
                      Navigator.of(context).pop(),
                    }),
          ],
        ),
      ),
    ));
  }
}
