import 'package:flutter/material.dart';

class FavoriteTopic extends StatefulWidget {
  @override
  _FavoriteTopicState createState() => _FavoriteTopicState();
}

class _FavoriteTopicState extends State<FavoriteTopic> {
  GlobalKey<ScaffoldState> _key;
  List<String> _dynamicTopics;

  @override
  void initState() {
    super.initState();
    _key = GlobalKey<ScaffoldState>();
    _dynamicTopics = [
      'Breakfirst',
      'Lunch',
      'StreetFood',
      'Meow',
      'Sushi',
      'Vietnam'
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        children: List<Widget>.generate(_dynamicTopics.length, (int index) {
          //List of Favorite Topics
          return Chip(
            label: Text(_dynamicTopics[index]),
            onDeleted: () {
              setState(() {
                _dynamicTopics.removeAt(index);
              });
            },
          );
        }),
      ),
    );
  }
}
