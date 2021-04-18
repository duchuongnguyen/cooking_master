import 'dart:io';

import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/notifier/recipe_notifier.dart';
import 'package:cooking_master/services/recipe_service.dart';
import 'package:cooking_master/widgets/CustomBackButton.dart';
import 'package:cooking_master/widgets/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RecipeFormScreen extends StatefulWidget {
  final bool isUpdating;

  RecipeFormScreen({
    Key key,
    @required this.isUpdating,
  }) : super(key: key);

  _RecipeFormScreenState createState() => _RecipeFormScreenState();
}

class _RecipeFormScreenState extends State<RecipeFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Recipe _currentRecipe;
  String _imageUrl;
  File _imageFile;
  var ingredientWidgets = <Widget>[];
  var directionWidgets = <Widget>[];

  @override
  void initState() {
    super.initState();
    RecipeNotifier recipeNotifier =
        Provider.of<RecipeNotifier>(context, listen: false);

    if (recipeNotifier.currentRecipe != null) {
      _currentRecipe = recipeNotifier.currentRecipe;
    } else {
      _currentRecipe = Recipe();
    }

    // _ingredients.addAll(_currentRecipe.ingredients);
    // _directions.addAll(_currentRecipe.directions);
    _imageUrl = _currentRecipe.image;
  }

  _showImage() {
    if (_imageFile == null && _imageUrl == null) {
      return GestureDetector(
        onTap: () {
          _getLocalImage();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Image.asset('assets/images/food-placeholder.png'),
              Positioned.fill(
                bottom: 15,
                child: _imageFile == null && _imageUrl == null
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt_outlined),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Upload recipe photo")
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
      return Stack(
        children: <Widget>[
          Image.file(
            _imageFile,
            fit: BoxFit.cover,
            height: 250,
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
                    onTap: () => _getLocalImage(),
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
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
                  Icon(Icons.delete_outlined, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      );
    } else if (_imageUrl != null) {
      print('showing image from url');
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.network(
            _imageUrl,
            fit: BoxFit.cover,
            height: 250,
          ),
          TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black38)),
            onPressed: () => _getLocalImage(),
            child: Text(
              'Change Image',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      );
    }
  }

  Future _getLocalImage() async {
    // ignore: invalid_use_of_visible_for_testing_member
    final pickedFile = await ImagePicker.platform.pickImage(
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
          hintText: 'Tiêu đề: Món trứng cút lộn xào me',
          fillColor: Colors.orange[50],
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
        decoration: InputDecoration(
          hintText:
              'Mô tả: An easy peasy pasta dish that’s simple, flavorful and incredibly hearty. And all you need is 20 min to whip this up!',
          fillColor: Colors.orange[50],
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
        style: TextStyle(fontSize: 15),
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
    return Container(
      margin: EdgeInsets.all(12),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Loại công thức: Điểm tâm,...',
          fillColor: Colors.orange[50],
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
        style: TextStyle(fontSize: 15),
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
    );
  }

  Widget _buildYieldsField() {
    return Container(
      margin: EdgeInsets.all(12),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Khẩu phần: 3',
          fillColor: Colors.orange[50],
          filled: true,
          suffix: Text('người'),
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
        style: TextStyle(fontSize: 15),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Yields is required';
          }

          try {
            int.parse(value);
          } on FormatException {
            return 'Nhập số thui nha';
          }

          return null;
        },
        onSaved: (String value) {
          _currentRecipe.yields = int.parse(value);
        },
      ),
    );
  }

  Widget _buildPrepTimeField() {
    return Container(
      margin: EdgeInsets.all(12),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Thời gian chuẩn bị: 3',
          fillColor: Colors.orange[50],
          filled: true,
          suffix: Text('mins'),
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
        style: TextStyle(fontSize: 15),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Preptime is required';
          }

          try {
            int.parse(value);
          } on FormatException {
            return 'Nhập số thui nha';
          }

          return null;
        },
        onSaved: (String value) {
          _currentRecipe.prepTime = int.parse(value);
        },
      ),
    );
  }

  Widget _buildCookTimeField() {
    return Container(
      margin: EdgeInsets.all(12),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Thời gian nấu: 3',
          fillColor: Colors.orange[50],
          filled: true,
          suffix: Text('mins'),
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
        style: TextStyle(fontSize: 15),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Cooktime is required';
          }

          try {
            int.parse(value);
          } on FormatException {
            return 'Nhập số thui nha';
          }

          return null;
        },
        onSaved: (String value) {
          _currentRecipe.cookTime = int.parse(value);
        },
      ),
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
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: '200g sữa chua',
                filled: true,
                fillColor: Colors.orange[50],
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    const Radius.circular(15.0),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(fontSize: 15),
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
          SizedBox(width: 20),
          //IconButton(icon: Icon(Icons.more_horiz_sharp), onPressed: () {})
        ],
      ),
    );
  }

  _buildDirectionField() {
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
                      color: Colors.black),
                  child: Text(
                    (directionWidgets.length + 1).toString(),
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  )),
              IconButton(icon: Icon(Icons.menu), onPressed: () {}),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Xắt lát hành phi cho vừa ăn',
                    filled: true,
                    fillColor: Colors.orange[50],
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          const Radius.circular(15.0),
                        ),
                        borderSide: BorderSide.none),
                    // focusedBorder: InputBorder.none,
                    // enabledBorder: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 15),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Direct is required';
                    }

                    return null;
                  },
                  onSaved: (String value) {
                    _currentRecipe.directions.add(value);
                  },
                ),
              ),
              Row(
                children: [
                  // step.description == ""
                  //     ? SizedBox(
                  //         width: 0,
                  //         height: 0,
                  //       )
                  //     : Container(
                  //         width: 100,
                  //         height: 80,
                  //         //Todo: Update method image after load here
                  //         decoration: BoxDecoration(),
                  //         alignment: Alignment.center,
                  //         child: Icon(
                  //           Icons.camera_alt_outlined,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  GestureDetector(
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
                ],
              ),
            ],
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }

  _saveRecipe(context) {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();
    // _currentRecipe.ingredients = _ingredients;
    // _currentRecipe.directionImage = _directions;

    uploadRecipeAndImage(_currentRecipe, widget.isUpdating, _imageFile);

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
    // void dismissIngredientItem(
    //     BuildContext context, int index, DismissDirection direction) {
    //   setState(() {
    //     _ingredients.removeAt(index);
    //   });
    // }

    // void dismissMethodStep(
    //     BuildContext context, int index, DismissDirection direction) {
    //   setState(() {
    //     _methods.removeAt(index);
    //   });
    // }

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
              Divider(thickness: 5, color: Colors.orange[80]),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Text(
                  "Nguyên liệu",
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
                child: Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: ingredientWidgets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ingredientWidgets[index];
                    },
                  ),
                ),
              ),
              TextButton(
                child: Text(
                  '+ Thêm nguyên liệu',
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                      height: 1.5),
                ),
                onPressed: () => setState(
                    () => ingredientWidgets.add(_buildIngredientField())),
              ),
              Divider(thickness: 5, color: Colors.orange[80]),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Text(
                  "Cách làm",
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
                child: Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: directionWidgets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return directionWidgets[index];
                      // final step = _methods[index];
                      // return DismissibleWidget(
                      //   item: step,
                      //   child: _buildMethodField(step),
                      //   onDismissed: (direction) =>
                      //       dismissMethodStep(context, index, direction),
                      // );
                    },
                  ),
                ),
              ),
              TextButton(
                child: Text(
                  '+ Thêm bước',
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                      height: 1.5),
                ),
                onPressed: () => setState(
                    () => directionWidgets.add(_buildDirectionField())),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
