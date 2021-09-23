import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/text/auto_locale.text.dart';
import '../../../../core/constants/navigation/navigation_constants.dart';
import '../../../../core/init/auth/authentication_provider.dart';
import '../../../../core/init/navigation/navigation_service.dart';
import '../../add_planned_tour/model/planned_tour_model.dart';
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            NavigationService.instance
                .navigateToPage(NavigationConstants.ADD_PLANNED_TOUR_VIEW);
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
      title: Text("Planlı Turlar"),
    );
  }

  ListView buildListView(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
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

  Padding buildListTile(Map<String, dynamic> data, int index) {
    var _data = data['observedPositiveFindings'].toString();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        enableFeedback: true,
        contentPadding: EdgeInsets.all(12.0),
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
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        leading: Text(
          data['location'],
          style: TextStyle(fontSize: 18),
        ),
        title: Text(
          data['key'],
          style: TextStyle(fontSize: 16),
        ),
        subtitle: AutoLocaleText(
          value: _data.length > 30 ? _data.substring(0, 50) + "..." : _data,
          style: TextStyle(fontSize: 12),
        ),
        trailing: Text(
          data['tourDate'],
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
