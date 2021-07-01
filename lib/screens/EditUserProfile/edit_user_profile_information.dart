
import 'package:cooking_master/models/user_model.dart';
import 'package:cooking_master/services/userprofile_service.dart';
import 'package:cooking_master/widgets/CustomBackButton.dart';
import 'package:cooking_master/widgets/appbar.dart';
import 'package:cooking_master/widgets/show_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

var editor;

var editTypes = [
  {
    "type": "image",
    "lowerCase": "ảnh đại diện",
    "firstUpperCase": "Ảnh đại diện"
  },
  {
    "type": "name",
    "lowerCase": "tên hiển thị",
    "firstUpperCase": "Tên hiển thị",
  },
  {"type": "address", "lowerCase": "địa chỉ", "firstUpperCase": "Địa chỉ"},
  {"type": "bio", "lowerCase": "tiểu sử", "firstUpperCase": "Tiểu sử"},
];

class EditUserProfileInformation extends StatelessWidget {
   EditUserProfileInformation({Key key, this.type, this.user})
      : super(key: key);
  final type;
  final UserModel user;
  final usernameController = TextEditingController();
  Future<void> _confirmUpdate(BuildContext context) async {
    final userProfile = Provider.of<UserProfileService>(context, listen: false);
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'Save change',
      content: 'Are you sure that you want to save change?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Save',
    );
    if (didRequestSignOut == true) {
     await userProfile.updateUser(user.userId, type, usernameController.text );
     Navigator.pop(context,true);
    }
  }
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names

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
              onPressed: () => _confirmUpdate(context),
            ),
          ], leading: CustomBackButton(
        tapEvent: () {
          Navigator.pop(context);
        },
      )
      ),
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
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(user.userImage),
                      )
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: ()  {},
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
              controller: usernameController,
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
