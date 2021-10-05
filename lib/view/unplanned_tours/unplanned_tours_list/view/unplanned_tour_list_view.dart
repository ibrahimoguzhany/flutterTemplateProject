import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:esd_mobil/view/unplanned_tours/model/unplanned_tour_model.dart';
import 'package:esd_mobil/view/unplanned_tours/service/unplanned_tour_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:esd_mobil/core/init/lang/locale_keys.g.dart';
import 'package:esd_mobil/view/_product/_constants/image_path_svg.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/constants/navigation/navigation_constants.dart';
import '../../../../core/init/navigation/navigation_service.dart';
import '../../unplanned_tour_detail/view/unplanned_tour_detail_view.dart';
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
                  floatingActionButton: FloatingActionButton(
                    onPressed: () async {
                      await UnPlannedTourService.instance!.getUnplannedTours();
                      NavigationService.instance.navigateToPage(
                          NavigationConstants.ADD_UNPLANNED_TOUR_VIEW);
                    },
                    child: Icon(Icons.add),
                  ),
                  body: FutureBuilder(
                    future: viewModel.getUnplannedTours(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError)
                        return Text("Error = ${snapshot.error}");

                      if (snapshot.hasData) {
                        print(snapshot.data);
                        final tours = snapshot.data;
                        return buildListView(tours);
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  )),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(LocaleKeys.home_bottom_app_bar_tabs_unplanned_tours.tr()),
    );
  }

  SvgPicture buildSvgPicture(String path) => SvgPicture.asset(path);
  Widget buildListView(dynamic docs) {
    if (docs.isEmpty) {
      return Column(
        children: [
          Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.only(top: 32.0, left: 32, right: 32),
                child:
                    buildSvgPicture(SVGImagePaths.instance!.real_time_sync_SVG),
              )),
          Expanded(
            flex: 2,
            child: Text(
              LocaleKeys.unplanned_tours_list_noData.tr(),
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    }
    return ListView.separated(
      padding: EdgeInsets.all(8),
      separatorBuilder: (context, index) => Divider(
        color: Colors.black26,
      ),
      itemCount: docs.length,
      itemBuilder: (context, index) {
        return buildListTile(docs[index], index);
      },
    );
  }

  ListTile buildListTile(UnplannedTourModel data, int index) {
    return ListTile(
      enableFeedback: true,
      contentPadding: EdgeInsets.all(8.0),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UnPlannedTourDetailView(
              tour: data,
            ),
          ),
        );
      },
      selectedTileColor: Colors.black12,
      hoverColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      leading: Text(
        data.locationName!,
        style: TextStyle(fontSize: 16),
      ),
      subtitle: Text(
        data.id.toString(),
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 14),
      ),
      title: Text(
        data.fieldName!,
        style: TextStyle(fontSize: 14),
      ),
      trailing: Text(
        data.tourDate!,
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}
