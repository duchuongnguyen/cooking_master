import 'package:cooking_master/constants/color_constant.dart';
import 'package:flutter/material.dart';

class DetailPreparationStep extends StatelessWidget {
  final String direction;

  const DetailPreparationStep({
    Key key,
    @required this.direction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Image.asset("assets/images/recipe1.jpg", fit: BoxFit.fitWidth),
        Container(
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(
                direction,
                style: TextStyle(fontSize: 20, color: blue5),
              ),
            ))
      ]),
    );
  }
}
