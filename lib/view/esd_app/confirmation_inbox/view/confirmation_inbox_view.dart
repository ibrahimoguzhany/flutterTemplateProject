import 'package:esd_mobil/core/base/view/base_view.dart';
import 'package:esd_mobil/core/constants/image/image_constants.dart';
import 'package:esd_mobil/core/extensions/context_extension.dart';
import 'package:esd_mobil/view/esd_app/confirmation_inbox/service/confirmation_inbox_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../core/constants/navigation/navigation_constants.dart';
import '../../../../core/init/navigation/navigation_service.dart';
import '../model/confirmation_model.dart';
import '../viewmodel/confirmation_inbox_view_model.dart';

class ConfirmationInboxView extends StatefulWidget {
  const ConfirmationInboxView({Key? key}) : super(key: key);

  @override
  _ConfirmationInboxViewState createState() => _ConfirmationInboxViewState();
}

class _ConfirmationInboxViewState extends State<ConfirmationInboxView>
    with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    RouteObserverCall.routeObserver
        .subscribe(this, ModalRoute.of(context) as PageRoute<dynamic>);
  }

  @override
  void dispose() {
    RouteObserverCall.routeObserver.unsubscribe(this);
    super.dispose();
  }

  void didPopNext() {
    setState(() {});
  }

  final SlidableController slidableController = SlidableController();

  @override
  Widget build(BuildContext context) {
    // Widget buildBlur(
    //         {required Widget child,
    //         double sigmaX = 10.0,
    //         double sigmaY = 10.0}) =>
    //     BackdropFilter(
    //       filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
    //       child: child,
    // );
    return BaseView<ConfirmationInboxViewModel>(
      viewModel: ConfirmationInboxViewModel(),
      onModelReady: (ConfirmationInboxViewModel model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder:
          (BuildContext context, ConfirmationInboxViewModel viewModel) =>
              Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 68),
                child: Hero(
                  tag: "socarLogo",
                  child: Image.asset(
                      ImageConstants.instance!.toPng("800pxlogo_of_socar1")),
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 14,
                child: FutureBuilder(
                  future:
                      ConfirmationInboxService.instance!.getConfirmationItems(),
                  builder: (context,
                      AsyncSnapshot<List<ConfirmationModel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SizedBox(
                          height: context.height * 0.05,
                          width: context.width * 0.1,
                          child: Transform.scale(
                            alignment: Alignment.center,
                            transformHitTests: false,
                            origin: Offset(0, 0),
                            scale: 2.0,
                            child: CircularProgressIndicator(
                              semanticsValue: "Loading",
                              semanticsLabel: "Loading",
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                        itemCount: (snapshot.data ?? []).length,
                        itemBuilder: (context, index) => Slidable(
                              controller: slidableController,
                              key: Key(ConfirmationList
                                  .confirmationList[index].appName!),
                              actionPane: SlidableDrawerActionPane(),
                              showAllActionsThreshold: 0.1,
                              actionExtentRatio: 0.15,
                              closeOnScroll: true,
                              actions: [
                                IconSlideAction(
                                    closeOnTap: true,
                                    color: Colors.red,
                                    icon: Icons.cancel_outlined,
                                    onTap: () {
                                      ConfirmationInboxService.instance!
                                          .rejectConfirmationItem(
                                              ConfirmationList
                                                  .confirmationList[index],
                                              context);
                                      setState(() {});
                                    }),
                                IconSlideAction(
                                    closeOnTap: true,
                                    color: Colors.green,
                                    icon: Icons.check,
                                    onTap: () {
                                      ConfirmationInboxService.instance!
                                          .acceptConfirmationItem(
                                              ConfirmationList
                                                  .confirmationList[index],
                                              context);
                                      setState(() {});
                                    }),
                                IconSlideAction(
                                  closeOnTap: true,
                                  color: Colors.grey[300],
                                  icon: Icons.more_horiz_outlined,
                                  onTap: () {
                                    NavigationService.instance.navigateToPage(
                                        NavigationConstants
                                            .CONFIRMATION_DETAIL_VIEW,
                                        data: ConfirmationList
                                            .confirmationList[index]);
                                  },
                                ),
                              ],
                              child: Card(
                                color:
                                    context.colors.secondary.withOpacity(0.9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 8.0,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 6.0),
                                child: Container(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    onTap: () async {
                                      await NavigationService.instance
                                          .navigateToPage(
                                        NavigationConstants
                                            .CONFIRMATION_DETAIL_VIEW,
                                        data: ConfirmationList
                                            .confirmationList[index],
                                      );
                                    },
                                    leading: Text(
                                      ConfirmationList
                                          .confirmationList[index].appName!,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                    title: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 30,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            ConfirmationList
                                                .confirmationList[index]
                                                .company!,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            ConfirmationList
                                                .confirmationList[index].unit!,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            ConfirmationList
                                                .confirmationList[index]
                                                .estimatedBypassTime!,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            ConfirmationList
                                                .confirmationList[index]
                                                .bypassReason!,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
