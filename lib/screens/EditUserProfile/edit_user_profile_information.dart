import 'package:cooking_master/models/user_model.dart';
import 'package:cooking_master/widgets/CustomBackButton.dart';
import 'package:cooking_master/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var editor;

var editTypes = [
  {
    "type": "image",
    "lowerCase": "ảnh đại diện",
    "firstUpperCase": "Ảnh đại diện"
  },
  {
    "type": "username",
    "lowerCase": "tên hiển thị",
    "firstUpperCase": "Tên hiển thị",
  },
  {"type": "address", "lowerCase": "địa chỉ", "firstUpperCase": "Địa chỉ"},
  {"type": "bio", "lowerCase": "tiểu sử", "firstUpperCase": "Tiểu sử"},
];

class EditUserProfileInformation extends StatelessWidget {
  final type;
  final UserModel user;

  const EditUserProfileInformation({Key key, this.type, this.user})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < editTypes.length; i++) {
      if (editTypes[i]["type"] == type) {
        editor = editTypes[i];
        break;
      }
    }
    return Scaffold(
      extendBody: true,
      appBar: buildAppBar(context,
          title: 'Chỉnh sửa ' + editor["lowerCase"],
          actions: [
            IconButton(
              icon: Icon(
                Icons.done,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ], leading: CustomBackButton(
        tapEvent: () {
          Navigator.pop(context);
        },
      )),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Divider(thickness: 1.5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Hero(
                  tag: "avatar",
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image:
                            DecorationImage(image: AssetImage(user.userImage))),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Hero(
                    tag: "username",
                    child: Text(
                      user.userName,
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
            Divider(thickness: 1.5),
            TextField(
              decoration: InputDecoration(
                hintText: editor["firstUpperCase"] + ' của bạn',
                counterText: "0/101",
              ),
            )
          ],
        ),
      ),
    );
  }
}
