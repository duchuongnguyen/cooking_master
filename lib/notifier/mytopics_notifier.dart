import 'package:cooking_master/services/mytopics_service.dart';
import 'package:flutter/cupertino.dart';

class MyTopicsNotifier extends ChangeNotifier {
  MyTopicsService _ser = MyTopicsService();
  List<String> _myTopics;
  List<String> get MyTopics => _myTopics;

  loadMayTopics(String id) async {
    _myTopics = await _ser.getMyTopics(id);
    notifyListeners();
  }
}
