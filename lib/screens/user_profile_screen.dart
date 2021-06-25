import 'package:cooking_master/models/recipe_card_model.dart';
import 'package:cooking_master/models/user_model.dart';
import 'package:cooking_master/screens/UserProfile/FollowScreen.dart';
import 'package:cooking_master/screens/UserProfile/category_item.dart';
import 'package:cooking_master/screens/edit_user_profile_screen.dart';
import 'package:cooking_master/services/auth_service.dart';
import 'package:cooking_master/services/userprofile_service.dart';
import 'package:cooking_master/widgets/appbar.dart';
import 'package:cooking_master/widgets/recipe_detail_card.dart';
import 'package:cooking_master/widgets/show_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cooking_master/widgets/CustomBackButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';

class UserProfileScreen extends StatefulWidget {
  UserProfileScreen();
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

Future<void> _signOut(BuildContext context) async {
  try {
    //await manager.signInWithGoogle();
    final auth = Provider.of<AuthBase>(context, listen: false);
    await auth.signOut();
    Navigator.pop(context);
  } on Exception catch (e) {
    // _showSignInError(context, e);
  }
}

Future<void> _confirmSignOut(BuildContext context) async {
  final didRequestSignOut = await showAlertDialog(
    context,
    title: 'Logout',
    content: 'Are you sure that you want to logout?',
    cancelActionText: 'Cancel',
    defaultActionText: 'Logout',
  );
  if (didRequestSignOut == true) {
    _signOut(context);
  }
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  UserModel user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      appBar: buildAppBar(
        context,
        title: '',
        actions: [
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
                            user: user,
                          )));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () => _confirmSignOut(context),
          ),
        ],
        leading: CustomBackButton(
          tapEvent: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<UserModel>(
      stream: UserProfileService().loadProfile(auth.currentUser.uid),
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          user = snapshot.data;
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
                              backgroundImage: NetworkImage(user.userImage),
                            )),
                      ),
                    ),

                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Hero(
                          tag: "username",
                          child: Text(
                            user.userName ?? "",
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
                            user.userAddress ?? "",
                            style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
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
                                                followers: user.userFollower,
                                                following: user.userFollowing,
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
                                      user.userFollower.length.toString() ??
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
                                                tab: "following",
                                                followers: user.userFollower,
                                                following: user.userFollowing,
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
                                      user.userFollowing.length.toString() ??
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
                        margin: EdgeInsets.only(top: 25, bottom: 15),
                        padding: EdgeInsets.only(left: 25, right: 25),
                        child: Hero(
                          tag: "userbio",
                          child: Text(
                            user.userBio ?? "",
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
                    Center(
                        child: StickyHeader(
                      header: CategoryItem(),
                      content: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cards.length,
                        itemBuilder: (context, index) {
                          return RecipeDetailCard(
                            recipe: cards[index],
                          );
                        },
                      ),
                    ))
                  ],
                ),
              ));
        }
        if (snapshot.hasError) {
          return Column(children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text('Stack trace: ${snapshot.stackTrace}'),
            ),
          ]);
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
