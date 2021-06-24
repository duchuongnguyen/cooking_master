import 'package:cooking_master/screens/Notification/bottomDialog.dart';
import 'package:cooking_master/screens/UserProfileWatch/user_profile_watch_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  List<UserFollowModel> users = [];
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

            //Kind of noti (today, month, earlier)
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Today",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: users.length,
                itemBuilder: (context, int index) => GestureDetector(
                      onLongPress: () => {
                        setState(() async {
                          await showBarModalBottomSheet(
                            expand: false,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => BottomNotificationDialog(
                              parent: this,
                              index: index,
                            ),
                          );
                        })
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(users[index].image),
                        ),
                        title: RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                              TextSpan(
                                  text: users[index].name,
                                  //Tap to navigate to see another user proflie
                                  //recognizer: new TapGestureRecognizer()..onTap = () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfileWatchScreen(/*user*/))),
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: " " + users[index].message),
                              TextSpan(
                                  text: " " + users[index].time + " ",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6))),
                            ])),
                        trailing: users[index].showButton == false
                            ? null
                            : users[index].isFollowed
                                ? InkWell(
                                    onTap: () => {
                                      setState(() {
                                        users[index].isFollowed = false;
                                      })
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 30,
                                      padding: EdgeInsets.only(
                                          right: 5.0, left: 5.0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                              width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: Text(
                                        "Following",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  )
                                : Ink(
                                    decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            users[index].isFollowed = true;
                                          });
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 30,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          child: Text(
                                            "Follow",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )),
                                  ),
                      ),
                    )),
            SizedBox(height: 15),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "This month",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: users.length,
                itemBuilder: (context, int index) => GestureDetector(
                      onLongPress: () => {
                        setState(() async {
                          await showBarModalBottomSheet(
                            expand: false,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => BottomNotificationDialog(
                              parent: this,
                              index: index,
                            ),
                          );
                        })
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(users[index].image),
                        ),
                        title: RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                              TextSpan(
                                  text: users[index].name,
                                  //Tap to navigate to see another user proflie
                                  //recognizer: new TapGestureRecognizer()..onTap = () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfileWatchScreen(/*user*/))),
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: " " + users[index].message),
                              TextSpan(
                                  text: " " + users[index].time + " ",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6))),
                            ])),
                        trailing: users[index].showButton == false
                            ? null
                            : users[index].isFollowed
                                ? InkWell(
                                    onTap: () => {
                                      setState(() {
                                        users[index].isFollowed = false;
                                      })
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 30,
                                      padding: EdgeInsets.only(
                                          right: 5.0, left: 5.0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                              width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: Text(
                                        "Following",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  )
                                : Ink(
                                    decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            users[index].isFollowed = true;
                                          });
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 30,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          child: Text(
                                            "Follow",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )),
                                  ),
                      ),
                    )),
            SizedBox(height: 15),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Earlier",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: users.length,
                itemBuilder: (context, int index) => GestureDetector(
                      onLongPress: () => {
                        setState(() async {
                          await showBarModalBottomSheet(
                            expand: false,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => BottomNotificationDialog(
                              parent: this,
                              index: index,
                            ),
                          );
                        })
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(users[index].image),
                        ),
                        title: RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                              TextSpan(
                                  text: users[index].name,
                                  //Tap to navigate to see another user proflie
                                  //recognizer: new TapGestureRecognizer()..onTap = () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfileWatchScreen(/*user*/))),
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: " " + users[index].message),
                              TextSpan(
                                  text: " " + users[index].time + " ",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6))),
                            ])),
                        trailing: users[index].showButton == false
                            ? null
                            : users[index].isFollowed
                                ? InkWell(
                                    onTap: () => {
                                      setState(() {
                                        users[index].isFollowed = false;
                                      })
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 30,
                                      padding: EdgeInsets.only(
                                          right: 5.0, left: 5.0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                              width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: Text(
                                        "Following",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  )
                                : Ink(
                                    decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            users[index].isFollowed = true;
                                          });
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 30,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          child: Text(
                                            "Follow",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )),
                                  ),
                      ),
                    ))
          ],
        ),
      ),
    );
  }

  @override
  initState() {
    super.initState();
    _getUsers();
  }

  void _getUsers() {
    users.add(UserFollowModel(
        image: "https://randomuser.me/api/portraits/med/women/36.jpg",
        name: "Vilma Peura",
        message: " started following you.",
        time: "8s"));
    users.add(UserFollowModel(
        image: "https://randomuser.me/api/portraits/med/women/20.jpg",
        name: "Paige Patel",
        isFollowed: true,
        showButton: false, // When user is followed, dont show follow button
        message: " published her recipe.",
        time: "4h"));
  }
}

class UserFollowModel {
  String name;
  bool isFollowed;
  String image;
  String message;
  String time;
  bool showButton;

  UserFollowModel(
      {this.name,
      this.isFollowed = false,
      this.image,
      this.message,
      this.time,
      this.showButton = true});
}
