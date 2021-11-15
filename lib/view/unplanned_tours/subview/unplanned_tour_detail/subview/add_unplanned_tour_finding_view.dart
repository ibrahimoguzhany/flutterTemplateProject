import 'dart:io';

import 'package:esd_mobil/view/unplanned_tours/subview/unplanned_tour_detail/subview/unplanned_tour_finding_detail_view.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/components/text/auto_locale.text.dart';
import '../../../../_product/_model/finding_file.dart';
import '../../../../_widgets/button/button_widget.dart';
import '../../../model/category_dd_model.dart';
import '../../../model/unplanned_tour_model.dart';
import '../view/unplanned_tour_detail_view.dart';
import '../viewmodel/subview_model/add_unplanned_tour_finding_view_model.dart';

class AddUnPlannedTourFindingView extends StatefulWidget {
  const AddUnPlannedTourFindingView({Key? key}) : super(key: key);

  @override
  _AddUnPlannedTourFindingViewState createState() =>
      _AddUnPlannedTourFindingViewState();
}

class _AddUnPlannedTourFindingViewState
    extends State<AddUnPlannedTourFindingView> {
  late FindingModel finding;
  UploadTask? task;
  File? file;
  List<FindingFile> findingFiles = [];

  List<File>? files = <File>[];

  List<CategoryDDModel>? findingTypes = <CategoryDDModel>[];
  List<String>? findingTypeNames = <String>[];
  List<String>? findingCategories = <String>[];

  @override
  void initState() {
    super.initState();
    finding = FindingModel();
  }

  final _controllerActionMustBeTaken = TextEditingController();
  final _controllerActionMustBeTakenInField = TextEditingController();
  final _controllerFieldManagerStatements = TextEditingController();
  final _controllerObservations = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UnplannedTourModel tour =
        ModalRoute.of(context)!.settings.arguments as UnplannedTourModel;

    return BaseView<AddUnPlannedTourFindingViewModel>(
      viewModel: AddUnPlannedTourFindingViewModel(),
      onModelReady: (AddUnPlannedTourFindingViewModel model) async {
        model.setContext(context);
        await model.init();

        findingTypes = (await model.getCategories())?.cast<CategoryDDModel>();
        // print(findingTypes);
        setState(() {
          findingTypes!.forEach((element) {
            findingTypeNames!.add(element.findingTypeStr!);
            findingTypeNames!.removeDuplicates();
            findingCategories!.add(element.name!);
          });
          // print(findingTypeNames);
          // print(findingCategories);
        });
      },
      onPageBuilder:
          (BuildContext context, AddUnPlannedTourFindingViewModel viewModel) =>
              Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: AutoLocaleText(
            style: TextStyle(fontSize: 18),
            value: "Plansız Tur Bulgu Ekleme Sayfası",
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildLittleTextWidget("Bulgu Tipi"),
                  SizedBox(height: 5),
                  buildFindingTypeDropdown,
                  SizedBox(height: 20),
                  buildLittleTextWidget("Kategori"),
                  SizedBox(height: 5),
                  buildFindingCategoryMultiSelectDropdown(viewModel),
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
                  FloatingActionButton.extended(
                    label: Text("Kaydet"),
                    onPressed: () async {
                      final isValid = _formKey.currentState!.validate();
                      if (isValid) {
                        tour.findings!.add(finding);
                        _formKey.currentState!.save();
                        final refreshedFinding =
                            await viewModel.createFindingFourTour(
                                finding, context, tour.id.toString());

                        if (refreshedFinding != null) {
                          // Navigator.of(context).pop();
                          final snackBar = SnackBar(
                            content: Text(
                                "Bulgu başarıyla oluşturuldu. Dosyalarınızı ekleyebilirsiniz."),
                            backgroundColor: Colors.green,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                settings:
                                    RouteSettings(arguments: refreshedFinding),
                                builder: (_) =>
                                    UnplannedTourFindingDetailView()),
                          );
                        } else {
                          final snackBar = SnackBar(
                            content: Text("Hata!!!"),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration buildFileBoxDecoration() {
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
              findingFiles
                  .add(FindingFile(fileBytes: takenPhoto.readAsBytesSync()));
            });
          },
        ),
        SizedBox(height: 8),
        // Text(
        //   fileName,
        //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        // ),
        // SizedBox(height: 24),
        // ButtonWidget(
        //   text: 'Yükle',
        //   icon: Icons.cloud_upload_outlined,
        //   onClicked: () async {
        //     // viewModel.uploadFiles(findingFiles, finding.id!);
        //   },
        // ),
        // SizedBox(height: 20),
        // files!.isNotEmpty
        //     ? SingleChildScrollView(
        //         child: Column(
        //           children: addedFilesWidgets(viewModel),
        //         ),
        //       )
        //     : Container(),
        // SizedBox(height: 10),
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
              await launch(findingFiles[i].filename.toString());
            },
            onDeleted: () {
              setState(() {
                widgets.removeWhere((element) =>
                    element.label == Text(basename(files![i].path)));
                widgets.join(",");
                files!.removeWhere((element) => element.path == files![i].path);
                files!.join(",");
              });
              // print(widgets);
            },
            label: Text(
              basename(files![i].path),
              textAlign: TextAlign.center,
            )));
      }
      // print(widgets);
    }
    return widgets;
  }

  Future selectFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result == null) return;

    for (var i = 0; i < result.files.length; i++) {
      final path = result.files[i].path!;
      // files!.add(File(path));
      final filename = result.files[i].name;
      final fileBytes = await File(path).readAsBytes();
      findingFiles.add(FindingFile(fileBytes: fileBytes, filename: filename));
      print(findingFiles[i].fileBytes);
      print(findingFiles[i].filename);
    }
    setState(() {});
  }

  Widget buildFindingCategoryMultiSelectDropdown(
      AddUnPlannedTourFindingViewModel viewModel) {
    return Observer(builder: (_) {
      return MultiSelectDialogField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (val) {
          if (val == null) {
            return "Bu alan boş bırakılamaz.";
          }
        },
        items: viewModel.categoryList,
        title: Text("Kategori"),
        selectedColor: Colors.blue,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          border: Border.all(
            width: 1,
          ),
        ),
        buttonIcon: Icon(
          Icons.connect_without_contact_outlined,
        ),
        buttonText: Text(
          "Kategori",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.values[4],
          ),
        ),
        onConfirm: (List<CategoryDDModel?>? results) {
          List<int> resultIds = <int>[];
          List<String> resultNames = <String>[];
          results!.forEach((item) {
            resultIds.add(item!.id!);
            resultNames.add(item.name!);
          });
          setState(() {
            finding.categoryIds = resultIds;
            finding.categoryNames = resultNames.join(";");
          });
        },
      );
    });
  }

  Widget get buildFindingTypeDropdown =>
      DropdownButtonFormField<CategoryDDModel>(
        validator: (val) {
          if (val == null) {
            return "Bulgu Türü alanı boş bırakılamaz.";
          }
        },
        itemHeight: 48,
        hint: Text('Bulgu Tipi'),
        value: finding.findingCategory,
        icon: const Icon(
          Icons.arrow_downward,
          color: Colors.black38,
        ),
        isExpanded: true,
        iconSize: 24,
        elevation: 20,
        onChanged: (CategoryDDModel? newCategoryModel) {
          setState(() {
            finding.findingType = newCategoryModel!.findingType;
            finding.findingCategory = newCategoryModel;
            finding.findingTypeStr = newCategoryModel.findingTypeStr;
          });
        },
        items: findingTypes
            ?.map<DropdownMenuItem<CategoryDDModel>>((CategoryDDModel? value) {
          return DropdownMenuItem<CategoryDDModel>(
            value: value,
            child: Text(value!.findingTypeStr!),
          );
        }).toList(),
      );

  TextFormField get buildActionsMustBeTaken => TextFormField(
        validator: (val) {
          if (val != null && val.isEmpty) {
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
            finding.actionsShouldBeTaken = _controllerActionMustBeTaken.text;
          });
        },
        onChanged: (val) {
          finding.actionsShouldBeTaken = _controllerActionMustBeTaken.text;
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
            finding.actionsTakenRightInTheField =
                _controllerActionMustBeTakenInField.text;
          });
        },
        onChanged: (val) {
          finding.actionsTakenRightInTheField =
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
            finding.fieldResponsibleExplanation =
                _controllerFieldManagerStatements.text;
          });
        },
        onChanged: (val) {
          finding.fieldResponsibleExplanation =
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

Widget buildLittleTextWidget(String? title) {
  if (title == null) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  return AutoLocaleText(
    value: title,
    style: TextStyle(
        fontSize: 12,
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.w800),
  );
}
