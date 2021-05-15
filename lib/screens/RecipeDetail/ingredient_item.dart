import 'package:cooking_master/constants/color_constant.dart';
import 'package:flutter/material.dart';

class Ingredient extends StatelessWidget {
  final name;
  final amount;
  final unit;
  final proportion;
  const Ingredient({
    Key key,
    @required this.name,
    @required this.amount,
    @required this.unit,
    @required this.proportion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)), color: blue4),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
            color: Colors.black,
          ),
        ),
        Text(
          (amount * proportion).toString() + " " + unit,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        )
      ]),
    );
  }
}