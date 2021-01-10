import 'dart:math';

import 'package:flutter/material.dart';

import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';

import 'package:provider/provider.dart';

import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../../models/place.dart';
import '../../models/searchModel.dart';

class MatSearchBar extends StatefulWidget {
  const MatSearchBar({Key key}) : super(key: key);

  @override
  _MatSearchBarState createState() => _MatSearchBarState();
}

class _MatSearchBarState extends State<MatSearchBar> {
  final controller = FloatingSearchBarController();

  int _index = 0;
  int get index => _index;
  set index(int value) {
    _index = min(value, 2);
    _index == 2 ? controller.hide() : controller.show();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(height: 15, color: Colors.transparent),
      Container(height: 700, child: buildSearchBar()),
    ]);
  }

  Widget buildSearchBar() {
    final actions = [
      FloatingSearchBarAction(
        showIfOpened: false,
        child: CircularButton(
          icon: const Icon(Icons.place),
          onPressed: () {},
        ),
      ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ];

    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Container(
      height: 100,
      child: Consumer<SearchModel>(
        builder: (context, model, _) => FloatingSearchBar(
          elevation: 0.0,
          backdropColor: Colors.white10,
          automaticallyImplyBackButton: false,
          controller: controller,
          clearQueryOnClose: true,
          hint: 'Search Here...',
          iconColor: Colors.grey,
          transitionDuration: const Duration(milliseconds: 800),
          transitionCurve: Curves.easeInOutCubic,
          physics: const BouncingScrollPhysics(),
          axisAlignment: isPortrait ? 0.0 : -1.0,
          openAxisAlignment: 0.0,
          maxWidth: isPortrait ? 600 : 500,
          actions: actions,
          progress: model.isLoading,
          debounceDelay: const Duration(milliseconds: 500),
          onQueryChanged: model.onQueryChanged,
          scrollPadding: EdgeInsets.zero,
          transition: CircularFloatingSearchBarTransition(),
          builder: (context, _) => buildExpandableBody(model),
          //body: Container(),
        ),
      ),
    );
  }

  Widget buildExpandableBody(SearchModel model) {
    //Where Products are shown
    return Material(
      color: Colors.white,
      elevation: 4.0,
      borderRadius: BorderRadius.circular(8),
      child: ImplicitlyAnimatedList<Place>(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        items: model.suggestions.take(4).toList(),
        areItemsTheSame: (a, b) => a == b,
        itemBuilder: (context, animation, place, i) {
          return SizeFadeTransition(
            animation: animation,
            child: buildItem(context, place),
          );
        },
        updateItemBuilder: (context, animation, place) {
          return FadeTransition(
            opacity: animation,
            child: buildItem(context, place),
          );
        },
      ),
    );
  }

  Widget buildItem(BuildContext context, Place place) {
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
              () {
                print("Buying ${place.productName}");
                model.clear();
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                SizedBox(
                  width: 36,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: model.suggestions == history
                        ? const Icon(Icons.history, key: Key('history'))
                        : CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Image.network(place.productImage)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.productName,
                        style: textTheme.subtitle1,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Ksh.${place.amount.toString()}",
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
        if (model.suggestions.isNotEmpty && place != model.suggestions.last)
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
