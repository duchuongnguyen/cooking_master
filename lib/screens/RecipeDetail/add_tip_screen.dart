import 'dart:io';
import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/models/tip_model.dart';
import 'package:cooking_master/services/recipe_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddTipScreen extends StatefulWidget {
  final RecipeModel recipe;
  const AddTipScreen({
    Key key,
    @required this.recipe,
  }) : super(key: key);

  @override
  _AddTipScreenState createState() => _AddTipScreenState();
}

class _AddTipScreenState extends State<AddTipScreen> {
  final TextEditingController controller = TextEditingController();

  File _imageFile;
  String _imageUrl;
  @override
  Widget build(BuildContext context) {
    final RecipeModel recipe = widget.recipe;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              "Cancel",
              style: TextStyle(
                  color: blue2, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 5),
            child: TextButton(
              child: Text(
                "Submit",
                style: TextStyle(
                    color: blue2, fontSize: 14, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                TipModel tip = TipModel();
                tip.content = controller.text;
                tip.image = null;
                tip.uidLiked = [];
                RecipeService().uploadTipAndImage(recipe.id, tip, _imageFile);
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Text(
                "Share your tip for ${recipe.name}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )),
        Expanded(
            flex: 12,
            child: TextFormField(
              controller: controller,
              autofocus: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              ),
              maxLines: null,
            )),
        _imageFile != null
            ? Expanded(
                flex: 8,
                child: Stack(overflow: Overflow.visible, children: [
                  Image.file(
                    _imageFile,
                    fit: BoxFit.contain,
                  ),
                  Positioned(
                    top: -10,
                    right: -10,
                    child: GestureDetector(
                      onTap: () => {
                        setState(() {
                          _imageFile = null;
                        })
                      },
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration:
                            BoxDecoration(shape: BoxShape.circle, color: blue2),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  )
                ]))
            : Divider(
                thickness: 1,
                color: blue2,
              ),
        _imageFile == null && _imageUrl == null
            ? GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.image,
                          color: blue2,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Add a tip photo",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: blue2),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
        SizedBox(height: 7),
        Padding(
            padding: EdgeInsets.only(
                bottom: (MediaQuery.of(context).viewInsets.bottom))),
      ]),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
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
        _imageFile = File(pickedFile.path);
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
        _imageFile = File(pickedFile.path);
      });
    }
  }
}
