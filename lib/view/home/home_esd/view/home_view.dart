import 'package:flutter/material.dart';
import 'package:fluttermvvmtemplate/view/planned_tours/planned_tours_list/view/planned_tour_list_view.dart';
import 'package:fluttermvvmtemplate/view/profile/view/profile_view.dart';
import 'package:fluttermvvmtemplate/view/unplanned_tours/unplanned_tour_list/view/unplanned_tour_list_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    PlannedTourListView(),
    UnPlannedTourListView(),
    ProfileView(),
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
          icon: Icon(Icons.home),
          label: 'Plansız Turlar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mail),
          label: 'Planlı Turlar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
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
