import 'package:flutter/material.dart';
import 'package:fluttermvvmtemplate/view/profile/view/profile_view.dart';
import 'package:fluttermvvmtemplate/view/tours/planned_tours/view/planned_tours_view.dart';
import 'package:fluttermvvmtemplate/view/tours/unplanned_tours/view/unplanned_tours.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    PlannedToursView(),
    UnPlannedToursView(),
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
          label: 'Planlı Turlar',
      ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mail),
          label: 'Plansız Turlar',
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
      //using YouTube Icon from FontAwesome Icon Packs
      title: Text("Turlar"),
      actions: <Widget>[
        //actions list in appbar
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              //action for this button
            }),

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
