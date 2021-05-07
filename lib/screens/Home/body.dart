import 'dart:ui';
import 'package:cooking_master/models/model-recipe-cuahuy.dart';
import 'package:cooking_master/models/recipe_card_model.dart';
import 'package:cooking_master/services/user_save_recipe.dart';
import 'package:cooking_master/widgets/list_view_of_recipe_cards_with_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    final db = Provider.of<FirebaseUserSaveRecipe>(context, listen: false);
    var map = new Map<String, List<RecipeCardModelcuahuy>>();
    return Scaffold(
        body: StreamBuilder<Map<String, List<RecipeCardModelcuahuy>>>(
            stream: db.mapListCardStream(),
            builder: (context, snapshot2) {
              if (snapshot2.hasData) {
                map = snapshot2.data;
                print(map);
               return
                    ListView.separated(
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: map.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 10),
                              SizedBox(height: 10),
                              ListViewOfRecipeCardsWithTitle(
                                title: map.keys.elementAt(index),
                                size: MediaQuery.of(context).size,
                                cards: map.values.elementAt(index),
                              ),
                              SizedBox(height: 10),
                            ],
                          );
                        });                                                                               
              }
              return LinearProgressIndicator();
            }));
  }
}
