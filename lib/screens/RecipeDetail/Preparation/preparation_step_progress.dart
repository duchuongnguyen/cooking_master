import 'package:cooking_master/constants/color_constant.dart';
import 'package:flutter/material.dart';

class PreparationStepProgress extends StatelessWidget {
  const PreparationStepProgress({
    Key key,
    @required this.currentIndex,
    @required this.totalPages,
  }) : super(key: key);

  final int currentIndex;
  final int totalPages;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: (currentIndex + 1).toDouble() / totalPages,
      valueColor: AlwaysStoppedAnimation(blue3),
      backgroundColor: Colors.black,
    );
  }
}