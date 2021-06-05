import 'package:cooking_master/services/mytopics_service.dart';
import 'package:flutter/cupertino.dart';

class MyTopicsNotifier extends ChangeNotifier {
  MyTopicsService _ser = MyTopicsService();
  List<String> _myTopics;
  List<String> get MyTopics => _myTopics;

  loadMyTopics(String id) async {
    _myTopics = await _ser.getMyTopics(id);
    notifyListeners();
  }

  deleteTopic(String topic) async {
    _myTopics.remove(topic);
    _ser.update(_myTopics);
    notifyListeners();
  }

  addTopic(String topic) async {
    _myTopics.add(topic);
    _ser.update(_myTopics);
    notifyListeners();
  }
}
