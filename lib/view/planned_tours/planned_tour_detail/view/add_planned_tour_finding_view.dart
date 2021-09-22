import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttermvvmtemplate/view/_widgets/button/button_widget.dart';
import 'package:fluttermvvmtemplate/view/planned_tours/planned_tour_detail/service/planned_tour_detail_service.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/text/auto_locale.text.dart';
import '../../../_product/_widgets/big_little_text_widget.dart';
import '../../../home/home_esd/model/finding_model.dart';
import '../../add_planned_tour/model/planned_tour_model.dart';
import '../viewmodel/add_planned_tour_finding_view_model.dart';

class AddPlannedTourFindingView extends StatefulWidget {
  const AddPlannedTourFindingView({Key? key}) : super(key: key);

  @override
  _AddPlannedTourFindingViewState createState() =>
      _AddPlannedTourFindingViewState();
}

class _AddPlannedTourFindingViewState extends State<AddPlannedTourFindingView> {
  UploadTask? task;
  File? file;

  List<String> findingTypes = ['Emniyetsiz Durum', "Emniyetsiz Davranış"];
  List<String> findingCategories = [
    'Kaygan Zemin',
    "Yüksek Sıcaklık",
    "Baretsiz Çalışma",
    "Uykusuz Çalışma"
  ];

  late FindingModel finding;
  @override
  void initState() {
    super.initState();

    finding = FindingModel();
  }

  final _controllerActionMustBeTaken = TextEditingController();
  final _controllerActionMustBeTakenInField = TextEditingController();
  final _controllerFieldManagerStatements = TextEditingController();
  final _controllerObservations = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final fileName =
        file != null ? basename(file!.path) : 'Seçili dosya bulunmamaktadır.';
    PlannedTourModel tour =
        ModalRoute.of(context)!.settings.arguments as PlannedTourModel;

    final _formKey = GlobalKey<FormState>();

