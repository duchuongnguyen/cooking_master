import 'package:cooking_master/constants/color_constant.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatefulWidget {
  const CategoryItem({
    Key key,
  }) : super(key: key);

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<String> placesCategoris = [
      "Của bạn",
      "Yêu thích",
    ];
    return Padding(
      padding: EdgeInsets.all(30),
      child: SizedBox(
        height: 40,
        width: 200,
        child: Center(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: placesCategoris.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      this.selectedIndex = index;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Text(
                          placesCategoris[index],
                          style: selectedIndex == index
                              ? TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)
                              : TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                        if (selectedIndex == index)
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              height: 3,
                              width: 22,
                              decoration: BoxDecoration(
                                color: blue2,
                                borderRadius: BorderRadius.circular(10),
                              ))
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
