import 'package:cooking_master/models/user_model.dart';
import 'package:cooking_master/screens/SavedRecipe/RecipeCategoryScreen.dart';
import 'package:cooking_master/screens/saved_recipe_screen.dart';
import 'package:cooking_master/services/userprofile_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../user_profile_screen.dart';

buildAddCategoryButton(BuildContext context, TabController _tabController,
    TextEditingController _categoryController) {
  switch (_tabController.index) {
    case 2:
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("New Favorite Topic"),
              content: TextField(
                controller: _categoryController,
              ),
              actions: [
                MaterialButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pop(_categoryController.text.toString());
                    },
                    child: Text("Submit"))
              ],
            );
          });
    default:
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RecipeCategoryScreen(kind: "saved")));
      break;
  }
}

AppBar buildSavedRecipeAppBar(
    BuildContext context,
    TabController _tabController,
    TextEditingController _categoryController,
    SavedRecipeScreenState parent) {
  return AppBar(
    backgroundColor: Colors.white,
    title: StreamBuilder<UserModel>(
      stream: UserProfileService()
          .loadProfile(FirebaseAuth.instance.currentUser.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data.userName,
            style: TextStyle(color: Colors.black),
          );
        }
        return CircularProgressIndicator();
      },
    ),
    actions: [
      Visibility(
        visible: _tabController.index == 0,
        child: IconButton(
          icon: Icon(
            Icons.library_add_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            buildAddCategoryButton(
                context, _tabController, _categoryController);
          },
        ),
      ),
    ],
    leading: GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => UserProfileScreen()));
      },
      child: Hero(
          tag: 'avatar',
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<UserModel>(
                future: UserProfileService()
                    .loadProfileFuture(FirebaseAuth.instance.currentUser.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data.userImage),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          )),
    ),
    bottom: TabBar(
      controller: _tabController,
      tabs: [
        Tab(
            child: Text(
          "Saved",
          style: GoogleFonts.roboto(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        )),
        Tab(
            child: Text(
          "Your recipe",
          style: GoogleFonts.roboto(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        )),
        Tab(
            child: Text(
          "Favorite Topic",
          style: GoogleFonts.roboto(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        ))
      ],
      onTap: (index) => {parent.setState(() {})},
    ),
  );
}
