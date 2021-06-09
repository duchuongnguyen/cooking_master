import 'package:cooking_master/models/recipe_card_model.dart';
import 'package:cooking_master/models/user_model.dart';
import 'package:cooking_master/screens/UserProfile/category_item.dart';
import 'package:cooking_master/screens/UserProfileWatch/FollowScreen.dart';
import 'package:cooking_master/screens/edit_user_profile_screen.dart';
import 'package:cooking_master/widgets/appbar.dart';
import 'package:cooking_master/widgets/recipe_detail_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cooking_master/widgets/CustomBackButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import 'UserProfileWatch/bottom_drawer.dart';

class UserProfileWatchScreen extends StatefulWidget {
  final UserModel user;
  UserProfileWatchScreen(this.user);
  @override
  UserProfileWatchScreenState createState() => UserProfileWatchScreenState();
}

class UserProfileWatchScreenState extends State<UserProfileWatchScreen> {
  bool isFollowed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        appBar: buildAppBar(context, title: '', actions: [
          IconButton(
            icon: Icon(
              Icons.edit_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditUserProfileScreen(
                            user: widget.user,
                          )));
            },
          ),
          IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ),
              onPressed: () {} //() => _confirmSignOut(context),
              ),
        ], leading: CustomBackButton(
          tapEvent: () {
            Navigator.pop(context);
          },
        )),
        body: _buildBody(context, widget.user));
  }

  Widget _buildBody(BuildContext context, UserModel user) {
    // return FutureBuilder<UserModel>(
    //   builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
    //     if (snapshot.hasData) {
    //       user = snapshot.data;
    return Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              Center(
                child: Hero(
                  tag: "avatar",
                  child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // border: Border.all(),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: CupertinoThumbPainter.radius,
                        //backgroundImage: NetworkImage(user.userImage),
                        backgroundImage: AssetImage(user.userImage),
                      )),
                ),
              ),

              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Hero(
                    tag: "username",
                    child: Text(
                      user.userName,
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 21,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Hero(
                    tag: "useraddress",
                    child: Text(
                      user.userAddress,
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              //Following-Follower
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FollowScreen(
                                          tab: "followers",
                                        )));
                          },
                          child: Column(
                            children: [
                              Text(
                                "Followers",
                                style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.5,
                                    height: 1.5),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                user.userFollowed.toString(),
                                style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.black.withOpacity(0.7),
                          thickness: 0.5,
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FollowScreen(
                                          tab: "following",
                                        )));
                          },
                          child: Column(
                            children: [
                              Text(
                                "Following",
                                style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.5,
                                    height: 1.5),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                user.userFollowing.toString(),
                                style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //Bio Text
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 15, bottom: 15),
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: Hero(
                    tag: "userbio",
                    child: Text(
                      user.userBio,
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                          height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              //Follow Button
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 15, bottom: 20),
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isFollowed
                            ? InkWell(
                                onTap: () => {
                                  setState(() async {
                                    await showBarModalBottomSheet(
                                      expand: false,
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) => ModalInsideModal(
                                          name: widget.user.userName,
                                          parent: this),
                                    );
                                  })
                                },
                                child: Container(
                                  width: 150,
                                  height: 45,
                                  padding:
                                      EdgeInsets.only(right: 20.0, left: 26.0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black.withOpacity(0.6),
                                          width: 2),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Following",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Icon(Icons.keyboard_arrow_down)
                                      ]),
                                ),
                              )
                            : Ink(
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isFollowed = true;
                                      });
                                    },
                                    child: Container(
                                      width: 150,
                                      height: 45,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Text(
                                        "Follow",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                              )
                      ]),
                ),
              ),
              Center(
                child: StickyHeader(
                    header: CategoryItem(),
                    content: Container(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cards.length,
                        itemBuilder: (context, index) {
                          return RecipeDetailCard(
                            recipe: cards[index],
                            size: MediaQuery.of(context).size,
                          );
                        },
                      ),
                    )),
              ),
              //List recipes
            ],
          ),
        ));
  }
  //   if (snapshot.hasError) {
  //     return Column(children: [
  //       Icon(
  //         Icons.error_outline,
  //         color: Colors.red,
  //         size: 60,
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.only(top: 16),
  //         child: Text('Error: ${snapshot.error}'),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.only(top: 8),
  //         child: Text('Stack trace: ${snapshot.stackTrace}'),
  //       ),
  //     ]);
  //   }
  //   return Scaffold(
  //     body: Center(
  //       child: CircularProgressIndicator(),
  //     ),
  //   );
  // },
  //);
  //}
}
