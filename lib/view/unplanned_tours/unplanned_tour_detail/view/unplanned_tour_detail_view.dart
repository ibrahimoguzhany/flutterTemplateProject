import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/text/auto_locale.text.dart';
import '../../../../core/constants/navigation/navigation_constants.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/init/navigation/navigation_service.dart';
import '../../edit_unplanned_tour/view/edit_unplanned_tour_view.dart';
import '../../model/unplanned_tour_model.dart';
import '../viewmodel/unplanned_tour_detail_view_model.dart';
import 'add_unplanned_tour_finding_view.dart';
import 'finding_detail.dart';

class UnPlannedTourDetailView extends StatefulWidget {
  final UnplannedTourModel? tour;
  UnPlannedTourDetailView({Key? key, this.tour}) : super(key: key);

  @override
  _UnPlannedTourDetailViewState createState() =>
      _UnPlannedTourDetailViewState();
}

class _UnPlannedTourDetailViewState extends State<UnPlannedTourDetailView> {
  @override
  Widget build(BuildContext context) {
    // final findingSnapshots = UnPlannedTourDetailService.instance
    //     ?.getFindingsSnapshots(context, widget.tour!.key!);

    // final selectedTour = UnPlannedTourDetailService.instance
    //     ?.getSelectedTour(context, widget.tour!.key!);

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
          onPressed: () {
            // NavigationService.instance.navigateToPage(
            //     NavigationConstants.ADD_UNPLANNED_TOUR_FINDING,
            //     data: widget.tour);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddUnPlannedTourFindingView(tour: widget.tour!)));
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text(LocaleKeys.unplanned_tours_detail_appBarTitle.tr()),
          actions: [
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditUnPlannedTourView(tour: widget.tour!),
                    ),
                  );
                }),
            IconButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text("Plansız Tur Sil"),
                          content: Text(
                              "Plansız Turu silmek istediğinize emin misiniz?"),
                          actions: [
                            TextButton(
                                child: Text("Evet"),
                                onPressed: () async {
                                  // await selectedTour
                                  //     .collection("findings")
                                  //     .get()
                                  //     .then((snapshot) {
                                  //   for (DocumentSnapshot ds in snapshot.docs) {
                                  //     ds.reference.delete();
                                  //   }
                                  // });
                                  // await selectedTour.delete();
                                  // Navigator.pop(context);
                                  // Navigator.pop(context);
                                  // final snackBar = SnackBar(
                                  //   content:
                                  //       Text("Plansız Tur Başarıyla Silindi."),
                                  //   backgroundColor: Colors.blueGrey.shade700,
                                  // );
                                  // ScaffoldMessenger.of(context)
                                  //     .showSnackBar(snackBar);
                                }),
                            TextButton(
                                child: Text("Hayır"),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ],
                        ));
              },
              icon: Icon(Icons.delete_forever_rounded),
            ),
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
                child: buildHorizontalChips(widget.tour?.findings, viewModel)

                // Observer(builder: (_) {
                //   return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                //     stream: findingSnapshots,
                //     builder: (context, snapshot) {
                //       if (snapshot.hasError)
                //         return Text('Error = ${snapshot.error}');

                //       if (snapshot.hasData) {
                //         final docs = snapshot.data!.docs;

                //         return buildHorizontalChips(
                //             docs, viewModel, widget.tour!.key!);
                //       }

                //       return Center(child: CircularProgressIndicator());
                //     },
                //   );
                // }),
                ),
            // Text(
            //   LocaleKeys.unplanned_tours_detail_details.tr(),
            //   style: TextStyle(fontSize: 18),
            // ),
            Observer(builder: (_) {
              return Expanded(
                flex: 12,
                child: buildExpandedTourDetails(widget.tour),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget buildHorizontalChips(
      List<FindingModel>? findings, UnPlannedTourDetailViewModel viewModel) {
    if (findings!.isEmpty) {
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
        // final findingId = docs[index].reference.id;
        // data['key'] = findingId;
        if (findings[index] == null)
          return Text(LocaleKeys.planned_tours_finding_noFinding.tr());
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: GestureDetector(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FindingDetailView(
                        finding: findings[index], findingNumber: index),
                  ),
                );
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
                  tour.tourTeamMembers!.isEmpty ? "-" : tour.tourTeamMembers),
              SizedBox(height: 10),
              buildLittleTextWidget("Tura Eşlik Edenler"),
              buildBiggerDataTextWidget(
                  tour.tourAccompaniers!.isEmpty ? "-" : tour.tourAccompaniers),
              SizedBox(height: 10),
              buildLittleTextWidget("Tur Tarihi"),
              buildBiggerDataTextWidget(tour.tourDate),
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

  BottomNavigationBar buildBottomNavBar() {
    return BottomNavigationBar(
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
    if (title == null) {
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
}
