import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/text/auto_locale.text.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../model/unplanned_tour_model.dart';
import '../viewmodel/subview_model/unplanned_tour_detail_view_model.dart';

class UnPlannedTourDetailView extends StatefulWidget {
  UnPlannedTourDetailView({Key? key}) : super(key: key);

  @override
  _UnPlannedTourDetailViewState createState() =>
      _UnPlannedTourDetailViewState();
}

class _UnPlannedTourDetailViewState extends State<UnPlannedTourDetailView> {
  @override
  Widget build(BuildContext context) {
    UnplannedTourModel tour =
        ModalRoute.of(context)!.settings.arguments as UnplannedTourModel;
    print(tour.tourTeamMemberUsers);
    // print(tour.tourAccompaniers);

    return BaseView<UnPlannedTourDetailViewModel>(
      viewModel: UnPlannedTourDetailViewModel(),
      onModelReady: (UnPlannedTourDetailViewModel model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder:
          (BuildContext context, UnPlannedTourDetailViewModel viewModel) =>
              Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async =>
              await viewModel.navigateToAddUnplannedTourFinding(tour),
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text(LocaleKeys.unplanned_tours_detail_appBarTitle.tr()),
          actions: [
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
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: buildHorizontalChips(tour.findings, viewModel, tour.id!),
            ),
            Observer(builder: (_) {
              return Expanded(
                flex: 12,
                child: buildExpandedTourDetails(tour),
              );
            }),
          ],
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
        if (findings[index].id == null)
          return Text(LocaleKeys.planned_tours_finding_noFinding.tr());
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: InkWell(
              onTap: () async =>
                  await viewModel.navigateToFindingDetail(findings[index]),
              child: Chip(
                labelPadding: EdgeInsets.symmetric(horizontal: 10),
                label: Text(
                  "Bulgu ID: $index",
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

  Padding buildExpandedTourDetails(UnplannedTourModel? tour) {
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
              buildBiggerDataTextWidget(tour.fieldOrganizationOrderScore == null
                  ? "-"
                  : tour.fieldOrganizationOrderScore.toString()),
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
}

buildBiggerDataTextWidget(dynamic data) {
  var finalResult = "";
  if (data is List) {
    data.forEach((dynamic element) {
      finalResult += element['name'] + ", ";
    });
  }

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: AutoLocaleText(
      value: data is List ? finalResult : data,
      style: TextStyle(
        fontSize: 18,
      ),
    ),
  );
}

Widget buildLittleTextWidget(String title) {
  if (title.isEmpty) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  return AutoLocaleText(
    value: title,
    style: TextStyle(
        fontSize: 10,
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.w800),
  );
}
