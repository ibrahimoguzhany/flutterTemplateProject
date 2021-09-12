import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttermvvmtemplate/core/components/column/form_column.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../_widgets/listview/on_board_indicator.dart';
import '../viewmodel/on_board_view_model.dart';

class OnBoardView extends StatefulWidget {
  const OnBoardView({Key? key}) : super(key: key);

  @override
  OnBoardViewState createState() => OnBoardViewState();
}

class OnBoardViewState extends State<OnBoardView> {
  late OnBoardViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<OnBoardViewModel>(
      viewModel: OnBoardViewModel(),
      onModelReady: (OnBoardViewModel model) {
        model.setContext(context);
        model.init();
        viewModel = model;
      },
      onPageBuilder: (BuildContext context, OnBoardViewModel value) => Scaffold(
        body: buildColumnBody(),
      ),
    );
  }

  Column buildColumnBody() {
    return Column(
      children: [
        Expanded(
          flex: 9,
          child: buildPageView(),
        ),
        Expanded(child: buildObserverIndicator())
      ],
    );
  }

  PageView buildPageView() {
    return PageView.builder(
      onPageChanged: (val) {
        viewModel.onPageChanged(val);
      },
      itemCount: viewModel.onBoardModel.length,
      itemBuilder: (context, index) => Container(
        color: context.randomColor,
        child: FormColumn(
          children: [Placeholder(), Text(viewModel.onBoardModel[index].text)],
        ),
      ),
    );
  }

  Observer buildObserverIndicator() {
    return Observer(builder: (_) {
      return OnBoardIndicator(
        itemCount: viewModel.onBoardModel.length,
        currentIndex: viewModel.currentPageIndex,
      );
    });
  }
}