    return BaseView<AddPlannedTourFindingViewModel>(
      viewModel: AddPlannedTourFindingViewModel(),
      onModelReady: (AddPlannedTourFindingViewModel model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder:
          (BuildContext context, AddPlannedTourFindingViewModel viewModel) =>
              Scaffold(
        appBar: AppBar(
          title: AutoLocaleText(
            style: TextStyle(fontSize: 18),
            value: "Planlı Tur Bulgu Ekleme Sayfası ",
          ),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(24),
            children: [
              buildLittleTextWidget("Bulgu Türü"),
              SizedBox(height: 5),
              buildFindingTypeDropdown,
              SizedBox(height: 20),
              buildLittleTextWidget("Kategori"),
              SizedBox(height: 5),
              buildFindingCategoryDropdown,
              SizedBox(height: 10),
              buildLittleTextWidget("Alınması Gereken Aksiyonlar"),
              SizedBox(height: 5),
              buildActionsMustBeTaken,
              SizedBox(height: 20),
              buildLittleTextWidget("Sahada Alınması Gereken Aksiyonlar"),
              SizedBox(height: 5),
              buildActionTakenInField,
              SizedBox(height: 20),
              buildLittleTextWidget("Saha Yöneticisi Açıklaması"),
              SizedBox(height: 5),
              buildFieldManagerStatements,
              SizedBox(height: 20),
              buildLittleTextWidget("Gözlemler"),
              SizedBox(height: 5),
              buildObservations,
              SizedBox(height: 20),
              buildLittleTextWidget("Dosya"),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: Colors.black12,
                        width: 2,
                      ),
                      right: BorderSide(
                        color: Colors.black12,
                        width: 2,
                      ),
                      bottom: BorderSide(
                        color: Colors.black12,
                        width: 2,
                      ),
                      top: BorderSide(
                        color: Colors.black12,
                        width: 2,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(3)),
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    ButtonWidget(
                      text: 'Galeriden Dosya Seç / Resim Çek',
                      icon: Icons.attach_file,
                      onClicked: selectFile,
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        if (viewModel.imageUrl != null) {
                          _launchURL(viewModel);
                        }
                      },
                      child: Text(
                        fileName,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: 24),
                    ButtonWidget(
                      text: 'Yükle',
                      icon: Icons.cloud_upload_outlined,
                      onClicked: () async {
                        finding.imageUrl = await uploadFile();
                        if (viewModel.imageUrl != null) {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.green[600],
                            content:
                                Text("Seçilen Dosyalar Başarıyla Yüklendi"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    task != null ? buildUploadStatus(task!) : Container(),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              FloatingActionButton.extended(
                onPressed: () async {
                  final isValid = _formKey.currentState!.validate();
                  if (isValid) {
                    _formKey.currentState!.save();
                    await viewModel.addFinding(finding, context, tour.key);
                    Navigator.pop(context);
                    final snackBar = SnackBar(
                      content: Text("Bulgu başarıyla eklendi."),
                      backgroundColor: Colors.green,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                label: Text("Kaydet"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future<String> uploadFile() async {
    if (file == null) return "";

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = PlannedTourDetailService.instance!.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return "";

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');

    return urlDownload;
  }

  void _launchURL(AddPlannedTourFindingViewModel vm) async =>
      await canLaunch(vm.imageUrl!)
          ? await launch(vm.imageUrl!)
          : throw 'Could not launch ${vm.imageUrl!}';

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            if (percentage != "100.00") {
              return Text(
                '$percentage %',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              );
            }
            return Text(
              'Yüklendi',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );

  Padding get buildFindingCategoryDropdown => Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: DropdownButtonFormField<String>(
          validator: (val) {
            if (val!.isEmpty) {
              return "Kategori alanı boş bırakılamaz.";
            }
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          hint: Text('Bulgu Türü'),
          value: finding.category,
          icon: const Icon(
            Icons.arrow_downward,
            color: Colors.black38,
          ),
          iconSize: 24,
          elevation: 20,
          onChanged: (String? newValue) {
            setState(() {
              finding.category = newValue!;
            });
          },
          items:
              findingCategories.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      );

  Padding get buildFindingTypeDropdown => Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: DropdownButtonFormField<String>(
          validator: (val) {
            if (val!.isEmpty) {
              return "Bulgu Türü alanı boş bırakılamaz.";
            }
          },
          hint: Text('Bulgu Türü'),
          value: finding.findingType,
          icon: const Icon(
            Icons.arrow_downward,
            color: Colors.black38,
          ),
          iconSize: 24,
          elevation: 20,
          onChanged: (String? newValue) {
            setState(() {
              finding.findingType = newValue!;
            });
          },
          items: findingTypes.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      );

  TextFormField get buildActionsMustBeTaken => TextFormField(
        validator: (val) {
          if (val!.isEmpty) {
            return "Lütfen alınması gereken aksiyonlar alanını doldurunuz.";
          }
        },
        controller: _controllerActionMustBeTaken,
        keyboardType: TextInputType.multiline,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLines: 5,
        decoration: InputDecoration(
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black26, width: 2.0),
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black26, width: 2.0),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onSaved: (val) {
          setState(() {
            finding.actionsMustBeTaken = _controllerActionMustBeTaken.text;
          });
        },
        onChanged: (val) {
          finding.actionsMustBeTaken = _controllerActionMustBeTaken.text;
        },
      );

  TextFormField get buildActionTakenInField => TextFormField(
        validator: (val) {
          if (val!.isEmpty) {
            return "Lütfen sahada alınması gereken aksiyonlar alanını doldurunuz.";
          }
        },
        controller: _controllerActionMustBeTakenInField,
        keyboardType: TextInputType.multiline,
        maxLines: 5,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black26, width: 2.0),
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black26, width: 2.0),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onSaved: (val) {
          setState(() {
            finding.actionsTakenInField =
                _controllerActionMustBeTakenInField.text;
          });
        },
        onChanged: (val) {
          finding.actionsTakenInField =
              _controllerActionMustBeTakenInField.text;
        },
      );

  TextFormField get buildFieldManagerStatements => TextFormField(
        validator: (val) {
          if (val!.isEmpty) {
            return "Lütfen Saha Yöneticisi Açıklaması alanını doldurunuz.";
          }
        },
        controller: _controllerFieldManagerStatements,
        keyboardType: TextInputType.multiline,
        maxLines: 5,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black26, width: 2.0),
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black26, width: 2.0),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onSaved: (val) {
          setState(() {
            finding.fieldManagerStatements =
                _controllerFieldManagerStatements.text;
          });
        },
        onChanged: (val) {
          finding.fieldManagerStatements =
              _controllerFieldManagerStatements.text;
        },
      );

  TextFormField get buildObservations => TextFormField(
        validator: (val) {
          if (val!.isEmpty) {
            return "Gözlemler alanını doldurunuz.";
          }
        },
        controller: _controllerObservations,
        keyboardType: TextInputType.multiline,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLines: 5,
        decoration: InputDecoration(
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black26, width: 2.0),
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black26, width: 2.0),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onSaved: (val) {
          setState(() {
            finding.observations = _controllerObservations.text;
          });
        },
        onChanged: (val) {
          finding.observations = _controllerObservations.text;
        },
      );
}
