import 'package:flutter/material.dart';

class FormSubmitButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const FormSubmitButton({Key key, this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          splashColor: Colors.indigo[50],
          highlightColor: Colors.indigo[300],
          onTap: onPressed,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
