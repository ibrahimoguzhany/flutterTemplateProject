import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttermvvmtemplate/view/unplanned_tours/add_unplanned_tour/model/unplanned_tour_model.dart';
import 'package:fluttermvvmtemplate/view/unplanned_tours/edit_unplanned_tour/view/edit_unplanned_tour_view.dart';
import 'package:fluttermvvmtemplate/view/unplanned_tours/unplanned_tour_detail/service/unplanned_tour_detail_service.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/text/auto_locale.text.dart';
import '../../../../core/constants/navigation/navigation_constants.dart';
import '../../../../core/init/navigation/navigation_service.dart';
import '../../../home/home_esd/model/finding_model.dart';
import '../viewmodel/unplanned_tour_detail_view_model.dart';
import 'finding_detail.dart';

class UnPlannedTourDetailView extends StatefulWidget {
  final UnPlannedTourModel? tour;
  UnPlannedTourDetailView({Key? key, this.tour}) : super(key: key);

  @override
  _UnPlannedTourDetailViewState createState() =>
      _UnPlannedTourDetailViewState();
}

class _UnPlannedTourDetailViewState extends State<UnPlannedTourDetailView> {
  @override
  Widget build(BuildContext context) {
    final findingSnapshots = UnPlannedTourDetailService.instance
        ?.getFindingsSnapshots(context, widget.tour!.key);

    final selectedTour = UnPlannedTourDetailService.instance
        ?.getSelectedTour(context, widget.tour!.key);

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
            NavigationService.instance.navigateToPage(
                NavigationConstants.ADD_UNPLANNED_TOUR_FINDING,
                data: widget.tour);
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text("Plansız Tur Detay"),
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
                                  await selectedTour
                                      .collection("findings")
                                      .get()
                                      .then((snapshot) {
                                    for (DocumentSnapshot ds in snapshot.docs) {
                                      ds.reference.delete();
                                    }
                                  });
                                  await selectedTour.delete();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  final snackBar = SnackBar(
                                    content:
                                        Text("Plansız Tur Başarıyla Silindi."),
                                    backgroundColor: Colors.blueGrey.shade700,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
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
              child: Observer(builder: (_) {
                return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: findingSnapshots,
                  builder: (context, snapshot) {
                    if (snapshot.hasError)
                      return Text('Error = ${snapshot.error}');

                    if (snapshot.hasData) {
                      final docs = snapshot.data!.docs;

                      return buildHorizontalChips(
                          docs, viewModel, widget.tour!.key);
                    }

                    return Center(child: CircularProgressIndicator());
                  },
                );
              }),
            ),
            Text(
              'Plansız Tur Bilgileri',
              style: TextStyle(fontSize: 18),
            ),
            Observer(builder: (_) {
              return Expanded(
                flex: 12,
                child: buildExpandedTourDetails(widget.tour!),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget buildHorizontalChips(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
      UnPlannedTourDetailViewModel viewModel,
      String tourKey) {
    if (docs.isEmpty) {
      return Center(
          child: Text(
        "Henüz eklenmiş bir bulgu bulunmamaktadır.",
        style: TextStyle(
            fontFamily: "Poppins", fontSize: 14, fontWeight: FontWeight.w400),
      ));
    }
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: docs.length,
      padding: EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (BuildContext context, int index) {
        final data = docs[index].data();
        final findingId = docs[index].reference.id;
        data['key'] = findingId;
        if (data.isEmpty)
          return Text("Henüz eklenmiş bir bulgu bulunmamaktadır.");
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: GestureDetector(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FindingDetailView(
                        finding: FindingModel.fromJson(
                          data,
                        ),
                        tourKey: tourKey,
                        findingNumber: index),
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

  Padding buildExpandedTourDetails(UnPlannedTourModel tour) {
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
              buildBiggerDataTextWidget(tour.key),
              buildLittleTextWidget("Lokasyon"),
              buildBiggerDataTextWidget(tour.location),
              SizedBox(height: 10),
              buildLittleTextWidget("Saha"),
              buildBiggerDataTextWidget(tour.field),
              SizedBox(height: 10),
              buildLittleTextWidget("Ekip Üyeleri"),
              buildBiggerDataTextWidget(tour.tourTeamMembers),
              SizedBox(height: 10),
              buildLittleTextWidget("Tura Eşlik Edenler"),
              buildBiggerDataTextWidget(tour.tourAccompanies),
              SizedBox(height: 10),
              buildLittleTextWidget("Tur Tarihi"),
              buildBiggerDataTextWidget(tour.tourDate),
              SizedBox(height: 10),
              buildLittleTextWidget("Saha Organinasyon Skoru"),
              buildBiggerDataTextWidget(tour.fieldOrganizationScore),
              SizedBox(height: 10),
              buildLittleTextWidget("Gözlenen Pozitif Bulgular"),
              buildBiggerDataTextWidget(tour.observedPositiveFindings),
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