import 'package:cooking_master/models/recipe_card_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipeDetailCard extends StatelessWidget {
  final RecipeCardModel recipe;
  final size;

  const RecipeDetailCard({Key key, this.recipe, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        height: size.width * 0.35,
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
                              recipe.recipeName,
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
                                Text(recipe.recipeCookTime)
                              ],
                            )),
                            Container(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.person_outline),
                                Text(recipe.recipeServingNumber.toString())
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
                              child: Text("Nguyên liệu"))),
                      Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                //Todo: Publish time here
                                "Đăng 12 phút trước",
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
                        DecorationImage(image: AssetImage(recipe.recipeImage))),
              ),
            ),
          ],
        ));
  }
}
