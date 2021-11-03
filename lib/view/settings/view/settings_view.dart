import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../core/base/view/base_view.dart';
import '../../../core/constants/enums/app_theme_enums.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/widget_extension.dart';
import '../../../core/init/lang/language_manager.dart';
import '../../../core/init/lang/locale_keys.g.dart';
import '../../../core/init/notifier/theme_notifier.dart';
import '../../../product/enum/lottie_path_enum.dart';
import '../../../product/extension/lottie_path_extension.dart';
import '../viewmodel/settings_view_model.dart';

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
              body: Padding(
        padding: context.paddingLowAll,
        child: CustomScrollView(
          slivers: [
            buildSliverAppBar(context),
            buildCardUser(context, viewModel).toSliver,
            SizedBox(
              height: 6,
            ).toSliver,
            buildCardHeaderProjectSettings(context, viewModel).toSliver,
            buildCardNavigationTour(viewModel).toSliver,
            SizedBox(
              height: 24,
            ).toSliver,
            // buildAboutProject(context, viewModel).toSliver,
            // SizedBox(
            //   height: 6,
            // ).toSliver,
            buildTextButtonLogout(context, viewModel).toSliver,

            // Card(child: ).toSliver,
          ],
        ),
      )),
    );
  }

  TextButton buildTextButtonLogout(
      BuildContext context, SettingsViewModel viewModel) {
    return TextButton.icon(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(StadiumBorder()),
            padding: MaterialStateProperty.all(context.paddingNormalAll),
            backgroundColor: MaterialStateProperty.all(context.colors.onError)),
        onPressed: viewModel.logoutApp,
        icon: Icon(Icons.exit_to_app),
        label: Text(LocaleKeys.home_setting_exit.tr()));
  }

  Card buildCardNavigationTour(SettingsViewModel viewModel) {
    return Card(
      color: Color(0xffF9EEDF),
      child: TextButton(
        onPressed: () {},
        child: ListTile(
          onTap: viewModel.navigateToOnBoard,
          title: Text(LocaleKeys.home_setting_appTour.tr()),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
      ),
    );
  }

  Widget buildAboutProject(BuildContext context, SettingsViewModel viewModel) {
    return buildCardHeader(context, viewModel,
        title: LocaleKeys.home_setting_about_title.tr(),
        children: [
          ListTile(
            onTap: viewModel.navigateToContribution,
            leading: Icon(Icons.favorite),
            title: Text(LocaleKeys.home_setting_about_contributions.tr()),
            trailing: IconButton(
                icon: Icon(Icons.keyboard_arrow_right),
                onPressed: viewModel.navigateToContribution),
          ),
          ListTile(
            onTap: viewModel.navigateToFakeContribution,
            leading: Icon(Icons.home),
            title: Text(LocaleKeys.home_setting_about_homepage.tr()),
            trailing: IconButton(
                icon: Icon(Icons.keyboard_arrow_right),
                onPressed: viewModel.navigateToFakeContribution),
          ),
        ]);
  }

  Widget buildCardHeaderProjectSettings(
      BuildContext context, SettingsViewModel viewModel) {
    return buildCardHeader(context, viewModel,
        title: LocaleKeys.home_setting_appSettings.tr(),
        children: [
          // ListTile(
          //   tileColor: Color(0xffF9EEDF),
          //   title: Text(LocaleKeys.home_setting_core_themeTitle.tr()),
          //   trailing: IconButton(
          //     icon: context.watch<ThemeNotifier>().currentThemeEnum ==
          //             AppThemes.LIGHT
          //         ? LottiePathEnum.MOON.toWidget
          //         : LottiePathEnum.SUNNY.toWidget,
          //     onPressed: viewModel.changeAppTheme,
          //   ),
          //   subtitle: Text(LocaleKeys.home_setting_core_themeDesc.tr()),
          // ),
          ListTile(
            tileColor: Color(0xffF9EEDF),
            title: Text(LocaleKeys.home_setting_core_langTitle.tr()),
            trailing: Observer(builder: (_) {
              return DropdownButton<Locale>(
                value: viewModel.appLocale,
                onChanged: viewModel.changeAppLocalization,
                items: [
                  DropdownMenuItem(
                    child: Text("TR"),
                    value: LanguageManager.instance.trLocale,
                  ),
                  DropdownMenuItem(
                    child: Text("EN"),
                    value: LanguageManager.instance.enLocale,
                  ),
                ],
              );
            }),
            subtitle: Text(LocaleKeys.home_setting_core_langDesc.tr()),
          )
        ]);
  }

  Widget buildCardHeader(BuildContext context, SettingsViewModel viewModel,
      {required String title, required List<Widget> children}) {
    return Card(
      color: Color(0xffF9EEDF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: context.paddingLowAll,
            child: Text(
              title.tr(),
              style: context.textTheme.headline5,
            ),
          ),
          Divider(),
          ...children
        ],
      ),
    );
  }

  Widget buildCardAbout(BuildContext context, SettingsViewModel viewModel) {
    return buildCardHeader(context, viewModel,
        title: LocaleKeys.home_setting_about_title,
        children: [
          ListTile(
            onTap: viewModel.navigateToContribution,
            leading: Icon(
              Icons.favorite,
            ),
            title: Text(LocaleKeys.home_setting_about_contributions.tr()),
            trailing: Icon(Icons.keyboard_arrow_right_outlined),
          ),
          ListTile(
            onTap: viewModel.navigateToFakeContribution,
            leading: Icon(
              Icons.home,
            ),
            title: Text("Home Page"),
            trailing: Icon(Icons.keyboard_arrow_right_outlined),
          )
        ]);
  }

  Card buildCardUser(BuildContext context, SettingsViewModel viewModel) {
    return Card(
      color: Color(0xffF9EEDF),
      child: Padding(
        padding: context.paddingLowAll,
        child: InkWell(
          onTap: viewModel.navigateToProfile,
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
              Column(
                children: [
                  Text(LocaleKeys.home_setting_userDetails.tr()),
                  IconButton(
                      icon: Icon(Icons.verified_user),
                      onPressed: viewModel.navigateToProfile)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // NestedScrollView buildNestedScrollView() {
  //   return NestedScrollView(
  //     body: Text("Data"),
  //     headerSliverBuilder: (context, innerBoxIsScrolled) {
  //       return [buildSliverAppBar(context)];
  //     },
  //   );
  // }

  SliverAppBar buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      pinned: true,
      backgroundColor: Color(0xffF9EEDF),
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
