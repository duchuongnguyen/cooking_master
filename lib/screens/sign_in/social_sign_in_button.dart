import 'package:flutter/material.dart';

class SocialSignInButton extends StatelessWidget {
  final String assetName;
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;

  const SocialSignInButton(
      {Key key,
      this.assetName,
      this.text,
      this.color,
      this.textColor,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(color: color,borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset(assetName),
            Text(
              text,
              style: TextStyle(color: textColor, fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            Opacity(
              opacity: 0.0,
              child: Image.asset(assetName),
            ),
          ],
        ),
      ),
    );
  }
}
