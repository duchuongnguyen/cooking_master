import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/models/recipe_model.dart';
import 'package:flutter/material.dart';

class AddTipScreen extends StatelessWidget {
  final Recipe recipe;

  const AddTipScreen({Key key, @required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
                  child: Container(
            margin: EdgeInsets.only(top: 10, left: 12),
            child: Text(
              "Cancel",
              style: TextStyle(
                  color: blue2, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(top: 10, right: 12),
            child: Text(
              "Submit",
              style: TextStyle(
                  color: blue2, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Text(
                "Share your tip for " + recipe.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )),
        Expanded(
            flex: 12,
            child: TextFormField(
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
        Divider(
          thickness: 1,
          color: blue2,
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(
                  Icons.image,
                  color: blue2,
                ),
                SizedBox(width: 5),
                Text(
                  "Add a recipe photo",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, color: blue2),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
