import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/models/recipe_card_model.dart';
import 'package:cooking_master/screens/SavedRecipe/AddCategoryScreen.dart';
import 'package:cooking_master/screens/SavedRecipe/RecipesChoicesBuilder.dart';
import 'package:cooking_master/screens/Search/detail_search_screen.dart';
import 'package:cooking_master/screens/Search/recipe_search_item.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
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
        body: CustomScrollView(
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
                actions: [PopupMenu()],
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
            cards.length > 0 //Check if category already have recipes
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
                                        cards.removeAt(index);
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
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => PreparationScreen()));
                                  },
                                  child: RecipeSearchItem(
                                    name: cards[itemIndex].recipeName,
                                    image: cards[itemIndex].image,
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
                        childCount: math.max(0, cards.length * 2 - 1),
                      ),
                    ),
                  )
                : SliverFillRemaining(
                    child: _buildEmptyItem(),
                  )
          ],
        ));
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
                            keyword: name,
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
  const PopupMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (MenuKind result) {
        switch (result) {
          case MenuKind.delete:
            //Delete this category
            Navigator.pop(context);
            break;
          case MenuKind.add:
            //Add recipe
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RecipesChoicesBuilder()));
            break;
          default:
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuKind>>[
        const PopupMenuItem<MenuKind>(
          value: MenuKind.add,
          child: Text('Add recipe from saved list'),
        ),
        const PopupMenuItem<MenuKind>(
          value: MenuKind.delete,
          child: Text('Delete this category'),
        ),
      ],
    );
  }
}
