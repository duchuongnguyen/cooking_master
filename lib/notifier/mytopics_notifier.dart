import 'package:cooking_master/services/mytopics_service.dart';
import 'package:flutter/cupertino.dart';

class MyTopicsNotifier extends ChangeNotifier {
  MyTopicsService _ser = MyTopicsService();
  List<String> _myTopicsid;
  List<String> _myTopicsString = [];
  List<Map<String, dynamic>> allCategory;
  List<String> get myTopicsString => _myTopicsString;
  List<String> get myTopics => _myTopicsid;
  List<Map<String, dynamic>> get getAllCategory => allCategory;
  loadMyTopics(String uid) async {
    _myTopicsid = await _ser.getMyTopics(uid);
    allCategory = await _ser.getAllCategories();
    setMytopicString();
    notifyListeners();
  }

  deleteTopic(String topic) async {
    _myTopicsid.remove(topic);
    _ser.update(_myTopicsid);
    notifyListeners();
  }

  addTopic(String topic) async {
    _myTopicsid.add(topic);
    _ser.update(_myTopicsid);
    notifyListeners();
  }

  update(List<String> topics) async {
    _ser.update(topics);
  }

  setMytopicString() {
    _myTopicsString.clear();
    _myTopicsid.forEach((topicid) {
      allCategory.forEach((element) {
        if (topicid == element["cate_id"]) {
          _myTopicsString.add(element["name"].toString());
        }
      });
    });
  }
}
