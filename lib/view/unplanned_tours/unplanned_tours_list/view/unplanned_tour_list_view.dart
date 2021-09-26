import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttermvvmtemplate/view/_product/_constants/image_path_svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/constants/navigation/navigation_constants.dart';
import '../../../../core/init/auth/authentication_provider.dart';
import '../../../../core/init/navigation/navigation_service.dart';
import '../../add_unplanned_tour/model/unplanned_tour_model.dart';
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
          onPressed: () {
            NavigationService.instance
                .navigateToPage(NavigationConstants.ADD_UNPLANNED_TOUR_VIEW);
          },
          child: Icon(Icons.add),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: viewModel.tourSnapshots(context),
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text('Error = ${snapshot.error}');

            if (snapshot.hasData) {
              final docs = snapshot.data!.docs;

              return buildListView(docs);
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () async {
            await Provider.of<AuthenticationProvider>(context, listen: false)
                .signOut(context);
          },
        )
      ],
      title: Text("Plansız Turlar"),
    );
  }

  SvgPicture buildSvgPicture(String path) => SvgPicture.asset(path);
  Widget buildListView(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
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
              "Henüz Eklenmiş Bir Plansız Tur Kaydı Bulunmamaktadır.",
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
        final data = docs[index].data();
        final tourId = docs[index].reference.id;
        data["key"] = tourId;

        // print(data);
        return buildListTile(data, index);
      },
    );
  }

  ListTile buildListTile(Map<String, dynamic> data, int index) {
    var _data = data['observedPositiveFindings'].toString();

    return ListTile(
      enableFeedback: true,
      contentPadding: EdgeInsets.all(8.0),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UnPlannedTourDetailView(
              tour: UnPlannedTourModel.fromJson(data),
            ),
          ),
        );
      },
      selectedTileColor: Colors.black12,
      hoverColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      leading: Text(
        data['location'],
        style: TextStyle(fontSize: 16),
      ),
      subtitle: Text(
        data['key'],
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 14),
      ),
      // subtitle: AutoLocaleText(
      //   value: _data.length > 30 ? _data.substring(0, 50) + "..." : _data,
      //   style: TextStyle(fontSize: 12),
      // ),
      title: Text(
        data['field'],
        style: TextStyle(fontSize: 14),
      ),
      trailing: Text(
        data['tourDate'],
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}
