import 'package:cooking_master/models/recipe_card_model.dart';
import 'package:cooking_master/models/user_model.dart';
import 'package:cooking_master/screens/UserProfile/category_item.dart';
import 'package:cooking_master/screens/edit_user_profile_screen.dart';
import 'package:cooking_master/services/auth.dart';
import 'package:cooking_master/widgets/appbar.dart';
import 'package:cooking_master/widgets/recipe_detail_card.dart';
import 'package:cooking_master/widgets/show_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cooking_master/widgets/CustomBackButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
  UserModel user = users[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          user: user,
                        )));
          },
        ),
        IconButton(
          icon: Icon(
            Icons.insights_outlined,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.logout,
            color: Colors.black,
          ),
          onPressed: () => _confirmSignOut(context),
        ),
      ], leading: CustomBackButton(
        tapEvent: () {
          Navigator.pop(context);
        },
      )),
      body: Container(
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
                        borderRadius: BorderRadius.circular(50),
                        image:
                            DecorationImage(image: AssetImage(user.userImage))),
                  ),
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
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  child: IntrinsicHeight(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Người theo dõi",
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
                          VerticalDivider(
                            color: Colors.black,
                            thickness: 0.5,
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                "Đang theo dõi",
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
                        ]),
                  ),
                ),
              ),
              //Bio Text
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 25),
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
              Center(
                child: CategoryItem(),
              ),
              //List recipes
              Container(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
