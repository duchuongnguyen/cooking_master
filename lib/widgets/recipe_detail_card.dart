import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/screens/RecipeDetail/recipe_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;

class RecipeDetailCard extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeDetailCard({Key key, this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RecipeDetailScreen(recipe: recipe)));
      },
      child: Container(
          margin: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.width * 0.35,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.25),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                recipe.name,
                                style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              )),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.schedule),
                                  Text(recipe.cookTime.toString())
                                ],
                              )),
                              Container(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.person_outline),
                                  Text(recipe.yields.toString())
                                ],
                              ))
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Align(
                                alignment: Alignment.centerLeft,
                                //Todo: Load ingredients here
                                child: Container())),
                        Expanded(
                            flex: 1,
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  timeago.format(DateTime.now().subtract(
                                      DateTime.now().difference(
                                          recipe.createdAt.toDate()))),
                                  style: GoogleFonts.roboto(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                )))
                      ],
                    )),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image:
                          DecorationImage(image: NetworkImage(recipe.image))),
                ),
              ),
            ],
          )),
    );
  }
}
