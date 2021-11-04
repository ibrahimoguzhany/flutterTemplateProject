import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/navigation/navigation_constants.dart';
import '../../../../core/init/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
      onPageBuilder: (BuildContext context,
              UnPlannedTourListViewModel viewModel) =>
          Scaffold(
              appBar: buildAppBar(context),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.miniEndFloat,
              floatingActionButton: FloatingActionButton.extended(
                icon: Icon(Icons.add_outlined),
                elevation: 10,
                onPressed: viewModel.navigateToAddUnplannedTourView,
                label: Text("Tur Oluştur"),
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  await NavigationService.instance
                      .navigateToPageClear(NavigationConstants.TOURS_HOME_VIEW);
                },
                child: Observer(builder: (_) {
                  return FutureBuilder(
                    future: viewModel.getUnplannedTours(),
                    builder: (context,
                        AsyncSnapshot<List<UnplannedTourModel>?> snapshot) {
                      if (snapshot.hasError)
                        return Text("Error = ${snapshot.error}");

                      if (snapshot.hasData) {
                        print(snapshot.data);
                        // final List<UnplannedTourModel>? tours = snapshot.data;
                        return buildListView(snapshot.data!, viewModel);
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                }),
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
          // color: Colors.black26,
          ),
      itemCount: tours.length,
      itemBuilder: (context, index) {
        return buildListTile(tours[index], viewModel);
      },
    );
  }

  Widget buildListTile(
      UnplannedTourModel tour, UnPlannedTourListViewModel viewModel) {
    var formattedTourDate =
        DateFormat('dd-mm-yyyy - kk:mm').format(tour.tourDate!);
    return Card(
      color: Color(0xffFF6333).withOpacity(0.75),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: const BoxDecoration(
                border: const Border(
                    right:
                        const BorderSide(width: 1.0, color: Colors.white24))),
            child: CircleAvatar(
              child: Text(tour.id.toString()),
              backgroundColor: Color.fromRGBO(64, 75, 96, .5),
            ),
          ),
          title: Text(
            "Tarih: " + formattedTourDate,
            textAlign: TextAlign.start,
          ),
          subtitle: Row(
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(tour.locationName!),
                  )),
              Expanded(
                flex: 2,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      tour.fieldName!,
                    )),
              )
            ],
          ),
          trailing: Icon(Icons.keyboard_arrow_right,
              color: Colors.white70, size: 30.0),
          onTap: () async {
            await viewModel.navigateToUnplannedTourDetailView(tour);
          },
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        LocaleKeys.home_bottom_app_bar_tabs_unplanned_tours.tr(),
        style: TextStyle(color: Color(0xFF31201B)),
      ),
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
