import 'package:cooking_master/screens/sign_in/validators.dart';
import 'package:cooking_master/services/auth_service.dart';
import 'package:cooking_master/services/userprofile_service.dart';
import 'package:cooking_master/widgets/form_submit_button.dart';
import 'package:cooking_master/widgets/show_alert_dialog.dart';
import 'package:cooking_master/widgets/show_exception_alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum EmailSignInType { SignIn, SignUp }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {
  EmailSignInForm({
    Key key,
  });
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  EmailSignInType _formType = EmailSignInType.SignIn;
  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  String get _confirmPassword => _confirmPasswordController.text;
  bool submitted = false;
  bool isLoading = false;
  List<Widget> buildChildren() {
    final buttonSubmitText =
        _formType == EmailSignInType.SignIn ? 'Sign in' : 'Sign up';
    final changeText = _formType == EmailSignInType.SignIn
        ? 'Need an account? '
        : 'Have an account? ';
    final changeTextButton =
        _formType == EmailSignInType.SignIn ? 'Sign up' : 'Sign in';
    submitted = widget.emailValidator.isValid(_email) &&
        widget.emailValidator.isValid(_password);
    if (isLoading)
      return [
        Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        )
      ];
    return [
      Container(
          decoration: BoxDecoration(
              color: Colors.grey[500].withOpacity(0.5),
              borderRadius: BorderRadius.circular(16)),
          child: EmailField()),
      SizedBox(height: 12.0),
      Container(
          decoration: BoxDecoration(
              color: Colors.grey[500].withOpacity(0.5),
              borderRadius: BorderRadius.circular(16)),
          child: _passField()),
      Visibility(
          visible: _formType == EmailSignInType.SignIn ? false : true,
          child: Column(
            children: [
              SizedBox(height: 12.0),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[500].withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16)),
                child: TextFormField(
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  focusNode: _confirmPasswordFocusNode,
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white54, fontSize: 20),
                    border: InputBorder.none,
                    prefixIcon:
                        Icon(Icons.check_circle_outline, color: Colors.white),
                    labelText: ' Confirm Password',
                    errorText: !checkConfirmPassWord() && submitted
                        ? widget.invalidConfirmPasswordErrorText
                        : null,
                  ),
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: isLoading ? null : _submit,
                ),
              ),
            ],
          )),
      SizedBox(height: 12.0),
      FormSubmitButton(
          text: buttonSubmitText, onPressed: isLoading ? null : _submit),
      SizedBox(
        height: 16.0,
      ),
      // ignore: deprecated_member_use
      Center(
        child: RichText(
            text: TextSpan(
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                children: [
              TextSpan(
                  text: changeText,
                  //Tap to navigate to see another user proflie
                  //recognizer: new TapGestureRecognizer()..onTap = () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfileWatchScreen(/*user*/))),
                  style: TextStyle(
                    color: Colors.white,
                  )),
              TextSpan(
                  recognizer: new TapGestureRecognizer()
                    ..onTap = (!isLoading ? toggleFormType : () {}),
                  text: changeTextButton,
                  style: TextStyle(color: Colors.blue)),
            ])),
      ),
    ];
  }

  TextFormField _passField() {
    bool passWordValid =
        submitted && !widget.passwordValidator.isValid(_password);
    return TextFormField(
      style: TextStyle(color: Colors.white, fontSize: 18),
      focusNode: _passwordFocusNode,
      controller: _passwordController,
      decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.white54, fontSize: 20),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.lock_outline, color: Colors.white),
          labelText: 'Password',
          errorText: passWordValid ? widget.invalidPasswordErrorText : null,
          enabled: isLoading == false),
      obscureText: true,
      onEditingComplete:
          _formType == EmailSignInType.SignIn ? _submit : passwordEditComplete,
      textInputAction: _formType == EmailSignInType.SignIn
          ? TextInputAction.done
          : TextInputAction.next,
    );
  }

  // ignore: non_constant_identifier_names
  TextFormField EmailField() {
    bool emailValid = submitted && !widget.emailValidator.isValid(_email);
    return TextFormField(
      focusNode: _emailFocusNode,
      style: TextStyle(color: Colors.white, fontSize: 20),
      controller: _emailController,
      decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.white54, fontSize: 20),
          hintStyle: TextStyle(color: Colors.white54, fontSize: 20),
          border: InputBorder.none,
          labelText: 'Email',
          prefixIcon: Icon(Icons.email_outlined, color: Colors.white),
          hintText: 'example@gmail.com',
          errorText: emailValid ? widget.invalidEmailErrorText : null,
          enabled: isLoading == false),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: emailEditComplete,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is required';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: buildChildren(),
      ),
    );
  }

  updateState() {
    setState(() {});
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      submitted = true;
      isLoading = true;
    });
    try {
      await Future.delayed(Duration(seconds: 3));
      final auth = Provider.of<AuthBase>(context, listen: false);
      if (_formType == EmailSignInType.SignIn) {
        var result = await auth.signInWithEmailAndPassword(_email, _password);
        if (result != "OK") {
          await showAlertDialog(
            context,
            title: 'Sign in failed',
            content: result,
            defaultActionText: 'OK',
          );
        } else {
          Navigator.of(context).pop();
        }
      } else {
        if (checkConfirmPassWord()) {
          final userProfile =
              Provider.of<UserProfileService>(context, listen: false);
          var result =
              await auth.createUserWithEmailAndPassword(_email, _password);
          if (result != "OK") {
            await showAlertDialog(
              context,
              title: 'Sign up failed',
              content: result,
              defaultActionText: 'OK',
            );
          } else {
            await userProfile.addUser(FirebaseAuth.instance.currentUser.uid);
            Navigator.of(context).pop();
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Sign in failed',
        exception: e,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void toggleFormType() {
    setState(() {
      submitted = false;
      _formType = _formType == EmailSignInType.SignIn
          ? EmailSignInType.SignUp
          : EmailSignInType.SignIn;
      _emailController.clear();
      _passwordController.clear();
      FocusScope.of(context).requestFocus(_emailFocusNode);
    });
  }

  emailEditComplete() {
    final newFocus = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  passwordEditComplete() {
    final newFocus = widget.emailValidator.isValid(_password)
        ? _confirmPasswordFocusNode
        : _passwordFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  bool checkConfirmPassWord() {
    if (_password == _confirmPassword && _confirmPassword != "")
      return true;
    else
      return false;
  }
}
