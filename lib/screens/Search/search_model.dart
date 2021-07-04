import 'dart:collection';
import 'dart:convert';
import 'package:cooking_master/models/history_model.dart';
import 'package:cooking_master/screens/Search/recipe_search.dart';
import 'package:cooking_master/services/search_service.dart';
import 'package:flutter/material.dart';

class SearchModel extends ChangeNotifier {
  String _cate = 'all';
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final _service = SearchService();
  Queue<RecipeSearch> history; //= list as Queue<RecipeSearch>;
  List<RecipeSearch> _suggestions; // = list;
  List<RecipeSearch> get suggestions => _suggestions;
  String _query = '';
  String get query => _query;
  set cate(String cate) {
    _cate = cate;
  }

  Future<void> initdata() async {

    // await _service.getHistory().then((value) {
    //   if (value.length > 0) {
    //     value.forEach((element) {
    //       history.addFirst(element);
    //     });
    //   }
    // });
    // _suggestions = history as List<RecipeSearch>;
  }

  void updateHistory(RecipeSearch recipeSearch) {
    history.addFirst(recipeSearch);
    if (history.length > 3) history.removeLast();
    List<HistoryModel> historyModels;
    history.forEach((element) {
      historyModels.add(HistoryModel.fromRecipe(element));
    });
    _service.updateHistory(historyModels);
  }

  void onQueryChanged(String query) async {
    if (query == _query) return;

    _query = query;
    _isLoading = true;
    notifyListeners();
    if (query.isEmpty) {
      _suggestions = history as List<RecipeSearch>;
    } else {
      //print(query);
      _suggestions = await _service.searchBy(_cate, query);
    }
    _isLoading = false;
    notifyListeners();
  }

  void clear() {
    _suggestions = history as List<RecipeSearch>;
    notifyListeners();
  }
}



/*
{
  "count":9
  "results":[9 items
    0:
      {
      "show_id":17
      "total_time_tier":{...}2 items
      "canonical_id":"recipe:7395"
      "nutrition":{...}7 items
      "servings_noun_plural":"servings"
      "show":{...}2 items
      "buzz_id":NULL
      "created_at":1621636122
      "keywords":""
      "num_servings":4
      "promotion":"full"
      "tips_and_ratings_enabled":true
      "video_id":NULL
      "brand":NULL
      "country":"US"
      "inspired_by_url":NULL
      "is_shoppable":true
      "language":"eng"
      "name":"Zesty Sweet Crispy Soy Pork"
      "instructions":[...]7 items
      "cook_time_minutes":NULL
      "description":"It's zesty, it's sweet, it's crispy, it's....soy?! That's right - we tried to make a jingle, but then we decided we'd just make our soy pork instead, and, well, we want you to join in on the fun! We're bringing the Korean kitchen to you, and these pork belly bites are the best way to do that (well, in our opinion, at least). Go on, give 'em a shot for your next barbecue. You won't be sorry (we promise)."
      "is_one_top":false
      "slug":"zesty-sweet-crispy-soy-pork"
      "video_url":NULL
      "sections":[...]1 item
      "credits":[...]1 item
      "facebook_posts":[]0 items
      "aspect_ratio":"16:9"
      "id":7395
      "servings_noun_singular":"serving"
      "total_time_minutes":NULL
      "compilations":[]0 items
      "renditions":[]0 items
      "prep_time_minutes":NULL
      "recirc_feeds":{...}2 items
      "draft_status":"published"
      "seo_title":""
      "thumbnail_url":"https://img.buzzfeed.com/tasty-app-user-assets-prod-us-east-1/recipes/e9c98a4299f44eb59616214d68e5685a.png"
      "tags":[...]4 items
      "original_video_url":NULL
      "nutrition_visibility":"auto"
      "user_ratings":{...}3 items
      "video_ad_content":NULL
      "approved_at":1621972393
      "beauty_url":NULL
      "brand_id":NULL
      "updated_at":1621972393
      "yields":"Servings: 4-5"
    }
    1:{...},
    2:{...},
    3:{...},
    4:{...},
    5:{...},
    6:{...},
    7:{...},
    8:{...},
  ]
}
*/
