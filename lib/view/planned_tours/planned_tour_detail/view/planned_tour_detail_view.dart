import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttermvvmtemplate/core/base/view/base_view.dart';
import 'package:fluttermvvmtemplate/core/components/text/auto_locale.text.dart';
import 'package:fluttermvvmtemplate/core/init/auth/authentication_provider.dart';
import 'package:fluttermvvmtemplate/view/_product/_widgets/finding_chip.dart';
import 'package:fluttermvvmtemplate/view/home/home_esd/model/finding_model.dart';
import 'package:fluttermvvmtemplate/view/planned_tours/model/planned_tour_model.dart';
import 'package:fluttermvvmtemplate/view/planned_tours/planned_tour_detail/viewmodel/planned_tour_detail_view_model.dart';
import 'package:provider/provider.dart';

class PlannedTourDetailView extends StatelessWidget {
  PlannedTourDetailView({Key? key}) : super(key: key);

  // final TourModel tour;

  @override
  Widget build(BuildContext context) {
    final tour = ModalRoute.of(context)!.settings.arguments as PlannedTourModel;

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
          onPressed: () {},
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
            // TODO: Findingler Turlara aittir. Findingleri Tur'un içinden çekmelisin. collection'un collection'una get atabilirsin.
            Expanded(
              child: Observer(builder: (_) {
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: viewModel.currentFindingList.length,
                  itemBuilder: (BuildContext context, int index) =>
                      FindingChip("Bulgu $index", viewModel, index),
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
                  child: buildExpandedTourDetails(tour),
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
              buildBiggerDataTextWidget(tour.tourTeamMembers),
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
              buildBiggerDataTextWidget(finding.observations as String),
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

  Padding buildBiggerDataTextWidget(String data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AutoLocaleText(
        value: data,
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
