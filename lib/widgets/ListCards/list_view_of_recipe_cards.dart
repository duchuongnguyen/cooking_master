import 'dart:ui';
import 'package:cooking_master/constants/color_constant.dart';
import 'package:cooking_master/constants/padding_constant.dart';
import 'package:cooking_master/models/recipe_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

class ListViewOfRecipeCards extends StatefulWidget {
  const ListViewOfRecipeCards(
      {Key key,
      @required this.size,
      @required this.cards,
      this.action,
      this.isEditing,
      this.parent})
      : super(key: key);

  final Size size;
  final List<RecipeCardModel> cards;
  final Widget action;
  final bool isEditing;
  final parent;
  @override
  _ListViewOfRecipeCardsState createState() => _ListViewOfRecipeCardsState();
}

class _ListViewOfRecipeCardsState extends State<ListViewOfRecipeCards> {
  //List<RecipeCardModel> cards;
  @override
  void initState() {
    super.initState();
    //cards = widget.cards;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: defaultPadding * 0.6),
      height: widget.size.height * 0.35,

      //List of recipe cards
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(
              left: defaultPadding, right: defaultPadding * 0.4),
          itemCount: cards.length,
          itemBuilder: (context, index) {
            return widget.action != null
                ? FocusedMenuHolder(
                    menuWidth: widget.size.width * 0.5,
                    menuItems: [
                      FocusedMenuItem(
                          title: Text("Select Item"),
                          onPressed: () {
                            widget.parent.setState(() {
                              widget.parent.isEditing = true;
                            });
                            setState(() {
                              cards[index].isSelected =
                                  !cards[index].isSelected;
                            });
                          },
                          trailingIcon: Icon(Icons.done)),
                      FocusedMenuItem(
                          title: Text("Select All"),
                          onPressed: () {
                            widget.parent.setState(() {
                              widget.parent.isEditing = true;
                            });
                            setState(() {
                              setAllSelected(cards);
                            });
                          },
                          trailingIcon: Icon(Icons.done_all)),
                      FocusedMenuItem(
                          title: Text("Delete"),
                          onPressed: () {
                            widget.parent.setState(() {
                              cards.removeAt(index);
                            });
                          },
                          trailingIcon: Icon(Icons.delete_outline)),
                    ],
                    blurBackgroundColor: Colors.grey[900],
                    menuOffset: 20,
                    openWithTap: false,
                    onPressed: () {},
                    duration: Duration(seconds: 0),
                    animateMenuItems: false,
                    child: GestureDetector(
                      onTap: widget.isEditing
                          ?
                          //Select item
                          () {
                              setState(() {
                                cards[index].isSelected =
                                    !cards[index].isSelected;
                              });
                            }
                          :
                          //Open item
                          () {},
                      child: Container(
                        width: widget.size.width * 0.5,
                        height: widget.size.width * 0.5,
                        margin: EdgeInsets.only(right: defaultPadding * 0.7),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: blue2.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              )
                            ],
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(cards[index].recipeImage),
                            )),
                        child: Stack(
                          children: [
                            //Kind of recipe
                            Positioned(
                              top: defaultPadding,
                              left: defaultPadding,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaY: 19.2,
                                    sigmaX: 19.2,
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: defaultPadding * 0.5,
                                        right: defaultPadding * 0.5,
                                        top: defaultPadding * 0.2,
                                        bottom: defaultPadding * 0.2),
                                    child: Text(
                                      cards[index].recipeKind,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: widget.size.width * 0.5,
                            ),
                            //Detail Information
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: EdgeInsets.all(defaultPadding * 0.45),
                                margin: EdgeInsets.only(bottom: defaultPadding),
                                width: widget.size.width * 0.45,
                                height: widget.size.height * 0.35 * 0.25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.black.withOpacity(0.7),
                                ),
                                child: Stack(
                                  children: [
                                    //Recipe Name
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        width: widget.size.width * 0.45 * 0.6,
                                        height: widget.size.height *
                                            0.35 *
                                            0.3 *
                                            0.7,
                                        child: Text(
                                          cards[index].recipeName,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    //Recipe Save
                                    Positioned(
                                        top: -defaultPadding + 5,
                                        right: -defaultPadding + 5,
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                              Icons.bookmark_border_rounded,
                                              color: Colors.white,
                                              size: 18),
                                        )),

                                    //Time & Serving
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        cards[index].recipeCookTime +
                                            ' | ' +
                                            cards[index]
                                                .recipeServingNumber
                                                .toString() +
                                            " " +
                                            AppLocalizations.of(context)
                                                .serving,
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            cards[index].isSelected
                                ? Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.check_circle,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                    ),
                  )
                :

                //Without delete
                Container(
                    width: widget.size.width * 0.5,
                    height: widget.size.width * 0.5,
                    margin: EdgeInsets.only(right: defaultPadding * 0.7),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: blue2.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          )
                        ],
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(cards[index].recipeImage),
                        )),
                    child: Stack(
                      children: [
                        //Kind of recipe
                        Positioned(
                          top: defaultPadding,
                          left: defaultPadding,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaY: 19.2,
                                sigmaX: 19.2,
                              ),
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: defaultPadding * 0.5,
                                    right: defaultPadding * 0.5,
                                    top: defaultPadding * 0.2,
                                    bottom: defaultPadding * 0.2),
                                child: Text(
                                  cards[index].recipeKind,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: widget.size.width * 0.5,
                        ),
                        //Detail Information
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: EdgeInsets.all(defaultPadding * 0.45),
                            margin: EdgeInsets.only(bottom: defaultPadding),
                            width: widget.size.width * 0.45,
                            height: widget.size.height * 0.35 * 0.25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.black.withOpacity(0.7),
                            ),
                            child: Stack(
                              children: [
                                //Recipe Name
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: widget.size.width * 0.45 * 0.6,
                                    height:
                                        widget.size.height * 0.35 * 0.3 * 0.7,
                                    child: Text(
                                      cards[index].recipeName,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                //Recipe Save
                                Positioned(
                                    top: -defaultPadding + 5,
                                    right: -defaultPadding + 5,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.bookmark_border_rounded,
                                          color: Colors.white, size: 18),
                                    )),

                                //Time & Serving
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    cards[index].recipeCookTime +
                                        ' | ' +
                                        cards[index]
                                            .recipeServingNumber
                                            .toString() +
                                        " " +
                                        AppLocalizations.of(context).serving,
                                    style: TextStyle(
                                        color: Colors.blueGrey, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          }),
    );
  }
}
