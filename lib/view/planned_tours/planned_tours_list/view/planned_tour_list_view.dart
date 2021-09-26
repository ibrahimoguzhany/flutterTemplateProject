import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttermvvmtemplate/core/init/lang/locale_keys.g.dart';
import 'package:fluttermvvmtemplate/view/_product/_constants/image_path_svg.dart';
import 'package:fluttermvvmtemplate/view/planned_tours/model/planned_tour_model.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/init/auth/authentication_provider.dart';
import '../../planned_tour_detail/view/planned_tour_detail_view.dart';
import '../viewmodel/planned_tour_list_view_model.dart';

class PlannedTourListView extends StatefulWidget {
  @override
  _PlannedTourListViewState createState() => _PlannedTourListViewState();
}

class _PlannedTourListViewState extends State<PlannedTourListView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<PlannedTourListViewModel>(
      viewModel: PlannedTourListViewModel(),
      onModelReady: (PlannedTourListViewModel model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder:
          (BuildContext context, PlannedTourListViewModel viewModel) =>
              Scaffold(
        appBar: buildAppBar(context),
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
      centerTitle: true,
      title: Text(LocaleKeys.home_bottom_app_bar_tabs_planned_tours.tr()),
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
                padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
                child:
                    buildSvgPicture(SVGImagePaths.instance!.real_time_sync_SVG),
              )),
          Expanded(
            flex: 2,
            child: Text(
              LocaleKeys.planned_tours_list_noData.tr(),
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          )
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

  Widget buildListTile(Map<String, dynamic> data, int index) {
    var _data = data['observedPositiveFindings'].toString();

    return ListTile(
      enableFeedback: true,
      contentPadding: EdgeInsets.all(8.0),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlannedTourDetailView(
              tour: PlannedTourModel.fromJson(data),
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
