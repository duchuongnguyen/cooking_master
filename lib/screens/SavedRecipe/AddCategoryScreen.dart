import 'package:flutter/material.dart';

class AddCategoryScreen extends StatelessWidget {

  const AddCategoryScreen({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      body: Stack(
        children: [
          Align(
              alignment: Alignment.center,
              child: TextField(
                autofocus: true,
                onSubmitted: (String value) {
                  Navigator.pop(context, value);
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
