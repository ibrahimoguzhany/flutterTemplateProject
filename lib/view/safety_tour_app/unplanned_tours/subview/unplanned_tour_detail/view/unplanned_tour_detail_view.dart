import 'package:easy_localization/easy_localization.dart';
import 'package:esd_mobil/core/base/view/base_view.dart';
import 'package:esd_mobil/core/constants/navigation/navigation_constants.dart';
import 'package:esd_mobil/core/extensions/context_extension.dart';
import 'package:esd_mobil/core/init/lang/locale_keys.g.dart';
import 'package:esd_mobil/core/init/navigation/navigation_service.dart';
import 'package:esd_mobil/view/common/_product/_widgets/big_little_text_widget.dart';
import 'package:esd_mobil/view/safety_tour_app/unplanned_tours/subview/unplanned_tour_detail/viewmodel/subview_model/unplanned_tour_detail_view_model/unplanned_tour_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../model/unplanned_tour_model.dart';
import '../service/unplanned_tour_detail_service.dart';

class UnPlannedTourDetailView extends StatefulWidget {
  UnPlannedTourDetailView({Key? key}) : super(key: key);

  @override
  _UnPlannedTourDetailViewState createState() =>
      _UnPlannedTourDetailViewState();
}

class _UnPlannedTourDetailViewState extends State<UnPlannedTourDetailView>
    with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    RouteObserverCall.routeObserver
        .subscribe(this, ModalRoute.of(context) as PageRoute<dynamic>);
  }

  @override
  void dispose() {
    RouteObserverCall.routeObserver.unsubscribe(this);
    super.dispose();
  }

  void didPopNext() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    UnplannedTourModel tour =
        ModalRoute.of(context)!.settings.arguments as UnplannedTourModel;

    return BaseView<UnPlannedTourDetailViewModel>(
      viewModel: UnPlannedTourDetailViewModel(),
      onModelReady: (UnPlannedTourDetailViewModel model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder:
          (BuildContext context, UnPlannedTourDetailViewModel viewModel) =>
              Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add_outlined),
          elevation: 5,
          onPressed: () async =>
              await viewModel.navigateToAddUnplannedTourFinding(tour),
          label: Text("Bulgu Ekle"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        appBar: AppBar(
          leading: NavigationService.instance.navigatorKey.currentState!
                  .canPop()
              ? IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => NavigationService.instance
                      .navigateToPageClear(NavigationConstants.TOURS_HOME_VIEW))
              : null,
          title: Text(LocaleKeys.unplanned_tours_detail_appBarTitle.tr()),
          actions: [
            IconButton(
              onPressed: () async => await viewModel
                  .showDialogFinalizeTourCreation(context, tour.id!),
              icon: Icon(Icons.save_outlined),
            ),
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () async =>
                    await viewModel.navigateToEditUnplannedTour(tour)),
            IconButton(
              onPressed: () async =>
                  await viewModel.showDialogDeleteTour(context, tour.id!),
              icon: Icon(Icons.delete_forever_rounded),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Expanded(
              //   child: buildHorizontalChips(tour.findings, viewModel, tour.id!),
              // ),
              Expanded(
                child: FutureBuilder(
                    future: UnPlannedTourDetailService.instance!
                        .getFindings(tour.id!),
                    builder:
                        (context, AsyncSnapshot<List<FindingModel>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        return buildHorizontalChips(
                            snapshot.data, viewModel, tour.id!);
                      }
                      // if (snapshot.hasData) {
                      //   return buildHorizontalChips(
                      //       snapshot.data, viewModel, tour.id!);
                      // } else if (snapshot.hasError) {
                      //   return Text(snapshot.error.toString());
                      // }

                      // return Center(
                      //   child: CircularProgressIndicator(),
                      // );
                    }),
              ),
              Observer(builder: (_) {
                return Expanded(
                  flex: 12,
                  child: buildExpandedTourDetails(tour, context),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHorizontalChips(List<FindingModel>? findings,
      UnPlannedTourDetailViewModel viewModel, int tourId) {
    if (findings == null || findings.isEmpty) {
      return Center(
          child: Text(
        LocaleKeys.planned_tours_finding_noFinding.tr(),
        style: TextStyle(
            fontFamily: "Poppins", fontSize: 14, fontWeight: FontWeight.w400),
      ));
    }

    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: findings.length,
      padding: EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (BuildContext context, int index) {
        findings[index].tourId = tourId;
        if (findings[index].id == null)
          return Text(LocaleKeys.planned_tours_finding_noFinding.tr());
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: InkWell(
              onTap: () async {
                await viewModel.navigateToFindingDetail(findings[index]);
                // await Navigator.of(context).push(MaterialPageRoute(
                //     builder: (_) => UnplannedTourFindingDetailView(),
                //     settings: RouteSettings(arguments: findings[index])));
              },
              child: Chip(
                labelPadding: EdgeInsets.symmetric(horizontal: 10),
                label: Text(
                  "Bulgu $index",
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                      fontSize: 15),
                ),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 3,
                shadowColor: Colors.grey[60],
                padding: EdgeInsets.all(8.0),
              )),
        );
      },
    );
  }
}

Padding buildExpandedTourDetails(
    UnplannedTourModel? tour, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: ListView(
      shrinkWrap: true,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLittleTextWidget("Tur ID"),
            buildBiggerDataTextWidget(tour!.id.toString()),
            buildLittleTextWidget("Lokasyon"),
            buildBiggerDataTextWidget(tour.locationName),
            SizedBox(height: 10),
            buildLittleTextWidget("Saha"),
            buildBiggerDataTextWidget(tour.fieldName),
            SizedBox(height: 10),
            buildLittleTextWidget("Ekip Üyeleri"),
            buildBiggerDataTextWidget(
                tour.tourTeamMembers == null ? "-" : tour.tourTeamMembers),
            SizedBox(height: 10),
            buildLittleTextWidget("Tura Eşlik Edenler"),
            buildBiggerDataTextWidget(
                tour.tourAccompaniers == null ? "-" : tour.tourAccompaniers),
            SizedBox(height: 10),
            buildLittleTextWidget("Tur Tarihi"),
            buildBiggerDataTextWidget(tour.tourDate.toString()),
            SizedBox(height: 10),
            buildLittleTextWidget("Saha Organinasyon Skoru"),
            tour.fieldOrganizationOrderScore == null
                ? Container()
                : Slider(
                    divisions: 10,
                    label: "${tour.fieldOrganizationOrderScore}",
                    activeColor: context.colors.secondary,
                    min: 0,
                    max: 10,
                    value: tour.fieldOrganizationOrderScore!.toDouble(),
                    onChanged: (double value) {},
                  ),
            // buildBiggerDataTextWidget(tour.fieldOrganizationOrderScore == null
            //     ? "-"
            //     : tour.fieldOrganizationOrderScore.toString()),
            SizedBox(height: 10),
            buildLittleTextWidget("Gözlenen Pozitif Bulgular"),
            buildBiggerDataTextWidget(
                tour.observatedSecureCasesPositiveFindings),
            SizedBox(height: 10),
          ],
        ),
      ],
    ),
  );
}

BottomNavigationBar get buildBottomNavBar => BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Planlı Turlar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Plansız Turlar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Profil',
        ),
      ],
    );
