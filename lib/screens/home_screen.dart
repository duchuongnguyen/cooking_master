import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/notifier/mytopics_notifier.dart';
import 'package:cooking_master/notifier/recipes_notifier.dart';
import 'package:cooking_master/notifier/user_saved_recipe.dart';
import 'package:cooking_master/screens/Home/body.dart';
import 'package:cooking_master/screens/recipe_form_screen.dart';
import 'package:cooking_master/screens/saved_recipe_screen.dart';
import 'package:cooking_master/screens/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  bool isLoading = true;
  List<IconData> icons = [
    FontAwesomeIcons.search,
  ];
  fecthdata() async {
    final savedRecipe =
        Provider.of<SavedRecipeProvider>(context, listen: false);
    final recipe = Provider.of<RecipeNotifier>(context, listen: false);
    final mytopic = Provider.of<MyTopicsNotifier>(context, listen: false);
    await mytopic.loadMyTopics(FirebaseAuth.instance.currentUser.uid);
    await savedRecipe.loadMapRecipe();
    await recipe.loadListRecipes();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fecthdata();
  }

  Widget switchScreen(int index) {
    switch (index) {
      case 0:
        return Body();
      case 3:
        return SavedRecipeScreen();
      case 1:
        return SearchScreen();
      default:
        return Body();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading)
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    else
      return Scaffold(
        appBar: _currentTab != 0
            ? null
            : AppBar(
                elevation: 0,
                toolbarHeight: 30,
                backgroundColor: blue2,
              ),
        body: switchScreen(_currentTab),
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return RecipeFormScreen(isUpdating: false);
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
                      Icons.home,
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
                      Icons.search,
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
      );
  }
}
