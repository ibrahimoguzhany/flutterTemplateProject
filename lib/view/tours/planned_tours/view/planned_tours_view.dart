import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttermvvmtemplate/core/init/auth/authentication_provider.dart';
import 'package:fluttermvvmtemplate/view/tours/planned_tours/viewmodel/planned_tours_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../_product/_widgets/finding_chip.dart';

class PlannedToursView extends StatefulWidget {
  PlannedToursView({Key? key}) : super(key: key);

  @override
  State<PlannedToursView> createState() => _PlannedToursViewState();
}

class _PlannedToursViewState extends State<PlannedToursView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<PlannedToursViewModel>(
      viewModel: PlannedToursViewModel(),
      onModelReady: (PlannedToursViewModel model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, PlannedToursViewModel viewModel) =>
          Scaffold(
        appBar: AppBar(
          title: Text("Planlı Turlar"),
          actions: [
            IconButton(
              onPressed: () {
                context.read<AuthenticationProvider>().signOut();
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                // showing chips here
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const ScrollPhysics(),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white, //set background color
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.black12),
                      ),
                      //set the bottom-border
                    ),
                    child: Row(
                      children: <Widget>[
                        //here is the list of chips
                        Container(
                          height: 50,
                          child: FutureBuilder(
                            future: viewModel.getFindings(),
                            builder: (context, snapshot) {
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      viewModel.currentFindingList.length,
                                  itemBuilder: (context, index) {
                                    return FindingChip("Bulgu $index");
                                  });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Expanded(
              //   child: ListView.builder(
              //       itemBuilder: (context, index) => ListTile(
              //             leading: Text(
              //                 tourController.currentTourList[index].location),
              //             title: Text(
              //                 tourController.currentTourList[index].tourDate),
              //           )),
              // )

              // Container(
              //   height: MediaQuery.of(context).size.height * 0.8,
              //   child: GetBuilder<TourController>(
              //     builder: (controller) => ListView.separated(
              //       itemBuilder: (context, index) {
              //         return ListTile(
              //           leading:
              //               Text(controller.tourList[index].tourDate as String),
              //         );
              //       },
              //       separatorBuilder: (context, index) => const Divider(
              //         color: Colors.black,
              //       ),
              //       itemCount: controller.tourList.length,
              //     ),
              //   ),
              // ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[],
              // ),
            ],
          ),
        ),
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
}
