import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/screens/Home/body.dart';
import 'package:cooking_master/screens/landing_page.dart';
import 'package:cooking_master/services/auth.dart';
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
  List<IconData> icons = [
    FontAwesomeIcons.search,
  ];
  Future<void> _signOut(BuildContext context) async {
    try {
      //await manager.signInWithGoogle();
      final auth = Provider.of<AuthBase>(context, listen: false);
       await auth.signOut();
    } on Exception catch (e) {
      // _showSignInError(context, e);
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 30,
        backgroundColor: blue2,
      ),
      body: Body(size: size),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> _signOut(context),
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
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.people_alt_outlined), onPressed: () {}),
              SizedBox(),
              IconButton(
                  icon: Icon(Icons.shopping_bag_outlined), onPressed: () {}),
              IconButton(
                  icon: FaIcon(FontAwesomeIcons.heart), onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}



