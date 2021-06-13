import 'package:cooking_master/notifier/user_saved_recipe.dart';
import 'package:cooking_master/widgets/show_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final savedRecipeNotifier =
        Provider.of<SavedRecipeProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      body: Stack(
        children: [
          Align(
              alignment: Alignment.center,
              child: TextField(
                autofocus: true,
                onSubmitted: (String value) {
                  if (savedRecipeNotifier.checkNameCategoryExist(value)) {
                    final didRequest = showAlertDialog(
                      context,
                      title: 'Category Name Exist',
                      content: 'Please fill another name!',
                      defaultActionText: 'OK',
                    );
                  } else {
                    Navigator.pop(context, value);
                  }
                },
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
                decoration: InputDecoration(
                  hintText: "Name Your Collection",
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              )),
          Positioned(
            top: 50,
            right: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
