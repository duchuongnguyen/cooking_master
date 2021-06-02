import 'package:cooking_master/screens/Search/recipe_search.dart';
import 'package:cooking_master/screens/Search/recipe_search_item.dart';
import 'package:cooking_master/screens/Search/search_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:provider/provider.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailSearchScreen extends StatelessWidget {
  final String keyword;

  const DetailSearchScreen({Key key, this.keyword}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: ChangeNotifierProvider(
          create: (_) => SearchModel(),
          child: Home(
            parentContext: context,
            keyword: keyword,
          ),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  final BuildContext parentContext;
  final String keyword;
  const Home({Key key, this.parentContext, this.keyword}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = FloatingSearchBarController();
  var cards = [];
  bool isFirstRender = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.keyword == null)
        controller.open();
      else { //Run when user tap on chips in previous screen
        String query = widget.keyword;
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
        setState(() {
          cards = results.map((e) => RecipeSearch.fromJson(e)).toSet().toList();
        });
        isFirstRender = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        backgroundColor: Colors.white,
      ),
      resizeToAvoidBottomInset: false,
      body: buildSearchBar(),
    );
  }

  Widget buildSearchBar() {
    final actions = [
      FloatingSearchBarAction(
        showIfOpened: false,
        child: CircularButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
      ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ];

    final leadings = [
      FloatingSearchBarAction.icon(
        showIfOpened: false,
        icon: Icon(Icons.arrow_back),
        onTap: () => Navigator.pop(widget.parentContext),
      ),
    ];

    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Consumer<SearchModel>(
      builder: (context, model, _) => FloatingSearchBar(
        automaticallyImplyBackButton: false,
        controller: controller,
        clearQueryOnClose: false,
        hint: 'Recipes, ingredients',
        iconColor: Colors.grey,
        transitionDuration: const Duration(milliseconds: 800),
        transitionCurve: Curves.easeInOutCubic,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        actions: actions,
        leadingActions: leadings,
        progress: model.isLoading,
        margins: EdgeInsets.only(top: 20, left: 20, right: 20),
        borderRadius: BorderRadius.circular(20),
        debounceDelay: const Duration(milliseconds: 500),
        onQueryChanged: model.onQueryChanged,
        scrollPadding: EdgeInsets.zero,
        transition: CircularFloatingSearchBarTransition(spacing: 16),
        builder: (context, _) => buildExpandableBody(model), // Data of searching suggestion here
        body: buildBody(), //Data of recipe render here
        onSubmitted: (_) => setState(() {
          cards = model.suggestions.toList();
          WidgetsBinding.instance
              .addPostFrameCallback((_) => controller.close());
        }),
      ),
    );
  }

  Widget buildBody() {
    return (isFirstRender && widget.keyword != null)
        ? Container(
            alignment: Alignment.center,
            child: Image.asset('assets/images/loading.gif'),
          )
        : cards.length == 0
            ? Container(
                color: Colors.white,
              )
            : StaggeredGridView.countBuilder(
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                padding:
                    EdgeInsets.only(top: 80, left: 10, right: 10, bottom: 30),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                crossAxisCount: 2,
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  return RecipeSearchItem(
                      image: cards[index].image, name: cards[index].name);
                });
  }

  Widget buildExpandableBody(SearchModel model) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Material(
        color: Colors.white,
        elevation: 4.0,
        borderRadius: BorderRadius.circular(8),
        child: ImplicitlyAnimatedList<RecipeSearch>(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          items: model.suggestions.take(6).toList(),
          areItemsTheSame: (a, b) => a == b,
          itemBuilder: (context, animation, recipe, i) {
            return SizeFadeTransition(
              animation: animation,
              child: buildItem(context, recipe),
            );
          },
          updateItemBuilder: (context, animation, recipe) {
            return FadeTransition(
              opacity: animation,
              child: buildItem(context, recipe),
            );
          },
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, RecipeSearch recipe) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final model = Provider.of<SearchModel>(context, listen: false);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            FloatingSearchBar.of(context).close();
            Future.delayed(
              const Duration(milliseconds: 500),
              () => model.clear(),
            );
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 16, bottom: 16, right: 16),
            child: Row(
              children: [
                SizedBox(
                  width: 45,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: model.suggestions == history
                        ? const Icon(Icons.history, key: Key('history'))
                        : (recipe.image == null)
                            ? Container()
                            : FadeInImage.assetNetwork(
                                placeholder: 'assets/images/loading.gif',
                                image: recipe.image,
                              ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.name,
                        style: textTheme.subtitle1,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        recipe.level2Address,
                        style: textTheme.bodyText2
                            .copyWith(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (model.suggestions.isNotEmpty && recipe != model.suggestions.last)
          const Divider(height: 0),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
