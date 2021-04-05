import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/screens/EditUserProfile/edit_user_profile_information.dart';
import 'package:cooking_master/widgets/CustomBackButton.dart';
import 'package:cooking_master/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditUserProfileScreen extends StatelessWidget {
  final user;

  const EditUserProfileScreen({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: buildAppBar(context, title: '', actions: [],
          leading: CustomBackButton(
        tapEvent: () {
          Navigator.pop(context);
        },
      )),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ảnh đại diện",
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditUserProfileInformation(
                                  user: user,
                                  type: "image",
                                )));
                  },
                  child: Text(
                    "Chỉnh sửa",
                    style: GoogleFonts.roboto(
                        color: blue3,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Center(
              child: Hero(
                tag: "avatar",
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      image:
                          DecorationImage(image: AssetImage(user.userImage))),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tên hiển thị",
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditUserProfileInformation(
                                  user: user,
                                  type: "username",
                                )));
                  },
                  child: Text(
                    "Chỉnh sửa",
                    style: GoogleFonts.roboto(
                        color: blue3,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Hero(
                  tag: "username",
                  child: Text(
                    "Nguyễn Đức Hướng",
                    style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Địa chỉ",
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditUserProfileInformation(
                                  user: user,
                                  type: "address",
                                )));
                  },
                  child: Text(
                    "Chỉnh sửa",
                    style: GoogleFonts.roboto(
                        color: blue3,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
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
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tiểu sử",
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditUserProfileInformation(
                                  user: user,
                                  type: "bio",
                                )));
                  },
                  child: Text(
                    "Chỉnh sửa",
                    style: GoogleFonts.roboto(
                        color: blue3,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 15),
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
          ],
        ),
      ),
    );
  }
}
