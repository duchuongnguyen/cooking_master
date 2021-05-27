import 'package:cooking_master/constants/color_constant.dart';
import 'package:flutter/material.dart';

class PreparationHeader extends StatelessWidget {
  const PreparationHeader({
    Key key,
    @required this.currentIndex,
    @required this.totalPages,
  }) : super(key: key);

  final int currentIndex;
  final int totalPages;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(15))),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              (currentIndex + 1).toString() + " of " + totalPages.toString(),
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: Text(
                "Ingredients",
                style: TextStyle(
                    fontSize: 16, color: blue5, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ));
  }
}
