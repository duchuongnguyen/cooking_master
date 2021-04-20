import 'package:cooking_master/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../user_profile_screen.dart';

AppBar buildSavedRecipeAppBar(BuildContext context) {
    return buildAppBar(
        context,
        title: "Minh Huy Bui",
        actions: [
          IconButton(
            icon: Icon(
              Icons.insights_outlined,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
        leading: Builder(builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserProfileScreen()));
            },
            child: Hero(
              tag: 'avatar',
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage("assets/images/user.jpg"))),
              ),
            ),
          );
        }),
        bottom: TabBar(
          tabs: [
            Tab(
                child: Text(
              "Saved",
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            )),
            Tab(
                child: Text(
              "Your recipe",
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            )),
            Tab(
                child: Text(
              "Favorite Topic",
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ))
          ],
        ),
      );
  }