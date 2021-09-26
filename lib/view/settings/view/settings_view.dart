import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttermvvmtemplate/core/base/view/base_view.dart';
import 'package:fluttermvvmtemplate/core/extensions/context_extension.dart';
import 'package:fluttermvvmtemplate/core/extensions/widget_extension.dart';
import 'package:fluttermvvmtemplate/core/init/lang/locale_keys.g.dart';
import 'package:fluttermvvmtemplate/view/settings/viewmodel/settings_view_model.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<SettingsViewModel>(
      viewModel: SettingsViewModel(),
      onModelReady: (SettingsViewModel model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, SettingsViewModel viewModel) =>
          Scaffold(
              body: CustomScrollView(
        slivers: [
          buildSliverAppBar(context),
          buildCardUser(context, viewModel).toSliver,
          SizedBox(
            height: 2,
          ).toSliver,
          Card(
            child: Column(
              children: [
                Text(
                  "About Project",
                  style: context.textTheme.headline5,
                ),
                Divider(),
                ListTile(
                  onTap: viewModel.navigateToContibution,
                  leading: Icon(
                    Icons.favorite,
                  ),
                  title: Text("Project Contributors"),
                  trailing: Icon(Icons.keyboard_arrow_right_outlined),
                )
              ],
            ),
          ).toSliver
        ],
      )),
    );
  }

  Card buildCardUser(BuildContext context, SettingsViewModel viewModel) {
    return Card(
      child: Padding(
        padding: context.paddingLowAll,
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              child: Text(viewModel.userModel.shortName),
            ),
            Spacer(),
            Text(viewModel.userModel.fullName),
            Spacer(
              flex: 5,
            ),
          ],
        ),
      ),
    );
  }

  NestedScrollView buildNestedScrollView() {
    return NestedScrollView(
      body: Text("Data"),
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [buildSliverAppBar(context)];
      },
    );
  }

  SliverAppBar buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      pinned: true,
      backgroundColor: context.colors.background,
      expandedHeight: 100,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          LocaleKeys.home_setting_title.tr(),
          style: context.textTheme.headline5,
        ),
      ),
    );
  }
}
