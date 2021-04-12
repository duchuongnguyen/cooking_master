import 'dart:io';

import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/notifier/recipe_notifier.dart';
import 'package:cooking_master/services/recipe.dart';
import 'package:cooking_master/widgets/CustomBackButton.dart';
import 'package:cooking_master/widgets/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  List _subIngredients = [];
  Recipe _currentRecipe;
  String _imageUrl;
  PickedFile _imageFile;
  TextEditingController subIngredientController = new TextEditingController();

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

    _subIngredients.addAll(_currentRecipe.ingredients);
    _imageUrl = _currentRecipe.image;
  }

  Widget _showImage() {
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
            File(_imageFile.path),
            fit: BoxFit.fitWidth,
            height: 250,
          ),
          Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white)),
                width: 100,
                height: 40,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => _getLocalImage(),
                      child: Container(
                        child: Row(
                          children: [
                            Icon(Icons.camera_alt_outlined,
                                color: Colors.white),
                            Text(
                              "Edit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    VerticalDivider(
                      thickness: 0.4,
                      color: Colors.white,
                    ),
                    Icon(Icons.delete_outlined, color: Colors.white),
                  ],
                ),
              )),
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
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
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
    final imageFile = await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 400,
    );

    if (imageFile != null) {
      setState(() {
        _imageFile = imageFile;
      });
    }
  }

  Widget _buildNameField() {
    return Container(
      margin: EdgeInsets.all(12),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Tiêu đề: Món trứng cút lộn xào me',
          fillColor: Colors.orangeAccent,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(15.0),
            ),
          ),
        ),
        initialValue: _currentRecipe.name,
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 20),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Name is required';
          }

          if (value.length < 3 || value.length > 20) {
            return 'Name must be more than 3 and less than 20';
          }

          return null;
        },
        onSaved: (String value) {
          _currentRecipe.name = value;
        },
      ),
    );
  }

  Widget _buildCategoryField() {
    return Container(
      margin: EdgeInsets.all(12),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Loại công thức: Điểm tâm,...',
          fillColor: Colors.orangeAccent,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
        ),
        initialValue: _currentRecipe.category,
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 20),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Category is required';
          }
          if (value.length < 3 || value.length > 20) {
            return 'Category must be more than 3 and less than 20';
          }

          return null;
        },
        onSaved: (String value) {
          _currentRecipe.category = value;
        },
      ),
    );
  }

  _buildSubIngredientField() {
    return SizedBox(
      width: 200,
      child: TextField(
        controller: subIngredientController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(labelText: 'SubIngredient'),
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  _addSubIngredient(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _subIngredients.add(text);
      });
      subIngredientController.clear();
    }
  }

  _saveRecipe(context) {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();
    _currentRecipe.ingredients = _subIngredients;

    uploadRecipeAndImage(
        _currentRecipe, widget.isUpdating, File(_imageFile.path));

    print("name: ${_currentRecipe.name}");
    print("category: ${_currentRecipe.category}");
    print("ingredients: ${_currentRecipe.ingredients.toString()}");
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _showImage(),
              SizedBox(height: 16),
              // Text(
              //   widget.isUpdating ? 'Edit recipe' :  'Create recipe',
              //   textAlign: TextAlign.center,
              //   style: TextStyle(fontSize: 30),
              // ),
              // _imageFile == null && _imageUrl == null
              //     ? ButtonTheme(
              //         child: RaisedButton(
              //           onPressed: () => _getLocalImage(),
              //           child: Text(
              //             'Add image',
              //             style: TextStyle(color: Colors.white),
              //           ),
              //         ),
              //       )
              //     : SizedBox(height: 0),
              _buildNameField(),
              _buildCategoryField(),
              // _buildYieldsField(),
              // _buildPreptimeField(),
              // _buildCooktimeField(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildSubIngredientField(),
                  ButtonTheme(
                    child: RaisedButton(
                      child: Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () =>
                          _addSubIngredient(subIngredientController.text),
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(8),
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                children: _subIngredients
                    .map(
                      (ingredient) => Card(
                        color: Colors.black54,
                        child: Center(
                          child: Text(
                            ingredient,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              // _buildDirectionsField(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _saveRecipe(context),
        child: Icon(Icons.save),
        foregroundColor: Colors.white,
      ),
    );
  }
}

class addRecipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: []),
    );
  }
}
