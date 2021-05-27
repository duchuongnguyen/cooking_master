import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/models/tip_model.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class TipLike extends StatelessWidget {
  final TipModel tip;

  const TipLike({
    Key key,
    @required this.tip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      onTap: onLikeButtonTapped, //Update like count
      size: 20.0,
      circleColor:
          CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
      bubblesColor: BubblesColor(
        dotPrimaryColor: Color(0xff33b5e5),
        dotSecondaryColor: Color(0xff0099cc),
      ),
      likeBuilder: (bool isLiked) {
        return Icon(
          Icons.favorite,
          color: isLiked ? blue4 : Colors.grey,
          size: 20.0,
        );
      },
      likeCount: tip.uidLiked.length,
      countBuilder: (int count, bool isLiked, String text) {
        var color = isLiked ? blue3 : Colors.grey;
        Widget result;
        if (count == 0) {
          result = Text(
            "love",
            style: TextStyle(color: color),
          );
        } else
          result = Text(
            text,
            style: TextStyle(color: color),
          );
        return result;
      },
    );
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;
    return !isLiked;
  }
}
