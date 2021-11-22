import 'package:flutter/material.dart';

import '../../../../core/components/list-view/indicator_list_view.dart';

class OnBoardIndicator extends StatelessWidget {
  const OnBoardIndicator(
      {Key? key, required this.itemCount, required this.currentIndex})
      : super(key: key);
  final int itemCount;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return IndicatorListView(
        itemCount: itemCount,
        currentIndex: currentIndex,
        onListItem: (index) {
          return Text(currentIndex.toString());
        });
  }
}
