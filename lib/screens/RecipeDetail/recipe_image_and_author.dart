import 'package:cooking_master/models/recipe_model.dart';
import 'package:flutter/material.dart';

class RecipeImageAndAuthor extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeImageAndAuthor({
    Key key,
    @required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          <Widget>[
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  recipe.image,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  "assets/images/user.jpg",
                  width: 40,
                  height: 40,
                ),
              ),
              title: Text(
                'Recipe by',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
              ),
              subtitle: Text(
                'Gordon Ramsay',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 144, 71),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(recipe.description),
          ],
        ),
      ),
    );
  }
}
