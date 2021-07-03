import 'dart:io';

import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/screens/recipe_form/category_field.dart';
import 'package:cooking_master/screens/recipe_form/description_field.dart';
import 'package:cooking_master/screens/recipe_form/name_field.dart';
import 'package:cooking_master/screens/recipe_form/recipe_image.dart';
import 'package:cooking_master/services/recipe_service.dart';
import 'package:cooking_master/widgets/CustomBackButton.dart';
import 'package:cooking_master/widgets/appbar.dart';
import 'package:cooking_master/widgets/show_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class RecipeFormScreen extends StatefulWidget {
  final bool isUpdating;
  final RecipeModel currentRecipe;

  RecipeFormScreen({
    Key key,
    @required this.isUpdating,
    this.currentRecipe,
  }) : super(key: key);

  @override
  RecipeFormScreenState createState() => RecipeFormScreenState();
}

class RecipeFormScreenState extends State<RecipeFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RecipeModel currentRecipe;
  String imageUrl;
  File imageFile;
  var _ingredientWidgets = <Widget>[];
  var _directionWidgets = <Widget>[];
  var _directionImageUrls = <String>[];
  var _directionImageFiles = <File>[];

  @override
  void initState() {
    super.initState();

    if (widget.currentRecipe != null) {
      currentRecipe = widget.currentRecipe;
    } else {
      currentRecipe = RecipeModel();
    }

    _directionImageUrls = currentRecipe.directionImage;
    imageUrl = currentRecipe.image;

    Future.delayed(Duration.zero, () {
      currentRecipe.ingredients.forEach((element) {
        _ingredientWidgets.add(_buildIngredientField());
      });

      for (int i = 0; i < currentRecipe.directions.length; i++) {
        _directionWidgets.add(_buildDirectionField(i));
      }

      setState(() {});
    });
  }

  Widget _buildYieldsField() {
    return Row(
      children: [
        SizedBox(
          width: 16,
        ),
        Expanded(
            flex: 1,
            child: Text(
              "Serves",
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5,
                  height: 1.5),
            )),
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.all(12),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: '2 people',
                fillColor: Colors.blue[100],
                filled: true,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    const Radius.circular(15.0),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
              initialValue: currentRecipe.yields == null
                  ? ''
                  : currentRecipe.yields.toString(),
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 18),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Yields is required';
                }

                try {
                  int.parse(value);
                } on FormatException {
                  return 'Only number';
                }

                return null;
              },
              onSaved: (String value) {
                currentRecipe.yields = int.parse(value);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrepTimeField() {
    return Row(
      children: [
        SizedBox(
          width: 16,
        ),
        Expanded(
            flex: 1,
            child: Text(
              "Prep time",
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5,
                  height: 1.5),
            )),
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.all(12),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: '30 mins',
                suffix: Text("mins"),
                fillColor: Colors.blue[100],
                filled: true,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    const Radius.circular(15.0),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
              initialValue: currentRecipe.prepTime == null
                  ? ''
                  : currentRecipe.prepTime.toString(),
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 18),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Preptime is required';
                }

                try {
                  int.parse(value);
                } on FormatException {
                  return 'Only number';
                }

                return null;
              },
              onSaved: (String value) {
                currentRecipe.prepTime = int.parse(value);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCookTimeField() {
    return Row(
      children: [
        SizedBox(
          width: 16,
        ),
        Expanded(
            flex: 1,
            child: Text(
              "Cook time",
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5,
                  height: 1.5),
            )),
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.all(12),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: '90 mins',
                fillColor: Colors.blue[100],
                suffix: Text("mins"),
                filled: true,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    const Radius.circular(15.0),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
              initialValue: currentRecipe.cookTime == null
                  ? ''
                  : currentRecipe.cookTime.toString(),
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 18),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Cooktime is required';
                }

                try {
                  int.parse(value);
                } on FormatException {
                  return 'Only number';
                }

                return null;
              },
              onSaved: (String value) {
                currentRecipe.cookTime = int.parse(value);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIngredientField() {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(icon: Icon(Icons.menu), onPressed: () {}),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.73,
            child: TextFormField(
              initialValue: currentRecipe.ingredients
                      .asMap()
                      .containsKey(_ingredientWidgets.length)
                  ? currentRecipe.ingredients[_ingredientWidgets.length]
                  : '',
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: '200ml milk',
                filled: true,
                fillColor: Colors.blue[100],
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    const Radius.circular(15.0),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(fontSize: 18),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'ingre is required';
                }
                return null;
              },
              onSaved: (String value) {
                currentRecipe.ingredients.add(value);
              },
            ),
          ),
          SizedBox(width: 5),
          PopupMenuButton(
            icon: Icon(Icons.more_horiz),
            onSelected: (String result) {
              switch (result) {
                case "delete":
                  setState(() {
                    //currentRecipe.directions.removeAt(_directionWidgets.length-1);
                  });
                  break;
                case "add":
                  setState(() {
                    //currentRecipe.directions.removeAt(_directionWidgets.length-1);
                  });
                  break;
                default:
              }
              setState(() {});
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: "add",
                child: Text('Add ingredient'),
              ),
              const PopupMenuItem<String>(
                value: "delete",
                child: Text('Delete this ingredient'),
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildDirectionField(int index) {
    File _imageStepFile;

    Future _imgStepFromCamera() async {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxWidth: 400,
      );

      if (pickedFile != null) {
        setState(() {
          _imageStepFile = File(pickedFile.path);

          while (_directionImageFiles.length <= index) {
            _directionImageFiles.add(null);
          }

          _directionImageFiles[index] = _imageStepFile;

          _directionWidgets[index] = _buildDirectionField(index);
        });
      }
    }

    Future _imgStepFromGallery() async {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 400,
      );

      if (pickedFile != null) {
        setState(() {
          _imageStepFile = File(pickedFile.path);

          while (_directionImageFiles.length <= index) {
            _directionImageFiles.add(null);
          }

          _directionImageFiles[index] = _imageStepFile;

          _directionWidgets[index] = _buildDirectionField(index);
        });
      }
    }

    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 26,
                height: 26,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.blue[600]),
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {},
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.73,
                child: TextFormField(
                  minLines: 2,
                  maxLines: 3,
                  keyboardType: TextInputType.text,
                  initialValue: currentRecipe.directions
                          .asMap()
                          .containsKey(_directionWidgets.length)
                      ? currentRecipe.directions[_directionWidgets.length]
                      : '',
                  decoration: InputDecoration(
                    hintText: 'Mix the flour and water until they thicken',
                    filled: true,
                    fillColor: Colors.blue[100],
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          const Radius.circular(15.0),
                        ),
                        borderSide: BorderSide.none),
                  ),
                  style: TextStyle(fontSize: 16),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Step is required';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    currentRecipe.directions.add(value);
                  },
                ),
              ),
              SizedBox(height: 5),
              widget.isUpdating
                  ? (_directionImageFiles.length <= index)
                      ? (_directionImageUrls.length <= index)
                          ? GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext bc) {
                                    return SafeArea(
                                      child: Container(
                                        child: new Wrap(
                                          children: <Widget>[
                                            new ListTile(
                                                leading: new Icon(
                                                    Icons.photo_library),
                                                title:
                                                    new Text('Photo Library'),
                                                onTap: () {
                                                  _imgStepFromGallery();
                                                  Navigator.of(context).pop();
                                                }),
                                            new ListTile(
                                              leading:
                                                  new Icon(Icons.photo_camera),
                                              title: new Text('Camera'),
                                              onTap: () {
                                                _imgStepFromCamera();
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width: 100,
                                height: 80,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(8)),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext bc) {
                                    return SafeArea(
                                      child: Container(
                                        child: new Wrap(
                                          children: <Widget>[
                                            new ListTile(
                                                leading: new Icon(
                                                    Icons.photo_library),
                                                title: new Text(
                                                    'Change image from Library'),
                                                onTap: () {
                                                  _imgStepFromGallery();
                                                  Navigator.of(context).pop();
                                                }),
                                            new ListTile(
                                              leading:
                                                  new Icon(Icons.photo_camera),
                                              title: new Text(
                                                  'Change image from Camera'),
                                              onTap: () {
                                                _imgStepFromCamera();
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            new ListTile(
                                              leading: new Icon(
                                                  Icons.delete_outline),
                                              title: new Text('Delete image'),
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                  width: 100,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8)),
                                  alignment: Alignment.center,
                                  child: Image.network(
                                      _directionImageUrls[index],
                                      fit: BoxFit.fitWidth)),
                            )
                      : GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext bc) {
                                return SafeArea(
                                  child: Container(
                                    child: new Wrap(
                                      children: <Widget>[
                                        new ListTile(
                                            leading:
                                                new Icon(Icons.photo_library),
                                            title: new Text(
                                                'Change image from Library'),
                                            onTap: () {
                                              _imgStepFromGallery();
                                              Navigator.of(context).pop();
                                            }),
                                        new ListTile(
                                          leading: new Icon(Icons.photo_camera),
                                          title: new Text(
                                              'Change image from Camera'),
                                          onTap: () {
                                            _imgStepFromCamera();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        new ListTile(
                                          leading:
                                              new Icon(Icons.delete_outline),
                                          title: new Text('Delete image'),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                              width: 100,
                              height: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              alignment: Alignment.center,
                              child: Image.file(_directionImageFiles[index],
                                  key: UniqueKey(), fit: BoxFit.fitWidth)),
                        )
                  : (_directionImageFiles.length <= index)
                      ? GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext bc) {
                                return SafeArea(
                                  child: Container(
                                    child: new Wrap(
                                      children: <Widget>[
                                        new ListTile(
                                            leading:
                                                new Icon(Icons.photo_library),
                                            title: new Text('Photo Library'),
                                            onTap: () {
                                              _imgStepFromGallery();
                                              Navigator.of(context).pop();
                                            }),
                                        new ListTile(
                                          leading: new Icon(Icons.photo_camera),
                                          title: new Text('Camera'),
                                          onTap: () {
                                            _imgStepFromCamera();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            width: 100,
                            height: 80,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8)),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext bc) {
                                return SafeArea(
                                  child: Container(
                                    child: new Wrap(
                                      children: <Widget>[
                                        new ListTile(
                                            leading:
                                                new Icon(Icons.photo_library),
                                            title: new Text(
                                                'Change image from Library'),
                                            onTap: () {
                                              _imgStepFromGallery();
                                              Navigator.of(context).pop();
                                            }),
                                        new ListTile(
                                          leading: new Icon(Icons.photo_camera),
                                          title: new Text(
                                              'Change image from Camera'),
                                          onTap: () {
                                            _imgStepFromCamera();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        new ListTile(
                                          leading:
                                              new Icon(Icons.delete_outline),
                                          title: new Text('Delete image'),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                              width: 100,
                              height: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              alignment: Alignment.center,
                              child: Image.file(_directionImageFiles[index],
                                  key: UniqueKey(), fit: BoxFit.fitWidth)),
                        ),
            ],
          ),
          SizedBox(width: 5),
          PopupMenuButton(
            icon: Icon(Icons.more_horiz),
            onSelected: (String result) {
              switch (result) {
                case "delete":
                  setState(() {
                    _directionWidgets.removeAt(index);
                  });
                  break;
                case "add":
                  setState(() {
                    _directionWidgets.add(_buildDirectionField(index + 1));
                  });
                  break;
                default:
              }
              setState(() {});
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: "add",
                child: Text('Add step'),
              ),
              const PopupMenuItem<String>(
                value: "delete",
                child: Text('Delete this step'),
              ),
            ],
          )
        ],
      ),
    );
  }

  _saveRecipe(context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    await RecipeService().uploadRecipeAndImage(
        currentRecipe, widget.isUpdating, imageFile, _directionImageFiles);

    print("name: ${currentRecipe.name}");
    print("description: ${currentRecipe.description}");
    print("category: ${currentRecipe.category}");
    print("yields: ${currentRecipe.yields}");
    print("prepTime: ${currentRecipe.prepTime}");
    print("cookTime: ${currentRecipe.cookTime}");
    print("ingredients: ${currentRecipe.ingredients}");
    print("directions: ${currentRecipe.directions}");
    print("imageFile: ${imageFile.toString()}");
    print("imageUrl: $imageUrl");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: '',
        leading: CustomBackButton(tapEvent: () {
          Navigator.pop(context);
        }),
        actions: [
          IconButton(
              icon: Icon(
                Icons.save_alt_outlined,
                color: Colors.black,
              ),
              onPressed: () async {
                await _saveRecipe(context);
                await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('All Done'),
                          content: Text('Upload recipe successfully'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('OK'))
                          ],
                        ));
                Navigator.pop(context);
              })
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              RecipeImage(parent: this),
              SizedBox(height: 16),
              NameField(parent: this),
              DesciptionField(parent: this),
              CategoryField(parent: this),
              _buildYieldsField(),
              _buildPrepTimeField(),
              _buildCookTimeField(),
              Divider(thickness: 5, color: Colors.blue[80]),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Text(
                  "Ingredients",
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                      height: 1.5),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: _ingredientWidgets.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _ingredientWidgets[index];
                  },
                ),
              ),
              TextButton(
                child: Text(
                  '+ Ingredient',
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                      height: 1.5),
                ),
                onPressed: () => setState(
                    () => _ingredientWidgets.add(_buildIngredientField())),
              ),
              Divider(thickness: 5, color: Colors.blue[80]),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Text(
                  "Method",
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                      height: 1.5),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: _directionWidgets.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _directionWidgets[index];
                  },
                ),
              ),
              TextButton(
                child: Text(
                  '+ Step',
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                      height: 1.5),
                ),
                onPressed: () => setState(() => _directionWidgets
                    .add(_buildDirectionField(_directionWidgets.length))),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
