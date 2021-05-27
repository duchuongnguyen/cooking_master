import 'package:cooking_master/widgets/CustomBackButton.dart';
import 'package:cooking_master/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

import '../recipe_detail_screen.dart';

class SliverRecipeAppbar extends StatelessWidget {
  const SliverRecipeAppbar({
    Key key,
    @required List<String> dynamicTopics,
  })  : _dynamicTopics = dynamicTopics,
        super(key: key);

  final List<String> _dynamicTopics;

  @override
  Widget build(BuildContext context) {
    double top = 0.0;
    return SliverPadding(
      padding: EdgeInsets.only(left: 10, right: 10),
      sliver: SliverAppBar(
        pinned: true,
        expandedHeight: MediaQuery.of(context).size.height * 0.18,
        backgroundColor: Colors.white,
        elevation: 0.0,
        onStretchTrigger: () {
          // Function callback for stretch
          return Future<void>.value();
        },
        leading: RoundedButton(
          button: CustomBackButton(
            tapEvent: () {
              Navigator.pop(context);
            },
          ),
        ),
        flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          top = constraints.biggest.height;
          return FlexibleSpaceBar(
              titlePadding: top > 125
                  ? EdgeInsetsDirectional.only(
                      start: 10.0,
                      bottom: 16.0,
                    )
                  : null,
              title: Text(
                RecipeDetailScreen.of(context).recipe.name,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              background: Container(
                child: Column(children: [
                  SizedBox(
                    height: 80,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: List<Widget>.generate(_dynamicTopics.length,
                          (int index) {
                        //List of Favorite Topics
                        return Chip(
                          label: Text(
                            _dynamicTopics[index],
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 144, 71),
                                fontWeight: FontWeight.w800),
                          ),
                          backgroundColor: Color.fromARGB(255, 255, 244, 237),
                        );
                      }),
                    ),
                  ),
                ]),
              ));
        }),
        actions: [
          RoundedButton(
            button: IconButton(
              icon: Icon(
                Icons.bookmark_border_rounded,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
