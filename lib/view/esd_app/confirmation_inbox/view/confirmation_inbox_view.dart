import 'dart:ui';

import 'package:esd_mobil/core/base/view/base_view.dart';
import 'package:esd_mobil/core/constants/image/image_constants.dart';
import 'package:esd_mobil/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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

  @override
  Widget build(BuildContext context) {
    Widget buildBlur(
            {required Widget child,
            double sigmaX = 10.0,
            double sigmaY = 10.0}) =>
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
          child: child,
        );
    return BaseView<ConfirmationInboxViewModel>(
      viewModel: ConfirmationInboxViewModel(),
      onModelReady: (ConfirmationInboxViewModel model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder:
          (BuildContext context, ConfirmationInboxViewModel viewModel) =>
              Scaffold(
        body: SafeArea(
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            textDirection: TextDirection.rtl,
            fit: StackFit.loose,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: context.colors.secondary,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Column(
                children: [
                  Spacer(
                    flex: 2,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 84),
                    child: Hero(
                      tag: "socarLogo",
                      child: Image.asset(ImageConstants.instance!
                          .toPng("800pxlogo_of_socar1")),
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 20,
                    child: SingleChildScrollView(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: ConfirmationList.confirmationList.length,
                          itemBuilder: (_, i) => Slidable(
                                key: Key(ConfirmationList
                                    .confirmationList[i].appName!),
                                actionPane: SlidableDrawerActionPane(),
                                showAllActionsThreshold: 0.75,
                                actions: [
                                  IconSlideAction(
                                      caption: "Red",
                                      color: Colors.red,
                                      icon: Icons.delete,
                                      onTap: () {
                                        viewModel.changeIsRejectClicked();
                                        viewModel.changeShowCPI();
                                        Future.delayed(Duration(seconds: 3))
                                            .then((value) =>
                                                viewModel.changeShowCPI())
                                            .then((value) => viewModel
                                                .changeShowRejectedText())
                                            .then((value) => Future.delayed(
                                                    Duration(seconds: 1))
                                                .then((value) => viewModel
                                                    .changeShowRejectedText())
                                                .then((value) => viewModel
                                                    .changeIsRejectClicked()));
                                        setState(() {
                                          ConfirmationList.confirmationList
                                              .removeAt(i);
                                        });
                                      }),
                                  IconSlideAction(
                                      caption: "Onay",
                                      color: Colors.green,
                                      icon: Icons.approval_outlined,
                                      onTap: () {
                                        viewModel.changeIsApproveClicked();
                                        viewModel.changeShowCPI();
                                        Future.delayed(Duration(seconds: 3))
                                            .then((value) =>
                                                viewModel.changeShowCPI())
                                            .then((value) => viewModel
                                                .changeShowApprovedText())
                                            .then((value) => Future.delayed(
                                                    Duration(seconds: 1))
                                                .then((value) => viewModel
                                                    .changeShowApprovedText())
                                                .then((value) => viewModel
                                                    .changeIsApproveClicked()));
                                        setState(() {
                                          ConfirmationList.confirmationList
                                              .removeAt(i);
                                        });
                                      }),
                                  IconSlideAction(
                                    caption: "Vazgeç",
                                    color: Colors.grey[300],
                                    icon: Icons.cancel_outlined,
                                    onTap: () {},
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
                                              .confirmationList[i],
                                        );
                                      },
                                      leading: Text(
                                        ConfirmationList
                                            .confirmationList[i].appName!,
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
                                                  .confirmationList[i].company!,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              ConfirmationList
                                                  .confirmationList[i].unit!,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              ConfirmationList
                                                  .confirmationList[i]
                                                  .estimatedBypassTime!,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              ConfirmationList
                                                  .confirmationList[i]
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
                              )),
                    ),
                  ),
                  Observer(builder: (_) {
                    return Visibility(
                      visible: viewModel.isApproveClicked,
                      child: Center(
                          child: buildBlur(
                        child: viewModel.showCPI
                            ? Center(
                                child: SizedBox(
                                  height: 40.0,
                                  width: 40.0,
                                  child: Transform.scale(
                                    scale: 3,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.green,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.all(24),
                                child: Text(
                                  "Onaylandı!",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                      )),
                    );
                  }),
                  Observer(builder: (_) {
                    return Visibility(
                      visible: viewModel.isRejectClicked,
                      child: Center(
                          child: buildBlur(
                        child: viewModel.showCPI
                            ? Center(
                                child: SizedBox(
                                  height: 40.0,
                                  width: 40.0,
                                  child: Transform.scale(
                                    scale: 3,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.all(24),
                                child: Text(
                                  "Reddedildi!",
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                      )),
                    );
                  }),
                  Observer(builder: (_) {
                    return Visibility(
                      visible: viewModel.isApproveClicked ||
                          viewModel.isRejectClicked,
                      child: Spacer(
                        flex: 20,
                      ),
                    );
                  }),
                  Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
