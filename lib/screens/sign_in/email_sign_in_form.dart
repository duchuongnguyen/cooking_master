import 'package:cooking_master/screens/sign_in/validators.dart';
import 'package:cooking_master/services/auth_service.dart';
import 'package:cooking_master/services/userprofile_service.dart';
import 'package:cooking_master/widgets/form_submit_button.dart';
import 'package:cooking_master/widgets/show_alert_dialog.dart';
import 'package:cooking_master/widgets/show_exception_alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        _formType == EmailSignInType.SignIn ? 'Sign In' : 'SignUp';
    final changeText = _formType == EmailSignInType.SignIn
        ? 'Need an account?  Sign Up'
        : 'Have an account?  Sign In';
    submitted = widget.emailValidator.isValid(_email) &&
        widget.emailValidator.isValid(_password);
    if (isLoading)
      return [
        //here is  show circularProgress when ontap button submit, but i don't known how to show it looks OK :))
        Container(
          child: CircularProgressIndicator(),
          padding: EdgeInsets.all(150),
        )
      ];
    return [
      EmailField(),
      SizedBox(height: 8.0),
      _passField(),
      Visibility(
          visible: _formType == EmailSignInType.SignIn ? false : true,
          child: Column(children: [
            SizedBox(height: 8.0),
            TextField(
              focusNode: _confirmPasswordFocusNode,
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: ' Confirm PassWord',
                errorText: !checkConfirmPassWord() && submitted
                    ? widget.invalidConfirmPasswordErrorText
                    : null,
              ),
              obscureText: true,
              textInputAction: TextInputAction.done,
              onEditingComplete: isLoading ? null : _submit,
            )
          ])),
      SizedBox(height: 8.0),
      FormSubmitButton(
          text: buttonSubmitText, onPressed: isLoading ? null : _submit),
      SizedBox(
        height: 8.0,
      ),
      // ignore: deprecated_member_use
      FlatButton(
          onPressed: !isLoading ? toggleFormType : null,
          child: Text(changeText))
    ];
  }

  TextField _passField() {
    bool passWordValid =
        submitted && !widget.passwordValidator.isValid(_password);
    return TextField(
      focusNode: _passwordFocusNode,
      controller: _passwordController,
      decoration: InputDecoration(
          labelText: 'PassWord',
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
  TextField EmailField() {
    bool emailValid = submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      focusNode: _emailFocusNode,
      controller: _emailController,
      decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'yourgmail@gmail.com',
          errorText: emailValid ? widget.invalidEmailErrorText : null,
          enabled: isLoading == false),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: emailEditComplete,
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
        String result =
            await auth.signInWithEmailAndPassword(_email, _password);
        if (result != "OK") {
          final didRequestSignOut = await showAlertDialog(
            context,
            title: 'Error',
            content: result,
            //cancelActionText: 'Cancel',
            defaultActionText: 'OK',
          );
        } else {
          Navigator.of(context).pop();
        }
      } else {
        if (checkConfirmPassWord()) {
          final userProfile =
              Provider.of<UserProfileService>(context, listen: false);
          String result =
              await auth.createUserWithEmailAndPassword(_email, _password);
          if (result == "OK") {
            await userProfile.addUser(FirebaseAuth.instance.currentUser.uid);
            Navigator.of(context).pop();
          } else {
            final didRequestSignOut = await showAlertDialog(context,
                title: 'Error',
                content: result,
                //cancelActionText: 'Cancel',
                defaultActionText: 'OK');
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
