import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/models/nton_user_saved_recipe.dart';
import 'package:cooking_master/notifier/user_saved_recipe.dart';
import 'package:cooking_master/widgets/show_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCategoryDrawer extends StatefulWidget {
  final String idRecipe;

  const AddCategoryDrawer({Key key, this.idRecipe}) : super(key: key);
  @override
  _AddCategoryDrawerState createState() => _AddCategoryDrawerState();
}

class _AddCategoryDrawerState extends State<AddCategoryDrawer> {
  FocusNode myFocusNode;
  bool isAdding;
  bool isSaved;
  final myController = TextEditingController();
  @override
  void initState() {
    isAdding = false;
    isSaved = false;
    myFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          toolbarHeight: 0.0,
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        body: Consumer<SavedRecipeProvider>(
            builder: (context, saveRecipeProvider, child) {
          return Material(
            color: Theme.of(context).backgroundColor,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (isSaved) {
                          saveRecipeProvider.removeRecipeToMycategory(
                              widget.idRecipe, 'All');
                        }
                        isSaved = !isSaved;
                      });
                    },
                    child: CategoryTile(
                      name: "Save recipe",
                      isSelected: isSaved,
                      isBold: true,
                      color: blue3.withOpacity(0.5),
                    ),
                  ),
                  isAdding
                      ? Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: TextField(
                            controller: myController,
                            focusNode: myFocusNode,
                            onSubmitted: (String value) {
                              if (saveRecipeProvider
                                  .checkNameCategoryExist(value)) {
                                final didRequest = showAlertDialog(
                                  context,
                                  title: 'Exist',
                                  content: 'This name is exist',
                                  defaultActionText: 'OK',
                                );
                              } else {
                                setState(() {
                                  saveRecipeProvider.addRecipeToMycategory(
                                      widget.idRecipe, value);
                                  isAdding = false;
                                  isSaved = true;
                                  myController.clear();
                                });
                              }
                            },
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                // contentPadding: EdgeInsets.only(
                                //     left: 15, bottom: 11, top: 11, right: 15),
                                hintText: "New Collection"),
                          ))
                      : InkWell(
                          splashColor: blue5,
                          highlightColor: blue5,
                          onTap: () {
                            setState(() {
                              isAdding = true;
                              myFocusNode.requestFocus();
                            });
                          },
                          child: AddCategoryTile()),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: saveRecipeProvider.listMyCategory.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          splashColor: blue5,
                          highlightColor: blue5,
                          onTap: () {
                            setState(() {
                              if (checkIsSaved(
                                      saveRecipeProvider.listMyCategory
                                          .elementAt(index),
                                      widget.idRecipe) ==
                                  false) {
                                isSaved = true;
                                saveRecipeProvider.addRecipeToMycategory(
                                    widget.idRecipe,
                                    saveRecipeProvider.listMyCategory
                                        .elementAt(index)
                                        .category);
                              } else {
                                saveRecipeProvider.removeRecipeToMycategory(
                                    widget.idRecipe,
                                    saveRecipeProvider.listMyCategory
                                        .elementAt(index)
                                        .category);
                              }
                            });
                          },
                          child: CategoryTile(
                            name: saveRecipeProvider.listMyCategory
                                .elementAt(index)
                                .category,
                            isSelected: 
                                saveRecipeProvider.listMyCategory
                                    .elementAt(index).idRecipe.contains(widget.idRecipe)
                                ,
                            color:
                                index % 2 == 0 ? blue3.withOpacity(0.5) : null,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}

class CategoryTile extends StatelessWidget {
  final String name;
  final bool isSelected;
  final bool isBold;
  final Color color;
  const CategoryTile({
    Key key,
    @required this.name,
    @required this.isSelected,
    this.isBold = false,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(color: color),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.w500 : FontWeight.normal,
                  fontSize: 16.0),
            ),
            isSelected ? Icon(Icons.check) : Icon(Icons.crop_square)
          ],
        ),
      ),
    );
  }
}

class AddCategoryTile extends StatelessWidget {
  const AddCategoryTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "New Collection",
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0),
          ),
          Icon(Icons.add)
        ],
      ),
    );
  }
}

deleteAllCategory() {
  categories.forEach((category) {
    category.isSelected = false;
  });
}

bool checkIsSaved(NtoNUserSavedRecipe listcate, String idRecipe) {
  listcate.idRecipe.forEach((element) {
    if (element == idRecipe) {
      print('Dung roi a');
      return true;
    }
  });
  return false;
}

class RecipeCategoryModel {
  String name;
  bool isSelected;
  RecipeCategoryModel(this.name, this.isSelected);
}

List<RecipeCategoryModel> getListRecipe(var data) {
  List<RecipeCategoryModel> cards = data
      .frommap(
        (item) => RecipeCategoryModel(item['name'], item['isSelected']),
      )
      .toList();
  return cards;
}

List<RecipeCategoryModel> categories = categoriesData
    .map(
      (item) => RecipeCategoryModel(item['name'], item['isSelected']),
    )
    .toList();

var categoriesData = [
  {
    "name": "Breakfast",
    "isSelected": false,
  },
  {
    "name": "Lunch",
    "isSelected": false,
  },
  {
    "name": "Dinner",
    "isSelected": false,
  },
];
