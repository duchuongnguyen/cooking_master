import 'package:flutter/material.dart';

class RecipeSearchItem extends StatelessWidget {
  final String image;
  final String name;
  const RecipeSearchItem({
    Key key,
    @required this.image,
    @required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.43,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: InkWell(
            onTap: () {},
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/loading.gif',
              image: image,
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(
          name,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        )
      ]),
    );
  }
}