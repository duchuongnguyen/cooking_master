import 'package:cooking_master/constants/color_constant.dart';
import 'package:flutter/material.dart';

class DetailPreparationStep extends StatelessWidget {
  final String image;
  final String direction;

  const DetailPreparationStep({
    Key key,
    @required this.image,
    @required this.direction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(image);
    return Container(
      child: SingleChildScrollView(
        child: Column(children: [
          image != null ? Image.network(image) : Container(),
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
      ),
    );
  }
}
