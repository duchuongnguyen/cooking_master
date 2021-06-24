import 'package:cooking_master/screens/notification_screen.dart';
import 'package:cooking_master/screens/UserProfileWatch/user_profile_watch_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNotificationDialog extends StatelessWidget {
  final NotificationScreenState parent;
  final int index;
  const BottomNotificationDialog({Key key, this.parent, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(leading: Container()),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
                title: Text(
                  'Delete Notification',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () => {
                      parent.setState(() {
                        parent.users.removeAt(index);
                      }),
                      Navigator.of(context).pop(),
                    }),
          ],
        ),
      ),
    ));
  }
}
