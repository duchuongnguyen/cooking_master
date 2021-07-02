import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/constants/padding_constant.dart';
import 'package:cooking_master/notifier/user_saved_recipe.dart';
import 'package:cooking_master/screens/SavedRecipe/RecipeCategoryScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({Key key, this.text, this.action})
      : super(key: key);

  final String text;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action != null
          ? () {
              Provider.of<SavedRecipeProvider>(context, listen: false)
                  .SetCurCategory(text);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecipeCategoryScreen(name: text)));
            }
          : () {},
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
            margin: EdgeInsets.only(left: defaultPadding),
            height: 24,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: defaultPadding / 4),
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.only(right: defaultPadding / 4),
                    height: 7,
                    color: blue2.withOpacity(0.2),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
