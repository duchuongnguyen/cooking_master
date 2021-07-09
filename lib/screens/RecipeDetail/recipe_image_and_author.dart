import 'package:cooking_master/models/recipe_model.dart';
import 'package:cooking_master/models/user_model.dart';
import 'package:cooking_master/screens/UserProfileWatch/user_profile_watch_screen.dart';
import 'package:cooking_master/services/auth_service.dart';
import 'package:cooking_master/services/userprofile_service.dart';
import 'package:flutter/material.dart';

class RecipeImageAndAuthor extends StatefulWidget {
  final RecipeModel recipe;

  const RecipeImageAndAuthor({
    Key key,
    @required this.recipe,
  }) : super(key: key);

  @override
  _RecipeImageAndAuthorState createState() => _RecipeImageAndAuthorState();
}

class _RecipeImageAndAuthorState extends State<RecipeImageAndAuthor> {
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
                  widget.recipe.image,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<UserModel>(
                stream: UserProfileService().loadProfile(widget.recipe.owner),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (Auth().currentUser.uid == widget.recipe.owner)
                      return ListTile(
                        contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                        leading: Stack(children: [
                          GestureDetector(
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
                        ]),
                        title: Text(
                          'Recipe by',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                        subtitle: Text(
                          snapshot.data.userName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[600],
                          ),
                        ),
                      );
                    else {
                      return ListTile(
                        contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                        leading: Stack(children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UserProfileWatchScreen(
                                              uid: snapshot.data.userId)));
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
                          Positioned(
                            bottom: -15,
                            right: -15,
                            child: Visibility(
                              visible: !snapshot.data.userFollower
                                  .contains(Auth().currentUser.uid),
                              child: IconButton(
                                iconSize: 20,
                                icon: Icon(Icons.add_circle),
                                color: Colors.red,
                                onPressed: () {
                                  UserProfileService().followUser(
                                      Auth().currentUser.uid,
                                      snapshot.data.userId);
                                },
                              ),
                            ),
                          ),
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
                            color: Colors.blue[400],
                          ),
                        ),
                      );
                    }
                  } else {
                    return ListTile(
                      contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CircularProgressIndicator(),
                      ),
                      title: Text(
                        'Recipe by',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                      subtitle: LinearProgressIndicator(),
                    );
                  }
                }),
            Text(
              widget.recipe.description,
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
