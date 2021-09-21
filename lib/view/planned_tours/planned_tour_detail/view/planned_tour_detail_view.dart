import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttermvvmtemplate/core/constants/navigation/navigation_constants.dart';
import 'package:fluttermvvmtemplate/core/init/navigation/navigation_service.dart';
import 'package:fluttermvvmtemplate/view/_product/_widgets/finding_chip.dart';
import 'package:fluttermvvmtemplate/view/planned_tours/add_planned_tour/model/planned_tour_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/text/auto_locale.text.dart';
import '../../../../core/init/auth/authentication_provider.dart';
import '../../../home/home_esd/model/finding_model.dart';
import '../viewmodel/planned_tour_detail_view_model.dart';

class PlannedTourDetailView extends StatefulWidget {
  final PlannedTourModel? tour;
  PlannedTourDetailView({Key? key, this.tour}) : super(key: key);

  @override
  _PlannedTourDetailViewState createState() => _PlannedTourDetailViewState();
}

class _PlannedTourDetailViewState extends State<PlannedTourDetailView> {
  @override
  Widget build(BuildContext context) {
    // final tour = ModalRoute.of(context)!.settings.arguments as PlannedTourModel;

    var findingSnapshots = FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<AuthenticationProvider>(context)
            .firebaseAuth
            .currentUser!
            .uid)
        .collection('tours')
        .doc(widget.tour!.key)
        .collection("findings")
        .snapshots();
    print(widget.tour);

    return BaseView<PlannedTourDetailViewModel>(
      viewModel: PlannedTourDetailViewModel(),
      onModelReady: (PlannedTourDetailViewModel model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder:
          (BuildContext context, PlannedTourDetailViewModel viewModel) =>
              Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            NavigationService.instance.navigateToPage(
                NavigationConstants.ADD_PLANNED_TOUR_FINDING,
                data: widget.tour);
            // NavigationService.instance.navigateToPage(
            //     NavigationConstants.ADD_PLANNED_TOUR_FINDING,
            //     data: tour);
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text("Planlı Turlar Detay"),
          actions: [
            IconButton(
              onPressed: () {
                context.read<AuthenticationProvider>().signOut();
              },
              icon: Icon(Icons.logout),
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
            Observer(builder: (_) {
              return Text(
                viewModel.isVisible == false
                    ? 'Tur Bilgileri'
                    : "Bulgu ${viewModel.findingList.indexOf(viewModel.selectedFinding)}",
                style: TextStyle(fontSize: 18),
              );
            }),
            Observer(builder: (_) {
              return Visibility(
                visible: !viewModel.isVisible,
                child: Expanded(
                  flex: 12,
                  child: buildExpandedTourDetails(widget.tour!),
                ),
              );
            }),
            Observer(builder: (_) {
              return Visibility(
                visible: viewModel.isVisible,
                child: Expanded(
                  flex: 12,
                  child: buildExpandedFindingDetails(viewModel.selectedFinding),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  ListView buildHorizontalChips(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
      PlannedTourDetailViewModel viewModel,
      String tourKey) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: docs.length,
        itemBuilder: (BuildContext context, int index) => FindingChip(
              "Bulgu $index",
              viewModel,
              index,
              tourKey: tourKey,
            ));
  }

  Padding buildExpandedTourDetails(PlannedTourModel tour) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
            ],
          ),
        ],
      ),
    );
  }

  Padding buildExpandedFindingDetails(FindingModel finding) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLittleTextWidget("Kategori"),
              buildBiggerDataTextWidget(finding.category as String),
              SizedBox(height: 10),
              buildLittleTextWidget("Alınması Gereken Aksiyonlar"),
              buildBiggerDataTextWidget(finding.actionsMustBeTaken != null
                  ? finding.actionsMustBeTaken!
                  : ""),
              SizedBox(height: 10),
              buildLittleTextWidget("Saha Alınan Aksiyonlar"),
              buildBiggerDataTextWidget(finding.actionsTakenInField as String),
              SizedBox(height: 10),
              buildLittleTextWidget("Saha Yöneticisi Açıklamaları"),
              buildBiggerDataTextWidget(
                  finding.fieldManagerStatements as String),
              SizedBox(height: 10),
              buildLittleTextWidget("Gözlemler"),
              buildBiggerDataTextWidget(finding.observations != null
                  ? finding.observations as String
                  : ""),
              SizedBox(height: 10),
              buildLittleTextWidget("Bulgu Türü"),
              buildBiggerDataTextWidget(finding.findingType as String),
              SizedBox(height: 10),
              buildLittleTextWidget("Dosya"),
              buildBiggerDataTextWidget(finding.file as String),
            ],
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
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

  Widget chipOne(String title, Function clickAction, {bool active = false}) {
    //active argument is optional
    return Container(
      margin: const EdgeInsets.all(5),
      child: FlatButton(
          color: active ? Colors.black12 : Colors.white,
          //if active == true then background color is black
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(color: Colors.black12, width: 2)
              //set border radius, color and width
              ),
          onPressed: () {}, //set function
          child: Text(title) //set title
          ),
    );
  }

  buildBiggerDataTextWidget(dynamic data) {
    // var result = "";
    var finalResult = "";
    if (data is List) {
      data.forEach((dynamic element) {
        finalResult += element['name'] + ", ";
        // result.trimRight(',');
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
    return AutoLocaleText(
      value: title,
      style: TextStyle(
          fontSize: 12,
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.w800),
    );
  }
}
