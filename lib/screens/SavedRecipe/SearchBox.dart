import 'package:cooking_master/constants/color_constant.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: blue1.withOpacity(0.8))),
      child: Row(children: [
        Expanded(flex: 1, child: Icon(Icons.search_outlined)),
        Expanded(
            flex: 9,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search recipes",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ))
      ]),
    );
  }
}
