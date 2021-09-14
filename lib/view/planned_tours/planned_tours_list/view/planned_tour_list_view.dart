import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttermvvmtemplate/core/base/view/base_view.dart';
import 'package:fluttermvvmtemplate/core/constants/navigation/navigation_constants.dart';
import 'package:fluttermvvmtemplate/core/init/auth/authentication_provider.dart';
import 'package:fluttermvvmtemplate/core/init/navigation/navigation_service.dart';
import 'package:fluttermvvmtemplate/view/planned_tours/planned_tour_detail/model/tour_model.dart';
import 'package:fluttermvvmtemplate/view/planned_tours/planned_tours_list/viewmodel/planned_tour_list_view_model.dart';
import 'package:provider/provider.dart';

class PlannedTourListView extends StatefulWidget {
  @override
  _PlannedTourListViewState createState() => _PlannedTourListViewState();
}

class _PlannedTourListViewState extends State<PlannedTourListView> {
  // final Stream<QuerySnapshot> _toursStream = FirebaseFirestore.instance
  //     .collection('tours')
  //     .snapshots(includeMetadataChanges: true);

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
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Provider.of<AuthenticationProvider>(context, listen: false)
                    .signOut();
              },
            )
          ],
          title: Text("Planlı Turlar"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            NavigationService.instance
                .navigateToPage(NavigationConstants.ADD_PLANNED_TOUR_VIEW);
            // Get.toNamed("add_tour_page");
          },
          child: Icon(Icons.add),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: viewModel.tourSnapshots,
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

  ListView buildListView(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Colors.black26,
      ),
      itemCount: docs.length,
      itemBuilder: (context, index) {
        final data = docs[index].data();
        return buildListTile(data, index);
      },
    );
  }

  Padding buildListTile(Map<String, dynamic> data, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        onTap: () {
          NavigationService.instance.navigateToPage(
              NavigationConstants.PLANNED_TOUR_DETAIL_VIEW,
              data: TourModel.fromJson(data));
        },
        leading: Text(
          data['location'],
          style: TextStyle(fontSize: 18),
        ),
        title: Text(
          data['field'],
          style: TextStyle(fontSize: 18),
        ),
        subtitle: Text(
          data['tourTeamMembers'],
          style: TextStyle(fontSize: 18),
        ),
        trailing: Text(
          data['tourDate'],
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
