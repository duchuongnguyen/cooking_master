import 'package:cooking_master/constants/color_constant.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatefulWidget {
  const CategoryItem({
    Key key,
  }) : super(key: key);

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom:
                BorderSide(width: 1.0, color: Colors.black.withOpacity(0.7)),
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.restaurant_outlined,
              size: 25.0,
            )
          ],
        ));
  }
}
