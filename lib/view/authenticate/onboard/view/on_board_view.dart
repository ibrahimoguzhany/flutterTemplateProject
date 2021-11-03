import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../_widgets/avatar/on_board_circle.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/text/auto_locale.text.dart';
import '../../../../core/extensions/context_extension.dart';
import '../model/on_board_model.dart';
import '../viewmodel/on_board_view_model.dart';

class OnBoardView extends StatelessWidget {
  const OnBoardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseView<OnBoardViewModel>(
      viewModel: OnBoardViewModel(),
      onModelReady: (OnBoardViewModel model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, OnBoardViewModel viewModel) =>
          Scaffold(
        body: Padding(
          padding: context.paddingNormalHorizontal,
          child: Column(
            children: [
              Spacer(
                flex: 2,
              ),
              Expanded(
                flex: 5,
                child: buildPageView(viewModel),
              ),
              Expanded(flex: 2, child: buildRowFooter(viewModel, context)),
            ],
          ),
        ),
      ),
    );
  }

  PageView buildPageView(OnBoardViewModel viewModel) {
    return PageView.builder(
        itemCount: viewModel.onBoardItems.length,
        onPageChanged: (val) {
          viewModel.changeCurrentIndex(val);
        },
        itemBuilder: (context, index) =>
            buildColumnBody(context, viewModel.onBoardItems[index]));
  }

  Row buildRowFooter(OnBoardViewModel viewModel, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildListViewCircles(viewModel),
        Expanded(
          child: Center(child: Observer(builder: (_) {
            return Visibility(
              child: CircularProgressIndicator(),
              visible: viewModel.isLoading,
            );
          })),
        ),
        buildSkipButton(context, viewModel)
      ],
    );
  }

  ListView buildListViewCircles(OnBoardViewModel viewModel) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: context.paddingLowAll,
            child: Observer(builder: (_) {
              return OnBoardCircle(
                isSelected: viewModel.currentIndex == index,
                currentIndex: viewModel.currentIndex,
              );
            }),
          );
        });
  }

  FloatingActionButton buildSkipButton(
      BuildContext context, OnBoardViewModel viewModel) {
    return FloatingActionButton(
      onPressed: () {
        viewModel.completeToOnBoard();
      },
      child: Icon(
        Icons.arrow_right_alt,
        color: context.colors.primaryVariant,
      ),
    );
  }

  Column buildColumnBody(BuildContext context, OnBoardModel model) {
    return Column(
      children: [
        Expanded(flex: 5, child: buildSvgPicture(model.imagePath)),
        buildColumnDescription(context, model),
      ],
    );
  }

  Column buildColumnDescription(BuildContext context, OnBoardModel model) {
    return Column(
      children: [
        buildLocaleTextTitle(model, context),
        Padding(
          padding: context.paddingMediumVHorizontal,
          child: buildLocaleTextDescription(model, context),
        ),
      ],
    );
  }

  AutoLocaleText buildLocaleTextTitle(
      OnBoardModel model, BuildContext context) {
    return AutoLocaleText(
      value: model.title,
      style: Theme.of(context).textTheme.headline3!.copyWith(
          fontWeight: FontWeight.bold, color: context.colors.onSecondary),
    );
  }

  AutoLocaleText buildLocaleTextDescription(
      OnBoardModel model, BuildContext context) {
    return AutoLocaleText(
      value: model.description,
      style: Theme.of(context).textTheme.subtitle1!.copyWith(
            fontWeight: FontWeight.w100,
          ),
      textAlign: TextAlign.center,
    );
  }

  SvgPicture buildSvgPicture(String path) => SvgPicture.asset(path);
}
