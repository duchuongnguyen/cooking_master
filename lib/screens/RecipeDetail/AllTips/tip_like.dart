import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/models/tip_model.dart';
import 'package:cooking_master/services/recipe_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class TipLike extends StatelessWidget {
  final RecipeModel recipe;
  final TipModel tip;

  const TipLike({
    Key key,
    @required this.recipe,
    @required this.tip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userUid = FirebaseAuth.instance.currentUser.uid;

    return LikeButton(
      isLiked: tip.uidLiked.contains(_userUid),
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
        var color = isLiked ? blue4 : Colors.grey;
        return Text(text, style: TextStyle(color: color));
      },
    );
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    final _userUid = FirebaseAuth.instance.currentUser.uid;

    if (tip.uidLiked.contains(_userUid)) {
      tip.uidLiked.remove(_userUid);
    } else {
      tip.uidLiked.add(_userUid);
    }

    RecipeService().uploadTipAndImage(recipe.id, tip, null);

    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;
    return !isLiked;
  }
}
