import 'package:cooking_master/models/recipe_card_model.dart';
import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/models/user_model.dart';
import 'package:cooking_master/screens/UserProfile/category_item.dart';
import 'package:cooking_master/screens/UserProfileWatch/FollowScreen.dart';
import 'package:cooking_master/services/auth_service.dart';
import 'package:cooking_master/services/recipe_service.dart';
import 'package:cooking_master/services/userprofile_service.dart';
import 'package:cooking_master/widgets/appbar.dart';
import 'package:cooking_master/widgets/recipe_detail_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cooking_master/widgets/CustomBackButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class UserProfileWatchScreen extends StatefulWidget {
  final String uid;

  const UserProfileWatchScreen({
    Key key,
    @required this.uid,
  }) : super(key: key);

  @override
  UserProfileWatchScreenState createState() => UserProfileWatchScreenState();
}

class UserProfileWatchScreenState extends State<UserProfileWatchScreen> {
  bool isFollowed = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      appBar: buildAppBar(
        context,
        title: '',
        leading: CustomBackButton(tapEvent: () => Navigator.pop(context)),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return StreamBuilder<UserModel>(
        stream: UserProfileService().loadProfile(widget.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                                border: Border.all(),
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: CupertinoThumbPainter.radius,
                                backgroundImage:
                                    NetworkImage(snapshot.data.userImage),
                              )),
                        ),
                      ),

                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Hero(
                            tag: "username",
                            child: Text(
                              snapshot.data.userName,
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
                              snapshot.data.userAddress,
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
                                                  followers: snapshot
                                                      .data.userFollower,
                                                  following: snapshot
                                                      .data.userFollowing,
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
                                        snapshot.data.userFollower.length
                                                .toString() ??
                                            "0",
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
                                                followers:
                                                    snapshot.data.userFollower,
                                                following:
                                                    snapshot.data.userFollowing,
                                                tab: "following")));
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
                                        snapshot.data.userFollowing.length
                                                .toString() ??
                                            "0",
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
                              snapshot.data.userBio,
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
                          child: StreamBuilder<bool>(
                              stream: UserProfileService().isFollow(
                                  Auth().currentUser.uid, snapshot.data.userId),
                              builder: (context, snapshot1) {
                                if (snapshot1.hasData) {
                                  isFollowed = snapshot1.data;
                                  if (isFollowed) {
                                    return InkWell(
                                      onTap: () {
                                        UserProfileService().unfollowUser(
                                            Auth().currentUser.uid,
                                            snapshot.data.userId);

                                        setState(() {
                                          isFollowed = false;
                                        });
                                      },
                                      child: Container(
                                        width: 150,
                                        height: 45,
                                        padding: EdgeInsets.only(
                                            right: 20.0, left: 26.0),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black
                                                    .withOpacity(0.6),
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
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Icon(Icons.keyboard_arrow_down)
                                            ]),
                                      ),
                                    );
                                  }
                                  return Ink(
                                    decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: InkWell(
                                        onTap: () {
                                          UserProfileService().followUser(
                                              Auth().currentUser.uid,
                                              snapshot.data.userId);
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
                                  );
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                        ),
                      ),
                      Center(
                        child: StickyHeader(
                            header: CategoryItem(),
                            content: Container(
                              child: FutureBuilder<List<RecipeModel>>(
                                  future: RecipeService()
                                      .getRecipesByOwner(widget.uid),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.data.length != 0) {
                                        return ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (context, index) {
                                            return RecipeDetailCard(
                                                recipe: snapshot.data[index]);
                                          },
                                        );
                                      } else {
                                        return Text('No post yet');
                                      }
                                    } else {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                  }),
                            )),
                      ),
                      //List recipes
                    ],
                  ),
                ));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
