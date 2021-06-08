import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/models/ingredient_model.dart';
import 'package:cooking_master/screens/RecipeDetail/Preparation/detail_preparation_step.dart';
import 'package:cooking_master/screens/RecipeDetail/Preparation/preparation_header.dart';
import 'package:cooking_master/screens/RecipeDetail/Preparation/preparation_step_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';

class PreparationScreen extends StatefulWidget {
  final int startIndex;
  final List<String> directions;

  const PreparationScreen({
    Key key,
    @required this.startIndex,
    @required this.directions,
  }) : super(key: key);

  @override
  _PreparationScreenState createState() => _PreparationScreenState();
}

class _PreparationScreenState extends State<PreparationScreen> {
  ScrollController scrollController;

  SlidingUpPanelController panelController = SlidingUpPanelController();
  @override
  void initState() {
    _pageController = PageController(
      initialPage: widget.startIndex,
    );

    currentIndex = widget.startIndex;
    totalPages = widget.directions.length;
    super.initState();
  }

  PageController _pageController;
  int currentIndex;
  int totalPages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: Container(
          decoration: BoxDecoration(color: blue2),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Ingredients for',
                  style: TextStyle(fontSize: 22, color: Colors.white)),
              SizedBox(height: 10),
              Text('4 servings',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(ingredient[index].ingredientName,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                          Text(
                              ingredient[index].ingredientAmount.toString() +
                                  " " +
                                  ingredient[index].ingredientUnit.toString(),
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white))
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                          thickness: 1.5,
                        ),
                    itemCount: ingredient.length),
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: blue3),
            alignment: Alignment.bottomCenter,
          ),
          SlidingUpPanelWidget(
            child: Container(
              margin: EdgeInsets.only(top: 30.0),
              decoration: BoxDecoration(
                  color: Colors.black.withAlpha(180),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(15))),
              height: MediaQuery.of(context).size.height * 0.92,
              child: Column(children: [
                PreparationHeader(
                    currentIndex: currentIndex, totalPages: totalPages),
                PreparationStepProgress(
                    currentIndex: currentIndex, totalPages: totalPages),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (page) {
                      setState(() {
                        currentIndex = page;
                      });
                    },
                    itemBuilder: (context, position) {
                      return DetailPreparationStep(
                          direction: widget.directions[position]);
                    },
                    itemCount: totalPages,
                    scrollDirection: Axis.horizontal,
                  ),
                )
              ]),
            ),
            controlHeight: 50.0,
            panelStatus: SlidingUpPanelStatus.expanded,
            anchor: 0.4,
            panelController: panelController,
            onTap: () {},
            dragDown: (details) {
              print('dragDown');
            },
            dragStart: (details) {
              print('dragStart');
            },
            dragCancel: () {
              print('dragCancel');
            },
            dragUpdate: (details) {
              print(
                  'dragUpdate,${panelController.status == SlidingUpPanelStatus.dragging ? 'dragging' : ''}');
            },
            dragEnd: (details) {
              if (SlidingUpPanelStatus.expanded != panelController.status) {
                panelController.hide();
                Navigator.pop(context);
              }
              print('dragEnd');
            },
          ),
        ],
      ),
    );
  }
}
