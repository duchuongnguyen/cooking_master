import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/screens/Search/chips.dart';
import 'package:cooking_master/screens/Search/detail_search_screen.dart';
import 'package:cooking_master/screens/Search/sticky_label.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                      top: 20.0, left: 20.0, bottom: 16.0, right: 50.0),
                  child: Text(
                      "Hello, I am Cooking Master! What would you like to search?",
                      style: TextStyle(
                          fontSize: 26.0, fontWeight: FontWeight.w500))),
              SearchBar(),
              StickyLabel(
                text: "Your top recipes",
                textColor: Colors.black,
              ),
              Container(
                margin: EdgeInsets.only(top: 5.0, left: 4.0, right: 4.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        List<Widget>.generate(chipsRecipe.length, (int index) {
                      return Chips(text: chipsRecipe[index]);
                    }),
                  ),
                ),
              ),
              StickyLabel(
                text: "Browse all categories",
                textColor: Colors.black,
              ),
              Container(
                width: double.infinity,
                padding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 5),
                child: Wrap(
                  spacing: 1.0,
                  runSpacing: 1.0,
                  children: List<Widget>.generate(chipsCategories.length,
                      (int index) {
                    return Chips(text: chipsCategories[index]);
                  }),
                ),
              ),
            ],
          ),
        ));
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailSearchScreen(keyword: 'all',),
        ),
      ),
      child: AbsorbPointer(
        absorbing: true,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
              border: Border.all(width: 1.5, color: blue1),
              borderRadius: BorderRadius.circular(15)),
          child: TextField(
            cursorColor: blue2,
            decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(
                  Icons.search,
                  color: blue2,
                ),
                hintText: "Recipes, ingredients",
                hintStyle: TextStyle(
                  fontSize: 18.0,
                  color: blue2.withOpacity(0.7),
                )),
          ),
        ),
      ),
    );
  }
}

List<String> chipsRecipe = [
  "bread",
  "rice",
  "pasta",
  "beef",
  "cake",
  "soup",
  "sauce",
  "chicken",
];

List<String> chipsCategories = [
  "vegetables",
  "fastfood",
  "eggs",
  "Dinner",
  "vietnamese",
  "nooodles",
  "fish",
];
