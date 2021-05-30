import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/models/tip_model.dart';
import 'package:cooking_master/models/user_model.dart';
import 'package:cooking_master/screens/RecipeDetail/add_tip_screen.dart';
import 'package:cooking_master/screens/RecipeDetail/all_tips_screen.dart';
import 'package:cooking_master/screens/recipe_detail_screen.dart';
import 'package:cooking_master/services/userprofile_service.dart';
import 'package:cooking_master/services/recipe_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeTip extends StatefulWidget {
  const RecipeTip({Key key}) : super(key: key);

  @override
  _RecipeTipState createState() => _RecipeTipState();
}

class _RecipeTipState extends State<RecipeTip> {
  @override
  Widget build(BuildContext context) {
    final recipe = RecipeDetailScreen.of(context).recipe;
    final recipeService = Provider.of<RecipeService>(context, listen: false);
    final userprofileService =
        Provider.of<UserProfileService>(context, listen: false);

    return FutureBuilder<List<TipModel>>(
      future: recipeService.getTips(recipe.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.isNotEmpty) {
            return SliverPadding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Tips',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text:
                                        '(${snapshot.data.length.toString()})'),
                              ]),
                        )),
                    FutureBuilder<UserModel>(
                        future: userprofileService
                            .loadProfile(snapshot.data[0].owner),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return MediaQuery(
                              data: MediaQueryData(padding: EdgeInsets.zero),
                              child: ListTile(
                                contentPadding:
                                    EdgeInsets.only(left: 0.0, right: 0.0),
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(snapshot.data.userImage),
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
                                  snapshot.data.userName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                    Text(snapshot.data[0].content),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllTipsScreen(
                                    recipe: recipe, listTip: snapshot.data)));
                      },
                      child: Text(
                        "See all tips and photos >",
                        style: TextStyle(
                            color: blue2,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      splashColor: blue5,
                      highlightColor: blue5,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddTipScreen()));
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
                                color: blue2,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return SliverPadding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Tips',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: '(0)'),
                              ]),
                        )),
                    Text(snapshot.data[0].content),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllTipsScreen(
                                    recipe: recipe, listTip: snapshot.data)));
                      },
                      child: Text(
                        "See all tips and photos >",
                        style: TextStyle(
                            color: blue2,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      splashColor: blue5,
                      highlightColor: blue5,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddTipScreen()));
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
                                color: blue2,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        } else {
          return SliverPadding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30));
        }
      },
    );
  }
}
