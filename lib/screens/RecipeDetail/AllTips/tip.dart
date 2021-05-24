import 'package:cooking_master/models/tip_model.dart';
import 'package:cooking_master/screens/RecipeDetail/AllTips/tip_like.dart';
import 'package:flutter/material.dart';

class Tip1 extends StatelessWidget {
  final TipModel tip;

  const Tip1({
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
              backgroundImage: NetworkImage(tip.image),
            ),
          ),
          Expanded(
              flex: 8,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tip.owner,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 5),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          tip.image,
                          fit: BoxFit.fitWidth,
                        )),
                    SizedBox(height: 5),
                    Text(
                      tip.content,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 18),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateTime.now()
                              .difference(tip.createdAt.toDate())
                              .toString(),
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
