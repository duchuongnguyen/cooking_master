import 'package:cooking_master/models/notification_model.dart';
import 'package:cooking_master/screens/notification_screen/notification_screen.dart';
import 'package:cooking_master/services/notification_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNotificationDialog extends StatelessWidget {
  final NotificationScreenState parent;
  final NotificationModel notification;

  const BottomNotificationDialog({
    Key key,
    this.parent,
    @required this.notification,
  }) : super(key: key);

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
                NotificationService().deleteNotification(notification),
                Navigator.of(context).pop(),
              },
            ),
          ],
        ),
      ),
    ));
  }
}
