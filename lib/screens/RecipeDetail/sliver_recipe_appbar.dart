import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/widgets/CustomBackButton.dart';
import 'package:cooking_master/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

import 'recipe_detail_screen.dart';

class SliverRecipeAppbar extends StatelessWidget {
  final RecipeModel recipe;
  final GlobalKey<InnerDrawerState> innerDrawerKey;

  const SliverRecipeAppbar({
    Key key,
    @required this.recipe,
    @required this.innerDrawerKey,
  })  : assert(recipe != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double top = 0.0;
    return SliverAppBar(
      pinned: true,
      expandedHeight: MediaQuery.of(context).size.height *
          0.07 *
          (recipe.name.length / 60 + 2),
      backgroundColor: Colors.white.withOpacity(0.2),
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
        top = (constraints.biggest.height);
        return FlexibleSpaceBar(
          titlePadding: top > (80)
              ? EdgeInsetsDirectional.only(
                  start: 20.0,
                  bottom: 20.0,
                )
              : null,
          title: Text(
            top > 80
                ? recipe.name
                : recipe.name.length > 28
                    ? recipe.name.replaceRange(
                        recipe.name.substring(0, 28).lastIndexOf(" "),
                        recipe.name.length,
                        "...")
                    : recipe.name,
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        );
      }),
      actions: [
        RoundedButton(
          button: IconButton(
            icon: Icon(
              Icons.bookmark_border_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              innerDrawerKey.currentState.open();
            },
          ),
        ),
      ],
    );
  }
}
