import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:esd_mobil/view/settings/view/settings_view.dart';

import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../planned_tours/planned_tours_list/view/planned_tour_list_view.dart';
import '../../../unplanned_tours/unplanned_tours_list/view/unplanned_tour_list_view.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    PlannedTourListView(),
    UnPlannedTourListView(),
    SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: buildAppBar,
        body: _children[_currentIndex],
        bottomNavigationBar: buildBottomNavBar);
  }

  BottomNavigationBar get buildBottomNavBar {
    return BottomNavigationBar(
      onTap: onTabTapped,
      currentIndex: _currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt),
          label: LocaleKeys.home_bottom_app_bar_tabs_planned_tours.tr(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: LocaleKeys.home_bottom_app_bar_tabs_unplanned_tours.tr(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: LocaleKeys.home_bottom_app_bar_tabs_settings.tr(),
        )
      ],
    );
  }

  AppBar get buildAppBar {
    return AppBar(
      backgroundColor: Colors.blue,
      leading: Icon(Icons.work),
      title: Text("Turlar"),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.search), onPressed: () {}),

        //actions list in appbar
        IconButton(icon: const Icon(Icons.logout), onPressed: () {}),
      ],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
