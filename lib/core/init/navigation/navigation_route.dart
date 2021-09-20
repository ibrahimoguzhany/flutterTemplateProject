import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttermvvmtemplate/view/authenticate/login/view/login_view.dart';
import 'package:fluttermvvmtemplate/view/home/home_esd/view/home_view.dart';
import 'package:fluttermvvmtemplate/view/planned_tours/add_planned_tour/view/add_planned_tour_view.dart';
import 'package:fluttermvvmtemplate/view/planned_tours/planned_tour_detail/view/add_planned_tour_finding_view.dart';
import 'package:fluttermvvmtemplate/view/planned_tours/planned_tour_detail/view/planned_tour_detail_view.dart';
import 'package:fluttermvvmtemplate/view/planned_tours/planned_tours_list/view/planned_tour_list_view.dart';

import '../../../view/authenticate/test/view/test_view.dart';
import '../../components/card/not_found_navigation_widget.dart';
import '../../constants/navigation/navigation_constants.dart';

class NavigationRoute {
  static NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.TEST_VIEW:
        return normalNavigate(TestView());
      case NavigationConstants.HOME_VIEW:
        return normalNavigate(HomeView());
      case NavigationConstants.LOGIN_VIEW:
        return normalNavigate(LoginView());
      case NavigationConstants.ADD_PLANNED_TOUR_VIEW:
        return normalNavigate(AddPlannedTourView());
      case NavigationConstants.ADD_PLANNED_TOUR_FINDING:
        return normalNavigate(AddPlannedTourFindingView());
      case NavigationConstants.PLANNED_TOUR_LIST_VIEW:
        return normalNavigate(PlannedTourListView());

      case NavigationConstants.PLANNED_TOUR_DETAIL_VIEW:
        return navigateWithData(PlannedTourDetailView(), args.arguments);

      default:
        return MaterialPageRoute(
          builder: (context) => NotFoundNavigationWidget(),
        );
    }
  }

  MaterialPageRoute normalNavigate(Widget widget) {
    return MaterialPageRoute(
      builder: (context) => widget,
    );
  }

  MaterialPageRoute navigateWithData(Widget widget, dynamic data) {
    return MaterialPageRoute(
        builder: (context) => widget, settings: RouteSettings(arguments: data));
  }
}
