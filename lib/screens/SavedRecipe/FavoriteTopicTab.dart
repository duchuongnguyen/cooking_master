import 'package:cooking_master/notifier/mytopics_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final mytopics = Provider.of<MyTopicsNotifier>(context, listen: false);
    _dynamicTopics = mytopics.MyTopics;
  }

  @override
  Widget build(BuildContext context) {
    final mytopics = Provider.of<MyTopicsNotifier>(context, listen: false);
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
                mytopics.deleteTopic(_dynamicTopics[index]);
                //_dynamicTopics.removeAt(index);
              });
            },
          );
        }),
      ),
    );
  }
}
