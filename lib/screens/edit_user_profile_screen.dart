import 'dart:io';
import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/models/user_model.dart';
import 'package:cooking_master/screens/EditUserProfile/edit_user_profile_information.dart';
import 'package:cooking_master/screens/UserProfile/edit_user_image.dart';
import 'package:cooking_master/services/userprofile_service.dart';
import 'package:cooking_master/widgets/CustomBackButton.dart';
import 'package:cooking_master/widgets/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditUserProfileScreen extends StatefulWidget {
  UserModel user;
  EditUserProfileScreen({Key key, this.user}) : super(key: key);
  @override
  _EditUserProfileScreenState createState() => _EditUserProfileScreenState();
}

class _EditUserProfileScreenState extends State<EditUserProfileScreen> {
  File _image;
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
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    final userProfile = Provider.of<UserProfileService>(context, listen: false);
    var uid = widget.user.userId;
    return StreamBuilder<UserModel>(
      stream: userProfile.loadProfile(uid),
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        if (snapshot.hasData) {
          widget.user = snapshot.data;
          return Container(
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
                                builder: (context) => EditUserImage(
                                      imageurl: widget.user.userImage,
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
                          shape: BoxShape.circle,
                          // border: Border.all(),
                        ),
                        child: CircleAvatar(
                          radius: CupertinoThumbPainter.radius,
                          backgroundImage: NetworkImage(widget.user.userImage),
                        )),
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
                                builder: (context) =>
                                    EditUserProfileInformation(
                                      user: widget.user,
                                      type: "name",
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
                        widget.user.userName,
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
                                builder: (context) =>
                                    EditUserProfileInformation(
                                      user: widget.user,
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
                        widget.user.userAddress,
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
                                builder: (context) =>
                                    EditUserProfileInformation(
                                      user: widget.user,
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
                        widget.user.userBio,
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
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Future getImage() async {
    // ignore: invalid_use_of_visible_for_testing_member
    final pickedFile = await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 400,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        print('Image Path $_image');
      });
    }
  }
}
