import 'package:cooking_master/widgets/show_alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController cfPassword = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    if (isLoading)
      return Scaffold(
          backgroundColor: Colors.black.withOpacity(0.9),
          body: Container(
            child: CircularProgressIndicator(),
            padding: EdgeInsets.all(100),
          ));
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      body: Stack(
        children: [
          Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: oldPassword,
                    obscureText: true,
                    autofocus: true,
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    decoration: InputDecoration(
                      hintText: "Old Password",
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: newPassword,
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    decoration: InputDecoration(
                      hintText: "New Password",
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: cfPassword,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (String value) {
                      //  Navigator.pop(context, value);
                      _submit();
                    },
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              )),
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _submit() async {
    setState(() {
      isLoading = true;
    });
    if (newPassword.text.length < 6) {
      await showAlertDialog(
        context,
        title: 'Error',
        content: 'Password must contain more than six characters',
        defaultActionText: 'OK',
      );
      setState(() {
        isLoading = false;
      });
    } else {
      if (cfPassword.text != newPassword.text) {
        await showAlertDialog(
          context,
          title: 'Error',
          content: 'Confirm Again',
          defaultActionText: 'OK',
        );
        setState(() {
          isLoading = false;
        });
      } else {
        String error = "ok";
        AuthCredential credential = EmailAuthProvider.credential(
            email: FirebaseAuth.instance.currentUser.email,
            password: oldPassword.text);
        FirebaseAuth.instance.currentUser
            .reauthenticateWithCredential(credential)
            .then((value) {
          FirebaseAuth.instance.currentUser
              .updatePassword(newPassword.text)
              .then((value) async {
            await showAlertDialog(
              context,
              title: 'Success',
              content: 'Changed Success',
              defaultActionText: 'OK',
            );
            Navigator.pop(context);
          }).catchError((onE) async {
            await showAlertDialog(
              context,
              title: 'Error',
              content: onE.toString(),
              defaultActionText: 'OK',
            );
            setState(() {
              isLoading = false;
            });
          });
        }).catchError((onError) async {
          await showAlertDialog(
            context,
            title: 'Error',
            content: onError.toString(),
            defaultActionText: 'OK',
          );
          setState(() {
            isLoading = false;
          });
        });
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
