import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/base/state/base_state.dart';
import '../../../../core/base/view/base_view.dart';
import '../../../../core/constants/enums/preferences_keys_enum.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../core/init/cache/locale_manager.dart';
import '../../../../core/init/lang/language_manager.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../viewmodel/test_viewmodel.dart';

class TestView extends StatefulWidget {
  TestView({Key? key}) : super(key: key);

  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends BaseState<TestView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<TestViewModel>(
      viewModel: TestViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, TestViewModel value) =>
          scaffoldBody(value),
    );
  }

  Widget scaffoldBody(TestViewModel value) => Scaffold(
        appBar: appBar(),
        floatingActionButton: floatingActionButtonNumberIncrement(value),
        body: textNumber(value),
      );

  AppBar appBar() {
    return AppBar(
      leading: Text(
        LocaleManager.instance.getStringValue(PreferencesKeys.TOKEN)!,
      ),
      title: textWelcomeWidget(),
      actions: [
        iconButtonChangeTheme(),
        IconButton(
            onPressed: () {
              LocaleManager.instance
                  .setStringValue(PreferencesKeys.TOKEN, "4321");
            },
            icon: Icon(Icons.settings))
      ],
    );
  }

  IconButton iconButtonChangeTheme() {
    return IconButton(
      icon: Icon(Icons.change_history),
      onPressed: () {
        context.setLocale(LanguageManager.instance.enLocale);
      },
    );
  }

  Widget textNumber(TestViewModel viewModel) {
    return Column(
      children: <Widget>[
        Observer(
          builder: (context) => Text(
            viewModel.number.toString(),
          ),
        ),
      ],
    );
  }

  Text textWelcomeWidget() => Text(LocaleKeys.welcome.locale!);

  FloatingActionButton floatingActionButtonNumberIncrement(
          TestViewModel viewModel) =>
      FloatingActionButton(
        onPressed: () => viewModel.incrementNumber(),
      );
}

extension _FormArea on _TestViewState {
  TextFormField get mailField => TextFormField(
        validator: (val) => val.isValidEmail,
      );
}
