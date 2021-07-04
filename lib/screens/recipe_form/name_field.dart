import 'package:cooking_master/screens/recipe_form/recipe_form_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NameField extends StatelessWidget {
  final RecipeFormScreenState parent;

  const NameField({Key key, this.parent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        initialValue: parent.currentRecipe.name,
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 20),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Name is required';
          }

          return null;
        },
        onSaved: (String value) {
          parent.currentRecipe.name = value;
        },
      ),
    );
  }
}
