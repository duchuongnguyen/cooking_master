import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/notifier/recipes_notifier.dart';
import 'package:cooking_master/services/recipe_service.dart';
import 'package:cooking_master/widgets/list_view_of_recipe_cards_with_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'header_with_searchbox.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recipe = Provider.of<RecipeNotifier>(context, listen: false);
    if (recipe.listrecipes.isNotEmpty)
      return Column(
        children: <Widget>[
          HeaderWithSearchBox(),
          //Trending Recipe, can add any kind of recipes in here
          ListViewOfRecipeCardsWithTitle(
            title: AppLocalizations.of(context).trend,
            cards: recipe.listrecipes,
          ),
        ],
      );
    return Scaffold();
  }
}
