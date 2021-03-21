import 'package:cooking_master/constants/color_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 8),
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            //Custom Appbar
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //Language Button
                  GestureDetector(
                    onTap: () {
                      //TODO: Open language choose
                    },
                      child: Container(
                        height: 39,
                        width: 39,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          //Todo: Load Image Compared with User's language
                          image: DecorationImage(image: AssetImage('assets/images/vietnam.png'))
                        ),
                      ),
                  ),

                  //Appbar Text
                  Text('Cooking Master', style: GoogleFonts.inter(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: kBlackColor
                  )),

                  //User Profile
                  GestureDetector(
                    onTap: () {
                      //TODO: Open User Profile
                    },
                    child: Container(
                      height: 39,
                      width: 39,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(image: AssetImage('assets/images/user.png'))
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
