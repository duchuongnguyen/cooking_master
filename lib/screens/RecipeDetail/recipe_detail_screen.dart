import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/screens/RecipeDetail/SaveRecipeDrawer/add_category_drawer.dart';
import 'package:cooking_master/screens/RecipeDetail/preparation_step_list.dart';
import 'package:cooking_master/screens/RecipeDetail/preparation_title.dart';
import 'package:cooking_master/screens/RecipeDetail/related_recipes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'recipe_image_and_author.dart';
import 'recipe_tip.dart';
import 'sliver_recipe_appbar.dart';

class RecipeDetailScreen extends StatefulWidget {
  final RecipeModel recipe;

  const RecipeDetailScreen({Key key, @required this.recipe}) : super(key: key);

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  int servings;
  bool isShowingNutrition;

  @override
  void initState() {
    super.initState();
    servings = widget.recipe.yields;
    isShowingNutrition = false;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //systemNavigationBarColor: Colors.blue,
      statusBarColor: Colors.transparent,
      //statusBarBrightness: Brightness.dark,
    ));
  }

  Color currentColor = Colors.black54;

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      borderRadius: 20.0,
      key: _innerDrawerKey,
      onTapClose: false,
      tapScaffoldEnabled: true,
      velocity: 20,
      swipeChild: true,
      scale: IDOffset.horizontal(0.9),
      offset: IDOffset.horizontal(0.6),
      swipe: true,
      colorTransitionChild: Colors.black54,
      colorTransitionScaffold: Colors.black87,
      rightAnimationType: InnerDrawerAnimation.linear,
      rightChild: AddCategoryDrawer(),
      scaffold: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 0.0,
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverRecipeAppbar(
              recipe: widget.recipe,
              innerDrawerKey: _innerDrawerKey,
            ),
            RecipeImageAndAuthor(recipe: widget.recipe),
            //buildIngredientTabBar(),
            //SliverIngredientList(),
            //buildNutritionInfoTabBar(),
            // isShowingNutrition
            //    ? SliverNutritionList()
            //    : SliverList(
            //        delegate: SliverChildListDelegate(<Widget>[Container()])),
            RecipeTip(recipe: widget.recipe),
            RelatedRecipes(),
            PreparationTitle(),
            PreparationStepList()
          ],
        ),
      ),
    );
  }

  SliverPadding buildNutritionInfoTabBar() {
    return SliverPadding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30),
      sliver: SliverList(
          delegate: SliverChildListDelegate(<Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Nutrition info",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            !isShowingNutrition
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        isShowingNutrition = true;
                      });
                    },
                    child: Text(
                      "View info +",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: blue2,
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        isShowingNutrition = false;
                      });
                    },
                    child: Text(
                      "Hide info -",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: blue2,
                      ),
                    ),
                  ),
          ],
        ),
      ])),
    );
  }

  SliverPadding buildIngredientTabBar() {
    return SliverPadding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10),
        sliver: SliverList(
            delegate: SliverChildListDelegate(<Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ingredients for",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    servings.toString() + " servings",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Container(
                  height: 30,
                  //padding: EdgeInsets.only(left: 1, right: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: blue2, width: 0.5)),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              servings = servings > 1 ? --servings : servings;
                            });
                          },
                          child: Icon(
                            Icons.remove,
                            color: blue2,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          servings.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: blue2,
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              servings = servings < 99 ? ++servings : servings;
                            });
                          },
                          child: Icon(
                            Icons.add,
                            color: blue2,
                          ),
                        ),
                        SizedBox(width: 5),
                      ]))
            ],
          ),
        ])));
  }
}
