import 'dart:ui';
import 'package:cooking_master/models/recipe_card_model.dart';
import 'file:///D:/MyFlutterApplication/cooking_master/lib/widgets/list_view_of_recipe_cards_with_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'header_with_searchbox.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        HeaderWithSearchBox(size: size),

        //Trending Recipe, can add any kind of recipes in here
        ListViewOfRecipeCardsWithTitle(title: AppLocalizations.of(context).trend, size: size, cards: cards),
      ],
    );
  }
}
