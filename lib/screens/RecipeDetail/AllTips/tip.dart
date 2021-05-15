import 'package:cooking_master/models/tip_model.dart';
import 'package:cooking_master/screens/RecipeDetail/AllTips/tip_like.dart';
import 'package:flutter/material.dart';

class Tip extends StatelessWidget {
  final TipModel tip;

  const Tip({
    Key key,
    @required this.tip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 15, right: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: CircleAvatar(
              backgroundImage: AssetImage(
                tip.tipUserImage,
              ),
            ),
          ),
          Expanded(
              flex: 8,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tip.tipUserName,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 5),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          tip.tipImage,
                          fit: BoxFit.fitWidth,
                        )),
                    SizedBox(height: 5),
                    Text(
                      tip.tipDescription,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 18),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tip.tipTime,
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        ),
                        TipLike(tip: tip),
                      ],
                    )
                  ]))
        ],
      ),
    );
  }
}
