import 'dart:ui';

import 'package:esd_mobil/core/extensions/context_extension.dart';
import 'package:esd_mobil/core/init/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/constants/image/image_constants.dart';
import '../../viewmodel/subviewmodel/confirmation_detail_view_model.dart';

class ConfirmationDetailView extends StatelessWidget {
  const ConfirmationDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                            color: Color(0xfffe7144),
                          ),
                          padding: EdgeInsets.all(12),
                          child: Container(
                            child: Column(
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                ),
                                buildTable(),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton.icon(
                                        style: ButtonStyle(
                                          fixedSize: MaterialStateProperty.all(
                                              Size(120, 15)),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.green),
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side:
                                                  BorderSide(color: Colors.red),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
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
                                                      .changeIsApproveClicked()))
                                              .then((value) =>
                                                  Navigator.pop(context));
                                        },
                                        icon: Icon(Icons.check_circle_outline),
                                        label: Text("Onayla")),
                                    TextButton.icon(
                                        style: ButtonStyle(
                                            fixedSize:
                                                MaterialStateProperty.all(
                                                    Size(120, 15)),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.red),
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(18.0),
                                                    side: BorderSide(color: Colors.red)))),
                                        onPressed: () {
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
                                                      .changeIsRejectClicked()))
                                              .then((value) =>
                                                  Navigator.pop(context));
                                        },
                                        icon: Icon(Icons.close),
                                        label: Text("Reddet"))
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                ),
                              ],
                            ),
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
                                          color: Colors.white),
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

  Widget buildBlur(
          {required Widget child,
          double sigmaX = 10.0,
          double sigmaY = 10.0}) =>
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
        child: child,
      );
}

class buildTable extends StatelessWidget {
  const buildTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.white10, style: BorderStyle.solid),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      defaultColumnWidth:
          FixedColumnWidth(MediaQuery.of(context).size.width / 2.2),
      children: [
        TableRow(children: [
          Column(children: [
            Text('Formu Oluşturan:',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.start)
          ]),
          Column(children: [
            Text('Dilek Kara',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.start)
          ]),
        ]),
        TableRow(children: [
          Column(children: [
            Text(
              'Şirket:',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.start,
            )
          ]),
          Column(
              children: [Text('STAD', style: TextStyle(color: Colors.white))]),
        ]),
        TableRow(children: [
          Column(children: [
            Text('Ünite:', style: TextStyle(color: Colors.white))
          ]),
          Column(children: [
            Text('Terminal A', style: TextStyle(color: Colors.white))
          ]),
        ]),
        TableRow(children: [
          Column(children: [
            Text(
              'Emniyet Sistemi Açıklaması',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.start,
            )
          ]),
          Column(children: [
            Text('Lorem Ipsum', style: TextStyle(color: Colors.white))
          ]),
        ]),
        TableRow(children: [
          Column(children: [
            Text('By-pass Nedeni',
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white))
          ]),
          Column(children: [
            Text('Lorem Ipsum', style: TextStyle(color: Colors.white))
          ]),
        ]),
        TableRow(children: [
          Column(children: [
            Text('Emniyet Sistemi Tipi', style: TextStyle(color: Colors.white))
          ]),
          Column(children: [
            Text('Yangın ve Gaz', style: TextStyle(color: Colors.white))
          ]),
        ]),
        TableRow(children: [
          Column(children: [
            Text('Trip Parametre Tag No', style: TextStyle(color: Colors.white))
          ]),
          Column(children: [
            Text('Algılama', style: TextStyle(color: Colors.white))
          ]),
        ]),
        TableRow(children: [
          Column(children: [
            Text('Emniyet Sistemi Alt Tipi',
                style: TextStyle(color: Colors.white))
          ]),
          Column(children: [
            Text('TEST S.S ALT TİPİ 3.1',
                style: TextStyle(color: Colors.white)),
          ]),
        ]),
        TableRow(children: [
          Column(children: [
            Text("Tahmini By-Pass Süresi",
                style: TextStyle(color: Colors.white))
          ]),
          Column(children: [
            Text('2 saat', style: TextStyle(color: Colors.white))
          ]),
        ]),
        TableRow(children: [
          Column(children: [
            Text("By-Pass'a Alan Kişiler",
                style: TextStyle(color: Colors.white))
          ]),
          Column(children: [
            Text('Dilek Kara; Gülden Kelez',
                style: TextStyle(color: Colors.white))
          ]),
        ]),
      ],
    );
  }
}
