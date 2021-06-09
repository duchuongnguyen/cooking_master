import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/models/user_model.dart';
import 'package:cooking_master/screens/user_profile_watch_screen.dart';
import 'package:cooking_master/services/userprofile_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeImageAndAuthor extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeImageAndAuthor({
    Key key,
    @required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProfileService = Provider.of<UserProfileService>(context);

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
            FutureBuilder<UserModel>(
                future: userProfileService.loadProfile(recipe.owner),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListTile(
                      contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                      leading: Stack(children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UserProfileWatchScreen(snapshot.data)));
                          },
                          child: Container(
                            width: 55,
                            height: 55,
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(snapshot.data.userImage),
                            ),
                          ),
                        ),
                        //if(user.isFollow == false) Only show when user haven't follow before
                        Positioned(
                          bottom: -12,
                          right: -12,
                          child: AnimatedIconButton(
                            size: 20,
                            onPressed: () => print('all icons pressed'),
                            icons: [
                              AnimatedIconItem(
                                icon: Icon(
                                  Icons.add_circle,
                                  color: Colors.red,
                                ),
                                onPressed: () => print('follow pressed'),
                              ),
                              AnimatedIconItem(
                                icon: Icon(
                                  Icons.done_rounded,
                                  color: Colors.red,
                                ),
                                onPressed: () => print('unfollow pressed'),
                              ),
                            ],
                          ),
                        )
                      ]),
                      title: Text(
                        'Recipe by',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                      subtitle: Text(
                        snapshot.data.userName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 144, 71),
                        ),
                      ),
                    );
                  } else {
                    return ListTile(
                      contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/images/user.jpg"),
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
                    );
                  }
                }),
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
