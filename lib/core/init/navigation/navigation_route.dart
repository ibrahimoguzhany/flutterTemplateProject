import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../view/authenticate/login/view/login_view.dart';
import '../../../view/authenticate/test/view/test_view.dart';
import '../../../view/home/home_esd/view/home_view.dart';
import '../../../view/planned_tours/planned_tour_detail/view/add_planned_tour_finding_view.dart';
import '../../../view/planned_tours/planned_tour_detail/view/planned_tour_detail_view.dart';
import '../../../view/planned_tours/planned_tours_list/view/planned_tour_list_view.dart';
import '../../../view/profile/view/change_password_view.dart';
import '../../../view/profile/view/profile_view.dart';
import '../../../view/unplanned_tours/add_unplanned_tour/view/add_unplanned_tour_view.dart';
import '../../../view/unplanned_tours/unplanned_tour_detail/view/add_unplanned_tour_finding_view.dart';
import '../../../view/unplanned_tours/unplanned_tour_detail/view/unplanned_tour_detail_view.dart';
import '../../../view/unplanned_tours/unplanned_tours_list/view/unplanned_tour_list_view.dart';
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

      case NavigationConstants.CHANGE_PASSWORD_VIEW:
        return normalNavigate(ChangePasswordView());

      case NavigationConstants.PROFILE_VIEW:
        return normalNavigate(ProfileView());

      case NavigationConstants.ADD_PLANNED_TOUR_FINDING:
        return navigateWithData(AddPlannedTourFindingView(), args.arguments);

      case NavigationConstants.PLANNED_TOUR_LIST_VIEW:
        return normalNavigate(PlannedTourListView());

      case NavigationConstants.PLANNED_TOUR_DETAIL_VIEW:
        return navigateWithData(PlannedTourDetailView(), args.arguments);

      case NavigationConstants.ADD_UNPLANNED_TOUR_VIEW:
        return normalNavigate(AddUnPlannedTourView());

      case NavigationConstants.ADD_UNPLANNED_TOUR_FINDING:
        return navigateWithData(AddUnPlannedTourFindingView(), args.arguments);

      case NavigationConstants.UNPLANNED_TOUR_LIST_VIEW:
        return normalNavigate(UnPlannedTourListView());

      case NavigationConstants.UNPLANNED_TOUR_DETAIL_VIEW:
        return navigateWithData(UnPlannedTourDetailView(), args.arguments);

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
