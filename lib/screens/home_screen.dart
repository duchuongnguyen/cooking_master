import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/notifier/recipe_notifier.dart';
import 'package:cooking_master/screens/Home/body.dart';
import 'package:cooking_master/screens/recipe_form_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;

  List<IconData> icons = [
    FontAwesomeIcons.search,
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    RecipeNotifier recipeNotifier = Provider.of<RecipeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 30,
        backgroundColor: blue2,
      ),
      body: Body(size: size),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          recipeNotifier.currentRecipe = null;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return RecipeFormScreen(
                  isUpdating: false,
                );
              },
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.all(6.0),
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: blue4,
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0),
              ),
            ),
            padding: const EdgeInsets.all(0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.search,
                      color: _currentTab == 0
                          ? Colors.black
                          : Colors.black.withOpacity(0.3),
                    ),
                    onPressed: () {
                      setState(() {
                        _currentTab = 0;
                      });
                    }),
                IconButton(
                    icon: Icon(
                      Icons.people_alt_outlined,
                      color: _currentTab == 1
                          ? Colors.black
                          : Colors.black.withOpacity(0.3),
                    ),
                    onPressed: () {
                      setState(() {
                        _currentTab = 1;
                      });
                    }),
                SizedBox(),
                IconButton(
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                      color: _currentTab == 2
                          ? Colors.black
                          : Colors.black.withOpacity(0.3),
                    ),
                    onPressed: () {
                      setState(() {
                        _currentTab = 2;
                      });
                    }),
                IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.heart,
                      color: _currentTab == 3
                          ? Colors.black
                          : Colors.black.withOpacity(0.3),
                    ),
                    onPressed: () {
                      setState(() {
                        _currentTab = 3;
                      });
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
