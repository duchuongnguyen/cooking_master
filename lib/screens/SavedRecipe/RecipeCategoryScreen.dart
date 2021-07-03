import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/notifier/user_saved_recipe.dart';
import 'package:cooking_master/screens/RecipeDetail/recipe_detail_screen.dart';
import 'package:cooking_master/screens/SavedRecipe/AddCategoryScreen.dart';
import 'package:cooking_master/screens/SavedRecipe/RecipesChoicesBuilder.dart';
import 'package:cooking_master/screens/Search/detail_search_screen.dart';
import 'package:cooking_master/screens/Search/recipe_search_item.dart';
import 'package:cooking_master/widgets/show_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:provider/provider.dart';
import 'package:sliver_header_delegate/sliver_header_delegate.dart';
import 'dart:math' as math;

class RecipeCategoryScreen extends StatefulWidget {
  final String kind;
  final String name;

  const RecipeCategoryScreen({Key key, this.kind, this.name}) : super(key: key);
  static _RecipeCategoryScreenState of(BuildContext context) =>
      context.findAncestorStateOfType<_RecipeCategoryScreenState>();

  @override
  _RecipeCategoryScreenState createState() => _RecipeCategoryScreenState();
}

enum MenuKind { delete, add }

class _RecipeCategoryScreenState extends State<RecipeCategoryScreen> {
  String name = "Collection Name";
  @override
  void initState() {
    super.initState();
    final savedRecipeNotifier =
        Provider.of<SavedRecipeProvider>(context, listen: false);
    if (widget.name != null) {
      name = widget.name;
    }
    if (widget.kind == "saved") {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final result = await Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (context, __, ___) => AddCategoryScreen(),
          ),
        );

        if (result != null) {
          setState(() {
            savedRecipeNotifier.SetCurCategory(result);
            name = result;
          });
        } else {
          Navigator.pop(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final expandedStyle =
        theme.textTheme.headline4.copyWith(color: Colors.white);
    final collapsedStyle =
        theme.textTheme.headline6.copyWith(color: Colors.white);
    const padding = EdgeInsets.symmetric(horizontal: 26, vertical: 26);
    return Scaffold(
      backgroundColor: Colors.white,
      body:
          Consumer<SavedRecipeProvider>(builder: (context, recipelist, child) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: FlexibleHeaderDelegate(
                statusBarHeight: MediaQuery.of(context).padding.top,
                expandedHeight: 200,
                background: MutableBackground(
                  expandedWidget: Image.asset(
                    'assets/images/category-background.jpg',
                    fit: BoxFit.fitWidth,
                  ),
                  collapsedColor: blue3.withAlpha(255),
                ),
                actions: [
                  PopupMenu(
                    name: name,
                  )
                ],
                children: [
                  FlexibleTextItem(
                    //Name of category
                    text: name,
                    collapsedStyle: collapsedStyle,
                    expandedStyle: expandedStyle,
                    expandedAlignment: Alignment.bottomLeft,
                    collapsedAlignment: Alignment.center,
                    expandedPadding: padding,
                  ),
                ],
              ),
            ),
            recipelist.curCategoryList.length >
                    0 //Check if category already have recipes
                ? SliverPadding(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 30, top: 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final int itemIndex = index ~/ 2;
                          if (index.isEven) {
                            return FocusedMenuHolder(
                              menuWidth:
                                  MediaQuery.of(context).size.width * 0.5,
                              menuItems: [
                                FocusedMenuItem(
                                    title: Text("Delete"),
                                    onPressed: () {
                                      setState(() {
                                        recipelist.deleterecipe(itemIndex);
                                      });
                                    },
                                    trailingIcon: Icon(Icons.delete_outline)),
                              ],
                              blurBackgroundColor: Colors.grey[900],
                              menuOffset: 20,
                              openWithTap: false,
                              onPressed: () {},
                              duration: Duration(seconds: 0),
                              animateMenuItems: false,
                              child: InkWell(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  splashColor: blue4,
                                  highlightColor: blue4,
                                  onTap: () {
                                    //Move to DetailRecipeScreen
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RecipeDetailScreen(
                                                    recipe: recipelist
                                                            .curCategoryList[
                                                        itemIndex])));
                                  },
                                  child: RecipeSearchItem(
                                    name: recipelist
                                        .curCategoryList[itemIndex].name,
                                    image: recipelist
                                        .curCategoryList[itemIndex].image,
                                  )),
                            );
                          }
                          return SizedBox(height: 20);
                        },
                        semanticIndexCallback: (Widget widget, int localIndex) {
                          if (localIndex.isEven) {
                            return localIndex ~/ 2;
                          }
                          return null;
                        },
                        childCount: math.max(
                            0, recipelist.curCategoryList.length * 2 - 1),
                      ),
                    ),
                  )
                : SliverFillRemaining(
                    child: _buildEmptyItem(),
                  )
          ],
        );
      }),
    );
  }

  Widget _buildEmptyItem() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 40),
          Icon(
            Icons.add_circle_outline,
            color: Colors.black,
            size: 46,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Add to this Collection",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 5),
          Text(
            "You have yet to add any recipe to this collection.",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailSearchScreen(
                            keyword: 'all',
                          )));
            },
            child: Text(
              "Discover recipes for $name",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600, color: blue2),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text("Or",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              )),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecipesChoicesBuilder()));
              setState(() {});
            },
            child: Text(
              "Add recipes from your saved list",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600, color: blue2),
            ),
          ),
        ],
      ),
    );
  }
}

class PopupMenu extends StatelessWidget {
  const PopupMenu({Key key, this.name}) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    final recipelist = Provider.of<SavedRecipeProvider>(context, listen: false);
    return PopupMenuButton(onSelected: (MenuKind result) async {
      switch (result) {
        case MenuKind.delete:
          if (name != "All") {
            //Delete this category
            final didRequest = await showAlertDialog(
              context,
              title: 'Delete',
              content: 'Are you sure that you want to delete this?',
              cancelActionText: 'Cancel',
              defaultActionText: 'Delete',
            );
            if (didRequest == true) {
              recipelist.deleteCatergory(name);
              Navigator.pop(context);
            }
          } else {
            final didRequest = await showAlertDialog(
              context,
              title: 'Delete',
              content:
                  'If you delete All, All your collections will be delete?',
              cancelActionText: 'Cancel',
              defaultActionText: 'Delete',
            );
            if (didRequest == true) {
              recipelist.deleteCatergory(name);
              Navigator.pop(context);
            }
          }
          break;
        case MenuKind.add:
          //Add recipe
          if (name != "All")
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RecipesChoicesBuilder()));
          break;
        default:
      }
    }, itemBuilder: (BuildContext context) {
      if (name != "All")
        return <PopupMenuEntry<MenuKind>>[
          const PopupMenuItem<MenuKind>(
            value: MenuKind.add,
            child: Text('Add recipe from saved list'),
          ),
          const PopupMenuItem<MenuKind>(
            value: MenuKind.delete,
            child: Text('Delete this category'),
          ),
        ];
      return <PopupMenuEntry<MenuKind>>[
        const PopupMenuItem<MenuKind>(
          value: MenuKind.delete,
          child: Text('Delete this category'),
        ),
      ];
    });
  }
}
