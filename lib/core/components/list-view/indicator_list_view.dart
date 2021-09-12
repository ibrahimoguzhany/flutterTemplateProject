import 'package:flutter/material.dart';
import '../../extensions/context_extension.dart';

class IndicatorListView extends StatelessWidget {
  const IndicatorListView(
      {Key? key,
      required this.itemCount,
      required this.onListItem,
      required this.currentIndex})
      : super(key: key);
  final int itemCount;
  final int currentIndex;

  final Widget Function(int index) onListItem;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => buildPadding(context, index),
      shrinkWrap: true,
      itemCount: itemCount,
    );
  }

  Padding buildPadding(BuildContext context, int index) {
    return Padding(
      padding: context.paddingLowAll,
      child: buildCircleAvatar(index, context),
    );
  }

  CircleAvatar buildCircleAvatar(int index, BuildContext context) {
    return CircleAvatar(
      backgroundColor: isCurrentIndex(index) ? Colors.black54 : Colors.blue,
      radius:
          isCurrentIndex(index) ? context.width * 0.024 : context.width * 0.012,
      child: AnimatedOpacity(
        opacity: opacityValue(index),
        duration: context.durationLow,
        child: onListItem(index),
      ),
    );
  }

  double opacityValue(int index) => isCurrentIndex(index) ? 1 : 0;

  bool isCurrentIndex(int index) => currentIndex == index;
}
