import 'package:cooking_master/screens/recipe_form/recipe_form_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DesciptionField extends StatelessWidget {
  final RecipeFormScreenState parent;

  const DesciptionField({Key key, this.parent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        initialValue: parent.currentRecipe.description,
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 18),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Description is required';
          }

          return null;
        },
        onSaved: (String value) {
          parent.currentRecipe.description = value;
        },
      ),
    );
  }
}
