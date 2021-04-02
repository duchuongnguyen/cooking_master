import 'package:cooking_master/models/recipe_card_model.dart';
import 'package:flutter/material.dart';

class DetailRecipeScreen extends StatefulWidget {
  @override
  _DetailRecipeScreenState createState() => _DetailRecipeScreenState();
}

class _DetailRecipeScreenState extends State<DetailRecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DetailRecipeScreen(),
    );
  }
}

class DetailSilverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final RecipeCardModel recipe;

  DetailSilverDelegate(this.expandedHeight, this.recipe);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack (
      children: <Widget>[
        Image.asset(
          recipe.recipeImage,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
          fit: BoxFit.cover,
        ),
        Positioned(
            child: Container(

        ))
      ],
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => throw UnimplementedError();

  @override
  // TODO: implement minExtent
  double get minExtent => throw UnimplementedError();

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    throw UnimplementedError();
  }

}
