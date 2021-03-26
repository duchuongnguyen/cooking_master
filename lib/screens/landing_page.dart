import 'package:cooking_master/screens/sign_in/sign_in_page.dart';
import 'package:cooking_master/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';

class LandingPage extends StatefulWidget {
  //const LandingPage({Key key, @required this.auth}) : super(key: key);
  const LandingPage({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;
  @override
  _LandingPageState createState() => _LandingPageState();
}
 class _LandingPageState extends State<LandingPage>
  {
    User _user;
    @override
    void initState()
    {
      super.initState();
      _updateUser(widget.auth.currentUser);
    }
    @override
    void _updateUser(User user)
    {
      setState(() {
        _user = user;
      });
    }
    @override
  Widget build(BuildContext context) {
  // TODO: implement build
    if(_user == null)
      {
        return SignInPage
          (
          auth: widget.auth,
          onSignIn: _updateUser,
        );
      }
    print(_user.uid);
  return HomeScreen( auth: widget.auth,onSignOut: () =>_updateUser(null) );
  }
  }
  //@override
  // Widget build(BuildContext context) {
  //   final auth = Provider.of<AuthBase>(context, listen: false);
  //   return StreamBuilder<User>(
  //     stream: auth.authStateChanges(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.active) {
  //         final User user = snapshot.data;
  //         if (user == null) {
  //           return SignInPage( auth: this.auth,);
  //         }
  //         return HomeScreen();
  //
  //       }
  //       return Scaffold(
  //         body: Center(
  //           child: CircularProgressIndicator(),
  //         ),
  //       );
  //     },
  //   );
  // }

