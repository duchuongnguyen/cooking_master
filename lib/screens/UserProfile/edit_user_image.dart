import 'dart:io';
import 'package:cooking_master/services/auth.dart';
import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/services/firebase_storage.dart';
import 'package:cooking_master/services/firebase_userprofile.dart';
import 'package:cooking_master/widgets/CustomBackButton.dart';
import 'package:cooking_master/widgets/appbar.dart';
import 'package:cooking_master/widgets/show_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditUserImage extends StatefulWidget {
  const EditUserImage({Key key, this.imageurl}) : super(key: key);
  final imageurl;
  _EditUserImageState createState() => _EditUserImageState();
}

class _EditUserImageState extends State<EditUserImage> {
  File _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: buildAppBar(context, title: '', actions: [
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
        )),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
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
                  onTap: getImage,
                  child: Text(
                    "Thư viện",
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
                      radius: 50,
                      child: _image == null
                          ? Image.network(widget.imageurl)
                          : Image.file(_image),
                    )),
              ),
            ),
          ],
        ));
  }

  Future<void> getImage() async {
    var pickedImage =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    _image = File(pickedImage.path);
    setState(() {
      print('Image Path $_image');
    });
  }

  Future<void> _confirmUpdate(BuildContext context) async {
    final userStorage = Provider.of<StorageRepo>(context, listen: false);
    final userProfile = Provider.of<UserProfile>(context, listen: false);
    final user = Provider.of<AuthBase>(context, listen: false);
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'Save change',
      content: 'Are you sure that you want to save change?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Save',
    );
    if (didRequestSignOut == true) {
      var imageurl = await userStorage.uploadFile(_image, user.currentUser.uid);
      await userProfile.updateUser(user.currentUser.uid, 'imageurl', imageurl);
      Navigator.pop(context, true);
    }
  }
}
