import 'package:easy_localization/easy_localization.dart';
import 'package:esd_mobil/view/unplanned_tours/unplanned_tour_detail/viewmodel/unplanned_tour_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../_product/_constants/image_path_svg.dart';
import '../../model/unplanned_tour_model.dart';
import '../viewmodel/unplanned_tour_list_view_model.dart';

class UnPlannedTourListView extends StatefulWidget {
  @override
  _UnPlannedTourListViewState createState() => _UnPlannedTourListViewState();
}

class _UnPlannedTourListViewState extends State<UnPlannedTourListView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<UnPlannedTourListViewModel>(
      viewModel: UnPlannedTourListViewModel(),
      onModelReady: (UnPlannedTourListViewModel model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder:
          (BuildContext context, UnPlannedTourListViewModel viewModel) =>
              Scaffold(
                  appBar: buildAppBar(context),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.miniEndFloat,
                  floatingActionButton: FloatingActionButton(
                    onPressed: viewModel.navigateToAddUnplannedTourView,
                    child: Icon(Icons.add),
                  ),
                  body: FutureBuilder(
                    future: viewModel.getUnplannedTours(),
                    builder: (context,
                        AsyncSnapshot<List<UnplannedTourModel>?> snapshot) {
                      if (snapshot.hasError)
                        return Text("Error = ${snapshot.error}");

                      if (snapshot.hasData) {
                        // print(snapshot.data);
                        final List<UnplannedTourModel>? tours = snapshot.data;
                        return buildListView(tours!, viewModel);
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  )),
    );
  }

  Widget buildListView(
      List<UnplannedTourModel> tours, UnPlannedTourListViewModel viewModel) {
    if (tours.isEmpty) {
      return buildNoDataColumn();
    }
    return buildListViewSeperated(tours, viewModel);
  }

  ListView buildListViewSeperated(
      List<UnplannedTourModel> tours, UnPlannedTourListViewModel viewModel) {
    return ListView.separated(
      padding: EdgeInsets.all(8),
      separatorBuilder: (context, index) => Divider(
        color: Colors.black26,
      ),
      itemCount: tours.length,
      itemBuilder: (context, index) {
        return buildListTile(tours[index], viewModel);
      },
    );
  }

  ListTile buildListTile(
      UnplannedTourModel tour, UnPlannedTourListViewModel viewModel) {
    return ListTile(
      enableFeedback: true,
      contentPadding: EdgeInsets.all(8.0),
      onTap: () async =>
          await viewModel.navigateToUnplannedTourDetailView(tour),
      selectedTileColor: Colors.black12,
      hoverColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      leading: Text(
        tour.locationName!,
        style: TextStyle(fontSize: 16),
      ),
      subtitle: Text(
        tour.id.toString(),
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 14),
      ),
      title: Text(
        tour.fieldName!,
        style: TextStyle(fontSize: 14),
      ),
      trailing: Text(
        tour.tourDate!,
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(LocaleKeys.home_bottom_app_bar_tabs_unplanned_tours.tr()),
    );
  }

  SvgPicture buildSvgPicture(String path) => SvgPicture.asset(path);

  Column buildNoDataColumn() {
    return Column(
      children: [
        buildEmptyDataSVG(),
        buildNoDataText(),
      ],
    );
  }

  Expanded buildNoDataText() {
    return Expanded(
      flex: 2,
      child: Text(
        LocaleKeys.unplanned_tours_list_noData.tr(),
        style: TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }

  Expanded buildEmptyDataSVG() {
    return Expanded(
        flex: 6,
        child: Padding(
          padding: const EdgeInsets.only(top: 32.0, left: 32, right: 32),
          child: buildSvgPicture(SVGImagePaths.instance!.real_time_sync_SVG),
        ));
  }
}
