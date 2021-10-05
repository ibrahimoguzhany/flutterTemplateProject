import 'dart:io';

import 'package:esd_mobil/core/extensions/context_extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:esd_mobil/view/unplanned_tours/add_unplanned_tour/model/unplanned_tour_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/text/auto_locale.text.dart';
import '../../../_product/_widgets/big_little_text_widget.dart';
import '../../../_widgets/button/button_widget.dart';
import '../../../home/home_esd/model/finding_model.dart';
import '../viewmodel/add_unplanned_tour_finding_view_model.dart';

class AddUnPlannedTourFindingView extends StatefulWidget {
  const AddUnPlannedTourFindingView({Key? key}) : super(key: key);

  @override
  _AddUnPlannedTourFindingViewState createState() =>
      _AddUnPlannedTourFindingViewState();
}

class _AddUnPlannedTourFindingViewState
    extends State<AddUnPlannedTourFindingView> {
  UploadTask? task;
  File? file;

  List<File>? files = <File>[];

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
    UnPlannedTourModel tour =
        ModalRoute.of(context)!.settings.arguments as UnPlannedTourModel;

    final _formKey = GlobalKey<FormState>();

    return BaseView<AddUnPlannedTourFindingViewModel>(
      viewModel: AddUnPlannedTourFindingViewModel(),
      onModelReady: (AddUnPlannedTourFindingViewModel model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder:
          (BuildContext context, AddUnPlannedTourFindingViewModel viewModel) =>
              Scaffold(
        appBar: AppBar(
          title: AutoLocaleText(
            style: TextStyle(fontSize: 18),
            value: "Plansız Tur Bulgu Ekleme Sayfası ",
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
              buildLittleTextWidget("Gözlemler"),
              SizedBox(height: 5),
              buildObservations,
              SizedBox(height: 20),
              buildLittleTextWidget("Saha Yöneticisi Açıklaması"),
              SizedBox(height: 5),
              buildFieldManagerStatements,
              SizedBox(height: 20),
              buildLittleTextWidget("Dosya"),
              Container(
                padding:
                    EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 0),
                decoration: buildFileBixDecoration(),
                margin: EdgeInsets.all(10),
                child: buildButtonWidgets(viewModel, context),
              ),
              FloatingActionButton.extended(
                onPressed: () async {
                  final isValid = _formKey.currentState!.validate();
                  if (isValid) {
                    _formKey.currentState!.save();
                    await viewModel.addFinding(finding, context, tour.key!);
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

  BoxDecoration buildFileBixDecoration() {
    return BoxDecoration(
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
        borderRadius: BorderRadius.circular(3));
  }

  Column buildButtonWidgets(
      AddUnPlannedTourFindingViewModel viewModel, BuildContext context) {
    return Column(
      children: [
        ButtonWidget(
          text: 'Dosya Seç',
          icon: Icons.attach_file,
          onClicked: selectFile,
        ),
        SizedBox(height: 8),
        ButtonWidget(
          text: 'Resim Çek',
          icon: Icons.photo_camera,
          onClicked: () async {
            File takenPhoto = (await viewModel.pickImage(ImageSource.camera))!;

            setState(() {
              files!.add(takenPhoto);
            });
          },
        ),
        SizedBox(height: 8),
        // Text(
        //   fileName,
        //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        // ),
        SizedBox(height: 24),
        ButtonWidget(
          text: 'Yükle',
          icon: Icons.cloud_upload_outlined,
          onClicked: () async {
            finding.imageUrl = finding.toMap(await uploadFiles(files!));
            if (files!.isNotEmpty && finding.imageUrl!.isNotEmpty) {
              viewModel.changeIsUploaded();
              final snackBar = SnackBar(
                backgroundColor: Colors.green[600],
                content: Text("Seçilen Dosyalar Başarıyla Yüklendi"),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
        ),
        SizedBox(height: 20),
        // task != null ? buildUploadStatus(task!) : Container(),
        files!.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  children: addedFilesWidgets(viewModel),
                ),
              )
            : Container(),
        SizedBox(height: 10),
      ],
    );
  }

  List<InputChip> addedFilesWidgets(
      AddUnPlannedTourFindingViewModel viewModel) {
    List<InputChip> widgets = <InputChip>[];
    if (files!.isNotEmpty) {
      for (var i = 0; i < files!.length; i++) {
        widgets.add(InputChip(
            onPressed: () async {
              await launch(files![i].uri.toString(), forceWebView: false);
            },
            onDeleted: () {
              setState(() {
                widgets.removeWhere((element) =>
                    element.label == Text(basename(files![i].path)));
                widgets.join(",");
                files!.removeWhere((element) => element.path == files![i].path);
                files!.join(",");
              });
              print(widgets);
            },
            label: Text(
              basename(files![i].path),
              textAlign: TextAlign.center,
            )));
      }
      print(widgets);
    }
    return widgets;
  }

  // List<Widget>? addedFilesListView(AddUnPlannedTourFindingViewModel viewModel) {
  //   // List<Observer> widgets = <Observer>[];
  //   if (files!.isNotEmpty) {
  //     ListView.builder(
  //         itemCount: files!.length,
  //         itemBuilder: (context, index) {
  //           return InputWidgets(
  //             isUploaded: viewModel.isUploaded,
  //             onDelete: () {
  //               setState(() {
  //                 files!.removeWhere(
  //                     (element) => element.path == files![index].path);
  //                 files!.join(",");
  //               });
  //             },
  //             text: Text(
  //               basename(files![index].path),
  //               textAlign: TextAlign.center,
  //             ),
  //           );
  //         });
  //   }
  //   return <Container>[];
  // }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result == null) return;

    for (var i = 0; i < result.files.length; i++) {
      final path = result.files[i].path!;
      files!.add(File(path));
    }
    setState(() {});
  }

  Future<String> uploadFile(File _image) async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child('files/${_image.path}');
    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.whenComplete(() => null);

    return await storageReference.getDownloadURL();
  }

  Future<List<String>> uploadFiles(List<File> _images) async {
    var imageUrls =
        await Future.wait(_images.map((_image) => uploadFile(_image)));
    print(imageUrls);
    return imageUrls;
  }

  // void _launchURL(AddUnPlannedTourFindingViewModel vm) async =>
  //     await canLaunch(vm.imageUrl!)
  //         ? await launch(vm.imageUrl!)
  //         : throw '${vm.imageUrl!} başlatılamadı.';

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
        readOnly: true,
        enabled: false,
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

// class InputWidgets extends StatefulWidget {
//   final Text text;
//   final VoidCallback onDelete;
//   final bool isUploaded;

//   const InputWidgets(
//       {Key? key,
//       required this.text,
//       required this.onDelete,
//       required this.isUploaded})
//       : super(key: key);

//   @override
//   _InputWidgetsState createState() => _InputWidgetsState();
// }

// class _InputWidgetsState extends State<InputWidgets> {
//   @override
//   Widget build(BuildContext context) {
//     return InputChip(
//       label: widget.text,
//       onDeleted: widget.onDelete,
//       backgroundColor: widget.isUploaded ? Colors.greenAccent : Colors.black26,
//     );
//   }
// }
