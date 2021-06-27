import 'dart:io';

import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/services/recipe_service.dart';
import 'package:cooking_master/widgets/CustomBackButton.dart';
import 'package:cooking_master/widgets/appbar.dart';
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

  _RecipeFormScreenState createState() => _RecipeFormScreenState();
}

class _RecipeFormScreenState extends State<RecipeFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RecipeModel _currentRecipe;
  String _imageUrl;
  File _imageFile;
  var _ingredientWidgets = <Widget>[];
  var _directionWidgets = <Widget>[];
  var _directionImageUrls = <String>[];
  var _directionImageFiles = <File>[];

  @override
  void initState() {
    super.initState();

    if (widget.currentRecipe != null) {
      _currentRecipe = widget.currentRecipe;
    } else {
      _currentRecipe = RecipeModel();
    }

    _directionImageUrls = _currentRecipe.directionImage;
    _imageUrl = _currentRecipe.image;

    Future.delayed(Duration.zero, () {
      _currentRecipe.ingredients.forEach((element) {
        _ingredientWidgets.add(_buildIngredientField());
      });

      _currentRecipe.directions.forEach((element) {
        _directionWidgets.add(_buildDirectionField());
      });

      setState(() {});
    });
  }

  _showImage() {
    if (_imageFile == null && _imageUrl == null) {
      return GestureDetector(
        onTap: () {
          _showPicker(context);
        },
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
                child: _imageFile == null && _imageUrl == null
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt_outlined),
                            SizedBox(width: 5),
                            Text("Upload recipe photo"),
                          ],
                        ),
                      )
                    : SizedBox(height: 0),
              ),
            ],
          ),
        ),
      );
    } else if (_imageFile != null) {
      print('showing image from local file');
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.file(
              _imageFile,
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
                            _imageFile = null;
                            _imageUrl = null;
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
    } else if (_imageUrl != null) {
      print('showing image from url');
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            Image.network(
              _imageUrl,
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
                            _imageFile = null;
                            _imageUrl = null;
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

  Widget _buildNameField() {
    return Container(
      margin: EdgeInsets.all(12),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Title: Macaroni Pasta',
          fillColor: Colors.blue[100],
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              const Radius.circular(15.0),
            ),
            borderSide: BorderSide.none,
          ),
        ),
        initialValue: _currentRecipe.name,
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 20),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Name is required';
          }

          return null;
        },
        onSaved: (String value) {
          _currentRecipe.name = value;
        },
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Container(
      margin: EdgeInsets.all(12),
      child: TextFormField(
        minLines: 1,
        maxLines: 3,
        decoration: InputDecoration(
          hintText:
              'Description: An easy peasy pasta dish that’s simple, flavorful and incredibly hearty. And all you need is 20 min to whip this up!',
          fillColor: Colors.blue[100],
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              const Radius.circular(15.0),
            ),
            borderSide: BorderSide.none,
          ),
        ),
        initialValue: _currentRecipe.description,
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 18),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Description is required';
          }

          return null;
        },
        onSaved: (String value) {
          _currentRecipe.description = value;
        },
      ),
    );
  }

  Widget _buildCategoryField() {
    return Row(
      children: [
        SizedBox(
          width: 16,
        ),
        Expanded(
            flex: 1,
            child: Text(
              "Category",
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
                hintText: 'Breakfast',
                fillColor: Colors.blue[100],
                filled: true,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    const Radius.circular(15.0),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
              initialValue: _currentRecipe.category,
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 18),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Category is required';
                }

                return null;
              },
              onSaved: (String value) {
                _currentRecipe.category = value;
              },
            ),
          ),
        ),
      ],
    );
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
              initialValue: _currentRecipe.yields == null
                  ? ''
                  : _currentRecipe.yields.toString(),
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
                _currentRecipe.yields = int.parse(value);
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
              initialValue: _currentRecipe.prepTime == null
                  ? ''
                  : _currentRecipe.prepTime.toString(),
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
                _currentRecipe.prepTime = int.parse(value);
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
              initialValue: _currentRecipe.cookTime == null
                  ? ''
                  : _currentRecipe.cookTime.toString(),
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
                _currentRecipe.cookTime = int.parse(value);
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
              initialValue: _currentRecipe.ingredients
                      .asMap()
                      .containsKey(_ingredientWidgets.length)
                  ? _currentRecipe.ingredients[_ingredientWidgets.length]
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
                _currentRecipe.ingredients.add(value);
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
                    //_currentRecipe.directions.removeAt(_directionWidgets.length-1);
                  });
                  break;
                case "add":
                  setState(() {
                    //_currentRecipe.directions.removeAt(_directionWidgets.length-1);
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

  _buildDirectionField() {
    File _imageStepFile;
    _imgStepFromCamera() async {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxWidth: 400,
      );

      if (pickedFile != null) {
        setState(() {
          _imageStepFile = File(pickedFile.path);
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
                  (_directionWidgets.length + 1).toString(),
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
                  initialValue: _currentRecipe.directions
                          .asMap()
                          .containsKey(_directionWidgets.length)
                      ? _currentRecipe.directions[_directionWidgets.length]
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
                    _currentRecipe.directions.add(value);
                  },
                ),
              ),
              SizedBox(height: 5),
              //image placeholder show here
              if (_imageStepFile == null)
                GestureDetector(
                  onTap: () {
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
                ),
              //Load image done below
              if (_imageStepFile != null)
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext bc) {
                        return SafeArea(
                          child: Container(
                            child: new Wrap(
                              children: <Widget>[
                                new ListTile(
                                    leading: new Icon(Icons.photo_library),
                                    title:
                                        new Text('Change image from Library'),
                                    onTap: () {
                                      _imgStepFromGallery();
                                      Navigator.of(context).pop();
                                    }),
                                new ListTile(
                                  leading: new Icon(Icons.photo_camera),
                                  title: new Text('Change image from Camera'),
                                  onTap: () {
                                    _imgStepFromCamera();
                                    Navigator.of(context).pop();
                                  },
                                ),
                                new ListTile(
                                  leading: new Icon(Icons.delete_outline),
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
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      alignment: Alignment.center,
                      child: Image.network(
                          "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                          fit: BoxFit.fitWidth)),
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
                    //_currentRecipe.directions.removeAt(_directionWidgets.length-1);
                  });
                  break;
                case "add":
                  setState(() {
                    //_currentRecipe.directions.removeAt(_directionWidgets.length-1);
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

  _saveRecipe(context) {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    RecipeService()
        .uploadRecipeAndImage(_currentRecipe, widget.isUpdating, _imageFile);

    print("name: ${_currentRecipe.name}");
    print("description: ${_currentRecipe.description}");
    print("category: ${_currentRecipe.category}");
    print("yields: ${_currentRecipe.yields}");
    print("prepTime: ${_currentRecipe.prepTime}");
    print("cookTime: ${_currentRecipe.cookTime}");
    print("ingredients: ${_currentRecipe.ingredients}");
    print("directions: ${_currentRecipe.directions}");
    print("imageFile: ${_imageFile.toString()}");
    print("imageUrl: $_imageUrl");
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
              onPressed: () {
                _saveRecipe(context);
              })
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              _showImage(),
              SizedBox(height: 16),
              _buildNameField(),
              _buildDescriptionField(),
              _buildCategoryField(),
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
                onPressed: () => setState(
                    () => _directionWidgets.add(_buildDirectionField())),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
