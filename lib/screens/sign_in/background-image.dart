import 'package:flutter/material.dart';

class LoginBackgroundImage extends StatelessWidget {
  const LoginBackgroundImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
              colors: [Colors.black, Colors.black12],
              begin: Alignment.bottomCenter,
              end: Alignment.center)
          .createShader(bounds),
      blendMode: BlendMode.darken,
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/login-1.jpg"),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.black45, BlendMode.darken))),
      ),
    );
  }
}
