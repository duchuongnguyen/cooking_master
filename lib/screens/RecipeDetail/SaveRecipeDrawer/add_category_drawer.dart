import 'package:cooking_master/constants/color_constant.dart';
import 'package:flutter/material.dart';

class AddCategoryDrawer extends StatefulWidget {
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
      body: Material(
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
                      deleteAllCategory();
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
                          setState(() {
                            categories.add(RecipeCategoryModel(value, true));
                            isAdding = false;
                            isSaved = true;
                            myController.clear();
                          });
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
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      splashColor: blue5,
                      highlightColor: blue5,
                      onTap: () {
                        setState(() {
                          if (checkIsSaved() == false) {
                            isSaved = true;
                          }
                          categories[index].isSelected =
                              !categories[index].isSelected;
                        });
                      },
                      child: CategoryTile(
                        name: categories[index].name,
                        isSelected: categories[index].isSelected,
                        color: index % 2 == 0 ? blue3.withOpacity(0.5) : null,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

bool checkIsSaved() {
  categories.forEach((category) {
    if (category.isSelected == true) {
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
