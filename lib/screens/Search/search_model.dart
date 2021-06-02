import 'dart:convert';
import 'package:cooking_master/screens/Search/recipe_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<RecipeSearch> _suggestions = history;
  List<RecipeSearch> get suggestions => _suggestions;

  String _query = '';
  String get query => _query;

  void onQueryChanged(String query) async {
    if (query == _query) return;

    _query = query;
    _isLoading = true;
    notifyListeners();

    if (query.isEmpty) {
      _suggestions = history;
    } else {
      final response = await http.get(
          Uri.parse(
              'https://tasty.p.rapidapi.com/recipes/list?from=0&size=20&tags=under_30_minutes&q=$query'),
          headers: {
            'x-rapidapi-key':
                'b5cb77ca4cmsh6d7443b3c0531dbp164d0ejsnf5baa63bf442',
            'x-rapidapi-host': 'tasty.p.rapidapi.com'
          });
      final body = json.decode(utf8.decode(response.bodyBytes));
      final results = body['results'] as List;

      _suggestions =
          results.map((e) => RecipeSearch.fromJson(e)).toSet().toList();
    }

    _isLoading = false;
    notifyListeners();
  }

  void clear() {
    _suggestions = history;
    notifyListeners();
  }
}

const List<RecipeSearch> history = [
  RecipeSearch(
    name: 'Bun dau mam tom',
    author: 'Ngo Duong Kha',
  ),
  RecipeSearch(
    name: 'Com ga Tam Ky',
    author: 'Bui Minh Huy',
  ),
  RecipeSearch(
    name: 'Banh xeo',
    author: 'Nguyen Duc Huong',
  ),
];

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
