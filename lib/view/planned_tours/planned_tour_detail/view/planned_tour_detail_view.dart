import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttermvvmtemplate/view/planned_tours/planned_tour_detail/view/finding_detail.dart';
import '../../../../core/constants/navigation/navigation_constants.dart';
import '../../../../core/init/navigation/navigation_service.dart';
import '../../add_planned_tour/model/planned_tour_model.dart';

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
  dynamic getFindings(String tourId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<AuthenticationProvider>(context, listen: false)
            .firebaseAuth
            .currentUser!
            .uid)
        .collection("tours")
        .doc(tourId)
        .collection("findings")
        .get()
        .then((QuerySnapshot querySnapshot) {
      List<FindingModel> findingList = <FindingModel>[];
      querySnapshot.docs.forEach((doc) {
        findingList.add(FindingModel.fromDocumentSnapshot(doc));
      });
      return findingList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final findingSnapshots = FirebaseFirestore.instance
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

    final selectedTour = FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<AuthenticationProvider>(context)
            .firebaseAuth
            .currentUser!
            .uid)
        .collection('tours')
        .doc(widget.tour!.key);

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
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text("Planlı Turlar Detay"),
          actions: [
            IconButton(
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
                final snackBar = SnackBar(
                  content: Text("Tur başarıyla silindi."),
                  backgroundColor: Colors.blueGrey.shade700,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
              'Tur Bilgileri',
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

  ListView buildHorizontalChips(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
      PlannedTourDetailViewModel viewModel,
      String tourKey) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: docs.length,
      padding: EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (BuildContext context, int index) {
        final data = docs[index].data();
        final findingId = docs[index].reference.id;
        data['key'] = findingId;
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
                    ),
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
                // disabledColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 3,
                shadowColor: Colors.grey[60],
                padding: EdgeInsets.all(8.0),
                // selected: false,
              )),
        );
      },
    );
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
    return AutoLocaleText(
      value: title,
      style: TextStyle(
          fontSize: 12,
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.w800),
    );
  }
}
