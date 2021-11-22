import 'dart:ui';

import 'package:esd_mobil/core/base/view/base_view.dart';
import 'package:esd_mobil/core/constants/image/image_constants.dart';
import 'package:esd_mobil/core/extensions/context_extension.dart';
import 'package:esd_mobil/view/esd_app/confirmation_inbox/model/confirmation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../module/approve_button.dart';
import '../../module/build_table.dart';
import '../../module/reject_button.dart';
import '../../viewmodel/subviewmodel/confirmation_detail_view_model.dart';

class ConfirmationDetailView extends StatelessWidget {
  const ConfirmationDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConfirmationModel model =
        ModalRoute.of(context)!.settings.arguments as ConfirmationModel;
    print(model.formCreator);
    return BaseView<ConfirmationDetailViewModel>(
      viewModel: ConfirmationDetailViewModel(),
      onModelReady: (ConfirmationDetailViewModel model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder:
          (BuildContext context, ConfirmationDetailViewModel viewModel) =>
              Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.only(bottom: 24.0, left: 48, top: 12),
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    ImageConstants.instance!.toPng("800pxlogo_of_socar1"),
                    width: 200,
                  ),
                ),
                Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    textDirection: TextDirection.rtl,
                    fit: StackFit.loose,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: context.colors.secondary,
                          ),
                          padding: EdgeInsets.all(12),
                          child: Container(
                            child: buildColumn(context, viewModel, model),
                          ),
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
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
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
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
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
                      })
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildColumn(BuildContext context,
      ConfirmationDetailViewModel viewModel, ConfirmationModel model) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        BuildTable(model: model),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ApproveButton(viewModel: viewModel, model: model),
            RejectButton(viewModel: viewModel, model: model),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
      ],
    );
  }

  Widget buildBlur(
          {required Widget child,
          double sigmaX = 10.0,
          double sigmaY = 10.0}) =>
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
        child: child,
      );
}
