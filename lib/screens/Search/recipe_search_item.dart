import 'package:flutter/material.dart';

class RecipeSearchItem extends StatelessWidget {
  final String image;
  final String name;
  final bool isSelected;
  const RecipeSearchItem({
    Key key,
    @required this.image,
    @required this.name,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.43,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/loading.gif',
              image: image,
            ),
          ),
          isSelected
              ? Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Icon(Icons.check_circle, color: Colors.blue, size: 30),
                  ),
                )
              : Container()
        ]),
        SizedBox(height: 5),
        Text(
          name,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        )
      ]),
    );
  }
}
