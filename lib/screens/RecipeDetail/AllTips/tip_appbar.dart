import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/models/tip_model.dart';
import 'package:cooking_master/widgets/CustomBackButton.dart';
import 'package:flutter/material.dart';

AppBar buildTipAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(
      " " +
          tips.length.toString() +
          " tips", //Todo: Update tips count from database
      style: TextStyle(color: blue1, fontWeight: FontWeight.bold),
    ),
    leading: CustomBackButton(
      tapEvent: () {
        Navigator.pop(context);
      },
    ),
  );
}
