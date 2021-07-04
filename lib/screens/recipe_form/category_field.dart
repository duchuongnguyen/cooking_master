import 'package:cooking_master/screens/recipe_form/recipe_form_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryField extends StatelessWidget {
  final RecipeFormScreenState parent;

  const CategoryField({Key key, this.parent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              initialValue: parent.currentRecipe.category,
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 18),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Category is required';
                }

                return null;
              },
              onSaved: (String value) {
                parent.currentRecipe.category = value;
              },
            ),
          ),
        ),
      ],
    );
  }
}
