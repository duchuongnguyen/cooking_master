import 'dart:io';

import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/notifier/recipe_notifier.dart';
import 'package:cooking_master/services/recipe.dart';
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

  _showImage() {
    if (_imageFile == null && _imageUrl == null) {
      return Text('Image placeholder');
    } else if (_imageFile != null) {
      print('showing image from local file');
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.file(
            File(_imageFile.path),
            fit: BoxFit.cover,
            height: 250,
          ),
          TextButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black38)),
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
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black38)),
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
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
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
    );
  }

  Widget _buildCategoryField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Category'),
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
      appBar: AppBar(
        title: Text('Add Recipe'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _showImage(),
              SizedBox(height: 16),
              Text(
                widget.isUpdating ? 'Edit recipe' : 'Create recipe',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30),
              ),
              _imageFile == null && _imageUrl == null
                  ? ButtonTheme(
                      child: ElevatedButton(
                        onPressed: () => _getLocalImage(),
                        child: Text(
                          'Add image',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : SizedBox(height: 0),
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
                    child: ElevatedButton(
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
