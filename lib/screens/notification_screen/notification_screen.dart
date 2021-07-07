import 'package:cooking_master/models/notification_model.dart';
import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/models/user_model.dart';
import 'package:cooking_master/screens/RecipeDetail/recipe_detail_screen.dart';
import 'package:cooking_master/screens/UserProfileWatch/user_profile_watch_screen.dart';
import 'package:cooking_master/screens/notification_screen/bottomDialog.dart';
import 'package:cooking_master/services/notification_service.dart';
import 'package:cooking_master/services/recipe_service.dart';
import 'package:cooking_master/services/userprofile_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Notification",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 15),
            _ListNotification(
              header: 'News',
              stream: NotificationService()
                  .getNewNotifications(FirebaseAuth.instance.currentUser.uid),
              notificationScreenState: this,
            ),
            _ListNotification(
              header: 'Earlier',
              stream: NotificationService().getEarlierNotifications(
                  FirebaseAuth.instance.currentUser.uid),
              notificationScreenState: this,
            ),
          ],
        ),
      ),
    );
  }
}

class _ListNotification extends StatefulWidget {
  final Stream stream;
  final String header;
  final NotificationScreenState notificationScreenState;

  const _ListNotification({
    Key key,
    @required this.header,
    @required this.stream,
    @required this.notificationScreenState,
  }) : super(key: key);

  @override
  _ListNotificationState createState() => _ListNotificationState();
}

class _ListNotificationState extends State<_ListNotification> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.header,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
        SizedBox(height: 10),
        StreamBuilder<List<NotificationModel>>(
            stream: widget.stream,
            builder: (context, notification) {
              if (notification.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: notification.data.length,
                    itemBuilder: (context, int index) => GestureDetector(
                          onLongPress: () => {
                            setState(() {
                              showBarModalBottomSheet(
                                expand: false,
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) => BottomNotificationDialog(
                                  parent: widget.notificationScreenState,
                                  notification: notification.data[index],
                                ),
                              );
                            })
                          },
                          child: FutureBuilder<UserModel>(
                              future: UserProfileService().loadProfileFuture(
                                  notification.data[index].owner),
                              builder: (context, user) {
                                if (user.connectionState ==
                                    ConnectionState.done) {
                                  return ListTile(
                                    leading: GestureDetector(
                                        child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                user.data.userImage)),
                                        onTap: () {
                                          if (user.data.userId !=
                                              FirebaseAuth
                                                  .instance.currentUser.uid)
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserProfileWatchScreen(
                                                            uid: user
                                                                .data.userId)));
                                        }),
                                    title: GestureDetector(
                                        onTap: () async {
                                          if (notification
                                                  .data[index].idRecipe !=
                                              '') {
                                            RecipeModel recipe =
                                                await RecipeService().getRecipe(
                                                    notification
                                                        .data[index].idRecipe);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RecipeDetailScreen(
                                                            recipe: recipe)));
                                          }
                                        },
                                        child: RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    color: Colors.black),
                                                children: [
                                              TextSpan(
                                                  text: user.data.userName,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                  text: " " +
                                                      notification
                                                          .data[index].content),
                                              TextSpan(
                                                  text: " " +
                                                      timeago.format(DateTime
                                                              .now()
                                                          .subtract(DateTime
                                                                  .now()
                                                              .difference(
                                                                  notification
                                                                      .data[
                                                                          index]
                                                                      .createdAt
                                                                      .toDate()))) +
                                                      " ",
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.6))),
                                            ]))),
                                    trailing: notification
                                                .data[index].idRecipe !=
                                            ''
                                        ? null
                                        : user.data.userFollower.contains(
                                                FirebaseAuth
                                                    .instance.currentUser.uid)
                                            ? InkWell(
                                                onTap: () async {
                                                  await UserProfileService()
                                                      .unfollowUser(
                                                          FirebaseAuth.instance
                                                              .currentUser.uid,
                                                          user.data.userId);
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  width: 100,
                                                  height: 30,
                                                  padding: EdgeInsets.only(
                                                      right: 5.0, left: 5.0),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black
                                                              .withOpacity(0.6),
                                                          width: 1.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0)),
                                                  child: Text(
                                                    "Following",
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              )
                                            : Ink(
                                                decoration: BoxDecoration(
                                                    color: Colors.lightBlue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0)),
                                                child: InkWell(
                                                    onTap: () async {
                                                      await UserProfileService()
                                                          .followUser(
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser
                                                                  .uid,
                                                              user.data.userId);
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      width: 100,
                                                      height: 30,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0)),
                                                      child: Text(
                                                        "Follow",
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    )),
                                              ),
                                  );
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                        ));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ],
    );
  }
}
