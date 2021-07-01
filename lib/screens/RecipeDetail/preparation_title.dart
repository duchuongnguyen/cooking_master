import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/screens/RecipeDetail/preparation_screen.dart';
import 'package:flutter/material.dart';

class PreparationTitle extends StatelessWidget {
  final RecipeModel recipe;

  const PreparationTitle({Key key, this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10),
      sliver: SliverList(
          delegate: SliverChildListDelegate(<Widget>[
        Text("Preparation",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        SizedBox(
          height: 10,
        ),
        Material(
          color: Colors.blue[600],
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            splashColor: blue4,
            highlightColor: blue4,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PreparationScreen(startIndex: 0, recipe: recipe)));
            },
            child: Container(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Step-by-step mode ▶",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
          ),
        ),
      ])),
    );
  }
}
