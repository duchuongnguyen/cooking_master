import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/models/tip_model.dart';
import 'package:cooking_master/screens/RecipeDetail/AllTips/add_tip_fab.dart';
import 'package:cooking_master/screens/RecipeDetail/AllTips/tip.dart';
import 'package:cooking_master/services/recipe_service.dart';
import 'package:cooking_master/widgets/CustomBackButton.dart';
import 'package:flutter/material.dart';

class AllTipsScreen extends StatefulWidget {
  final RecipeModel recipe;

  const AllTipsScreen({
    Key key,
    @required this.recipe,
  }) : super(key: key);

  @override
  _AllTipsScreenState createState() => _AllTipsScreenState();
}

class _AllTipsScreenState extends State<AllTipsScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TipModel>>(
        stream: Stream.fromFuture(RecipeService().getTips(widget.recipe.id)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(
                  "${snapshot.data.length.toString()} tips", //Todo: Update tips count from database
                  style: TextStyle(color: blue1, fontWeight: FontWeight.bold),
                ),
                leading: CustomBackButton(
                  tapEvent: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    if (index == snapshot.data.length - 1)
                      return Column(children: [
                        Tip(recipe: widget.recipe, tip: snapshot.data[index]),
                        SizedBox(height: 50),
                      ]);
                    else
                      return Tip(
                          recipe: widget.recipe, tip: snapshot.data[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: snapshot.data.length),
              floatingActionButton: AddTipFAB(recipe: widget.recipe),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
