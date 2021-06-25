import 'package:cooking_master/notifier/mytopics_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_select/smart_select.dart';

class FavoriteTopic extends StatefulWidget {
  @override
  _FavoriteTopicState createState() => _FavoriteTopicState();
}

class _FavoriteTopicState extends State<FavoriteTopic> {
  GlobalKey<ScaffoldState> _key;
  List<String> _dynamicTopics;
  List<String> _topics = ["1", "4", "5"];
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
    return Column(
      children: [
        SmartSelect<String>.multiple(
            title: 'Manage topic',
            placeholder: 'Choose one',
            value: _topics,
            onChange: (selected) {
              setState(() => _topics = selected.value);
            },
            choiceItems: S2Choice.listFrom<String, Map>(
              source: topics,
              value: (index, item) => item['id'],
              title: (index, item) => item['name'],
              meta: (index, item) => item,
            ),
            choiceType: S2ChoiceType.chips,
            choiceStyle: S2ChoiceStyle(
              color: Theme.of(context).primaryColor,
            ),
            modalFilter: true,
            modalType: S2ModalType.fullPage,
            tileBuilder: (context, state) {
              return S2Tile.fromState(
                state,
                hideValue: true,
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://png.pngtree.com/png-clipart/20190904/original/pngtree-flattened-five-pointed-star-png-download-png-image_4462510.jpg',
                  ),
                ),
                body: S2TileChips(
                  chipColor: Theme.of(context).primaryColor,
                  chipLength: state.value.length,
                  chipLabelBuilder: (context, i) {
                    return Text(state.valueTitle[i]);
                  },
                  chipOnDelete: (i) {
                    setState(() {
                      _topics.removeAt(i); //can make error when order of 2 lists different
                    });
                  },
                ),
              );
            }),
        // const Divider(indent: 20),
        // Container(
        //   padding: EdgeInsets.all(15),
        //   child: Wrap(
        //     spacing: 10.0,
        //     runSpacing: 10.0,
        //     children: List<Widget>.generate(_dynamicTopics.length, (int index) {
        //       //List of Favorite Topics
        //       return Chip(
        //         label: Text(_dynamicTopics[index]),
        //         onDeleted: () {
        //           setState(() {
        //             mytopics.deleteTopic(_dynamicTopics[index]);
        //             //_dynamicTopics.removeAt(index);
        //           });
        //         },
        //       );
        //     }),
        //   ),
        // ),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  final Widget label;
  final VoidCallback onTap;

  ActionButton({
    Key key,
    this.label,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: label,
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: onTap,
    );
  }
}

List<Map<String, dynamic>> topics = [
  {
    'id': '1',
    'name': 'Bread',
  },
  {
    'id': '2',
    'name': 'Soup',
  },
  {
    'id': '3',
    'name': 'Cake',
  },
  {
    'id': '4',
    'name': 'Rice',
  },
  {
    'id': '5',
    'name': 'Pasta',
  },
  {
    'id': '6',
    'name': 'Beef',
  },
  {
    'id': '7',
    'name': 'Sauce',
  },
  {
    'id': '8',
    'name': 'Chicken',
  },
  {
    'id': '9',
    'name': 'Fish',
  },
];