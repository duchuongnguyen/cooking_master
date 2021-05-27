import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/models/preparation_model.dart';
import 'package:flutter/material.dart';

class DetailPreparationStep extends StatelessWidget {
  final PreparationModel preparationStep;
  const DetailPreparationStep({
    Key key,
    @required this.preparationStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Image.asset(preparationStep.preparationImage, fit: BoxFit.fitWidth),
        Container(
            padding: EdgeInsets.all(15),
            child: Text(
              preparationStep.preparationDetail,
              style: TextStyle(fontSize: 20, color: blue5),
            ))
      ]),
    );
  }
}