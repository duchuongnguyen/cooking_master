import 'dart:io';

import 'package:cooking_master/screens/recipe_form/recipe_form_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RecipeImage extends StatefulWidget {
  final RecipeFormScreenState parent;

  const RecipeImage({Key key, this.parent}) : super(key: key);

  @override
  _RecipeImageState createState() => _RecipeImageState();
}

class _RecipeImageState extends State<RecipeImage> {
  @override
  Widget build(BuildContext context) {
    if (widget.parent.imageFile == null && widget.parent.imageUrl == null) {
      return GestureDetector(
        onTap: () => _showPicker(context),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Stack(
            children: [
              Image.asset(
                'assets/images/food-placeholder.png',
                fit: BoxFit.contain,
              ),
              Positioned.fill(
                bottom: 15,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_outlined),
                      SizedBox(width: 5),
                      Text("Upload recipe photo"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (widget.parent.imageFile != null) {
      print('showing image from local file');
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.file(
              widget.parent.imageFile,
              fit: BoxFit.contain,
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white)),
                width: 120,
                height: 40,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => _showPicker(context),
                      child: Container(
                        child: Row(
                          children: [
                            Icon(Icons.camera_alt_outlined,
                                color: Colors.white),
                            Text(
                              " Edit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    VerticalDivider(
                      thickness: 1,
                      color: Colors.white,
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.parent.imageFile = null;
                            widget.parent.imageUrl = null;
                          });
                        },
                        child: Icon(
                          Icons.delete_outlined,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      print('showing image from url');
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            Image.network(
              widget.parent.imageUrl,
              fit: BoxFit.contain,
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white)),
                width: 120,
                height: 40,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => _showPicker(context),
                      child: Container(
                        child: Row(
                          children: [
                            Icon(Icons.camera_alt_outlined,
                                color: Colors.white),
                            Text(
                              " Edit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    VerticalDivider(
                      thickness: 1,
                      color: Colors.white,
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.parent.imageFile = null;
                            widget.parent.imageUrl = null;
                          });
                        },
                        child: Icon(
                          Icons.delete_outlined,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _imgFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 400,
    );

    if (pickedFile != null) {
      setState(() {
        widget.parent.imageFile = File(pickedFile.path);
      });
    }
  }

  Future _imgFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 400,
    );

    if (pickedFile != null) {
      setState(() {
        widget.parent.imageFile = File(pickedFile.path);
      });
    }
  }
}
