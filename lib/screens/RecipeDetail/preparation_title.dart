import 'package:flutter/material.dart';

class PreparationTitle extends StatelessWidget {
  const PreparationTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10),
      sliver: SliverList(
          delegate: SliverChildListDelegate(<Widget>[
        Text("Preparation",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ])),
    );
  }
}
