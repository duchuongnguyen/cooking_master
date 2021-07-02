import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/constants/padding_constant.dart';
import 'package:cooking_master/models/user_model.dart';
import 'package:cooking_master/screens/Search/detail_search_screen.dart';
import 'package:cooking_master/services/userprofile_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cooking_master/screens/user_profile_screen.dart';

class HeaderWithSearchBox extends StatelessWidget {
  const HeaderWithSearchBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(bottom: defaultPadding),
      height: size.height * 0.2,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: defaultPadding,
              right: defaultPadding,
              bottom: defaultPadding * 2,
            ),
            height: size.height * 0.2 - 27,
            decoration: BoxDecoration(
                color: blue2,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                )),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    StreamBuilder<UserModel>(
                        stream: UserProfileService()
                            .loadProfile(FirebaseAuth.instance.currentUser.uid),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              AppLocalizations.of(context).hello +
                                  ", " +
                                  snapshot.data.userName,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProfileScreen()));
                      },
                      child: StreamBuilder<UserModel>(
                          stream: UserProfileService().loadProfile(
                              FirebaseAuth.instance.currentUser.uid),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Hero(
                                tag: 'avatar',
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(snapshot.data.userImage),
                                  ),
                                ),
                              );
                            }
                            return Center(child: CircularProgressIndicator());
                          }),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context).askCook,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailSearchScreen(
                    keyword: 'all',
                  ),
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: defaultPadding),
                padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                height: 54,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50.0,
                        color: blue2.withOpacity(0.23),
                      )
                    ]),
                child: AbsorbPointer(
                  absorbing: true,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).search,
                      hintStyle: TextStyle(
                        color: blue2.withOpacity(0.5),
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      suffixIcon: FaIcon(
                        FontAwesomeIcons.search,
                        color: blue2.withOpacity(0.5),
                      ),
                      suffixIconConstraints: BoxConstraints(
                        minHeight: 32,
                        minWidth: 32,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
