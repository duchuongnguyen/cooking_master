import 'package:cooking_master/screens/sign_in/validators.dart';
import 'package:cooking_master/services/auth.dart';
import 'package:cooking_master/widgets/form_submit_button.dart';
import 'package:flutter/material.dart';
 enum EmailSignInType {SignIn , SignUp}
class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators{
   EmailSignInForm({@required this.auth}) ;
  final AuthBase auth;

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  EmailSignInType _formType = EmailSignInType.SignIn;
  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  String get _confirmPassword => _confirmPasswordController.text;
  bool canSubmit = false;
  bool submitted = false;
  bool isLoading = false;
  List<Widget> builChildren()
  {
    final buttonSubmitText = _formType == EmailSignInType.SignIn ?
        'Sign In' : 'SignUp';
    final changeText = _formType == EmailSignInType.SignIn ?
        'Need an account?  Sign Up' : 'Have an account?  Sign In';
     canSubmit = widget.emailValidator.isValid(_email) &&
    widget.emailValidator.isValid(_password) ;
    return [
      EmailField(),
      SizedBox(height: 8.0),
      PassField(),
      Visibility(
        visible: _formType == EmailSignInType.SignIn ?
        false : true,
          child:
            Column(
                children: [
                  SizedBox(height: 8.0),
                  TextField(
                    focusNode: _confirmPasswordFocusNode,
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                          labelText: ' Confirm PassWord',
                          errorText:  !checkConfirmPassWord() && submitted ?  widget.invalidConfirmPasswordErrorText : null,
                      ),
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      onEditingComplete: _submit,
                      )]
                  )
      ),
      SizedBox(height: 8.0),
      FormSubmitButton(
          text: buttonSubmitText,
          onPressed: _submit
          ),
      SizedBox(height: 8.0,),
      // ignore: deprecated_member_use
      FlatButton(
          onPressed: !isLoading ? toggleFormType : null,
          child: Text(changeText)
      )
    ];
  }

  TextField PassField() {
    bool passWordValid = submitted && !widget.passwordValidator.isValid(_password);
    return TextField(
      focusNode: _passwordFocusNode,
      controller: _passwordController,
      decoration: InputDecoration(
          labelText: 'PassWord',
          errorText: passWordValid ? widget.invalidPasswordErrorText : null,
          enabled: isLoading == false
      ),
      obscureText: true,
      onEditingComplete:  _formType == EmailSignInType.SignIn ? _submit : passwordEditComplete,
      //onChanged: (_password) => updateState(),
      textInputAction: _formType == EmailSignInType.SignIn ? TextInputAction.done : TextInputAction.next,
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
        errorText:  emailValid ? widget.invalidEmailErrorText : null,
          enabled:      isLoading == false
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: emailEditComplete,
      //onChanged: (_email) => updateState(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: builChildren(),
      ),
    );
  }
  updateState() {setState(() {
  });}
  Future<void> _submit()  async {
    setState(() {
      submitted = true;
      isLoading = true;
    });
    try {
      await Future.delayed(Duration( seconds:  3));
      if (_formType == EmailSignInType.SignIn) {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
        Navigator.of(context).pop();
      }
      else {
        if(checkConfirmPassWord()) {
          await widget.auth.createUserWithEmailAndPassword(_email, _password);
          Navigator.of(context).pop();
        }
      }

    }
    catch (e)
    {
      print('some thing wrong');
    }
    finally
        {
          setState(() {
            isLoading = false;
          });
        }
  }
  void toggleFormType() {
    setState(() {
      submitted = false;
      _formType =  _formType == EmailSignInType.SignIn ?
      EmailSignInType.SignUp : EmailSignInType.SignIn;
      _emailController.clear();
      _passwordController.clear();
      FocusScope.of(context).requestFocus(_emailFocusNode);
    });
  }
  emailEditComplete() {
     final newFocus = widget.emailValidator.isValid(_email)
    ? _passwordFocusNode : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }
  passwordEditComplete() {
    final newFocus = widget.emailValidator.isValid(_password)
        ? _confirmPasswordFocusNode : _passwordFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }
  bool checkConfirmPassWord()
  {
    if(_password == _confirmPassword && _confirmPassword != "")
      return true;
    else
      return false;
  }
}
