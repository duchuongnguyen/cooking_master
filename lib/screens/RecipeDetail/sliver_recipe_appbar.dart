import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/widgets/CustomBackButton.dart';
import 'package:cooking_master/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

import '../recipe_detail_screen.dart';

class SliverRecipeAppbar extends StatelessWidget {
  final RecipeModel recipe;
  final List<String> dynamicTopics;

  const SliverRecipeAppbar({
    Key key,
    @required this.dynamicTopics,
    @required this.recipe,
  })  : assert(recipe != null),
        super(key: key);

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
                recipe.name,
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
                      children: List<Widget>.generate(dynamicTopics.length,
                          (int index) {
                        //List of Favorite Topics
                        return Chip(
                          label: Text(
                            dynamicTopics[index],
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
