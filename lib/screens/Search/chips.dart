import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/screens/Search/detail_search_screen.dart';
import 'package:flutter/material.dart';

class Chips extends StatelessWidget {
  final String text;
  const Chips({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetailSearchScreen(
          keyword: text,
        ),
      )),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Chip(
            backgroundColor: Colors.white,
            shadowColor: blue2,
            shape: StadiumBorder(
                side: BorderSide(width: 4.0, color: blue2.withOpacity(0.1))),
            label: Text(text,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                ))),
      ),
    );
  }
}
