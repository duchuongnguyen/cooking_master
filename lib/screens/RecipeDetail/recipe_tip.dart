import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/models/recipe_card_model.dart';
import 'package:cooking_master/models/tip_model.dart';
import 'package:cooking_master/screens/RecipeDetail/add_tip_screen.dart';
import 'package:cooking_master/screens/RecipeDetail/all_tips_screen.dart';
import 'package:flutter/material.dart';

class RecipeTip extends StatelessWidget {
  final RecipeCardModel recipe;
  const RecipeTip({
    Key key, @required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    tips.sort((a, b) => b.tipLikeCount.compareTo(a.tipLikeCount));
    final TipModel topTip = tips[0];
    return SliverPadding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30),
      sliver: SliverList(
          delegate: SliverChildListDelegate(<Widget>[
        Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Tips',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '(' + tips.length.toString() + ')'),
                  ]),
            )),
        MediaQuery(
          data: MediaQueryData(padding: EdgeInsets.zero),
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                topTip.tipUserImage,
              ),
            ),
            title: Text(
              'Top tip',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              topTip.tipUserName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Text(topTip.tipDescription),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AllTipsScreen(recipe: recipe,)));
          },
          child: Text(
            "See all tips and photos >",
            style: TextStyle(
                color: blue2, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        InkWell(
          splashColor: blue5,
          highlightColor: blue5,
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddTipScreen(recipe: recipe,)));
          },
          child: Container(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: blue2, width: 1),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Add a tip",
                style: TextStyle(
                    color: blue2, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
        ),
      ])),
    );
  }
}
