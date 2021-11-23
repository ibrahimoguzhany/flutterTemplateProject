import 'dart:io';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../core/base/view/base_view.dart';
import '../../../../../../../core/components/text/auto_locale.text.dart';
import '../../../../../../common/_product/_model/finding_file.dart';
import '../../../../../../common/_product/_widgets/big_little_text_widget.dart';
import '../../../../../../common/_widgets/button/button_widget.dart';
import '../../../../model/category_dd_model.dart';
import '../../../../model/unplanned_tour_model.dart';
import '../../module/actions_mustbetaken_text_form_field.dart';
import '../../module/actions_taken_in_field_text_form_field.dart';
import '../../module/field_manager_statements_text_form_field.dart';
import '../../module/finding_categories_multi_select_dropdown.dart';
import '../../module/finding_type_dropdown.dart';
import '../../module/observation_text_form_field.dart';
import '../../module/save_fab_button.dart';
import '../../viewmodel/subview_model/add_unplanned_tour_finding_view_model/add_unplanned_tour_finding_view_model.dart';

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

  late List<CategoryDDModel>? findingTypes;
  late List<String>? findingTypeNames;
  late List<String>? findingCategories;

  late final _controllerActionMustBeTaken;
  late final _controllerActionMustBeTakenInField;
  late final _controllerFieldManagerStatements;
  late final _controllerObservations;
  late final _formKey;

  @override
  void initState() {
    super.initState();
    finding = FindingModel();
    findingTypes = <CategoryDDModel>[];
    findingTypeNames = <String>[];
    findingCategories = <String>[];
    _controllerActionMustBeTaken = TextEditingController();
    _controllerActionMustBeTakenInField = TextEditingController();
    _controllerFieldManagerStatements = TextEditingController();
    _controllerObservations = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

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
        setState(() {
          findingTypes!.forEach((element) {
            findingTypeNames!.add(element.findingTypeStr!);
            findingTypeNames!.removeDuplicates();
            findingCategories!.add(element.name!);
          });
        });
      },
      onPageBuilder:
          (BuildContext context, AddUnPlannedTourFindingViewModel viewModel) =>
              Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: AutoLocaleText(
            value: "Plansız Tur Bulgu Ekleme Sayfası",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
        body: Observer(builder: (_) {
          return Container(
            child: viewModel.categoryList.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildLittleTextWidget("Bulgu Tipi"),
                            SizedBox(height: 5),
                            FindingTypeDropdown(
                                finding: finding, findingTypes: findingTypes),
                            SizedBox(height: 20),
                            buildLittleTextWidget("Kategori"),
                            SizedBox(height: 5),
                            FindingCategoriesMultiSelectDropdown(
                                finding: finding, viewModel: viewModel),
                            SizedBox(height: 10),
                            buildLittleTextWidget(
                                "Alınması Gereken Aksiyonlar"),
                            SizedBox(height: 5),
                            ActionsMustBeTakenTextFormField(
                              controllerActionMustBeTaken:
                                  _controllerActionMustBeTaken,
                              finding: finding,
                            ),
                            SizedBox(height: 20),
                            buildLittleTextWidget(
                                "Sahada Alınması Gereken Aksiyonlar"),
                            SizedBox(height: 5),
                            ActionsTakenInFieldTextFormField(
                                controllerActionMustBeTakenInField:
                                    _controllerActionMustBeTakenInField,
                                finding: finding),
                            SizedBox(height: 20),
                            buildLittleTextWidget("Gözlemler"),
                            SizedBox(height: 5),
                            ObservationsTextFormField(
                                controllerObservations: _controllerObservations,
                                finding: finding),
                            SizedBox(height: 20),
                            buildLittleTextWidget("Saha Yöneticisi Açıklaması"),
                            SizedBox(height: 5),
                            FieldManagerStatementsTextFormField(
                                controllerFieldManagerStatements:
                                    _controllerFieldManagerStatements,
                                finding: finding),
                            SizedBox(height: 20),
                            SaveFABButton(
                              formKey: _formKey,
                              tour: tour,
                              finding: finding,
                              viewModel: viewModel,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        }),
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
            },
            label: Text(
              basename(files![i].path),
              textAlign: TextAlign.center,
            )));
      }
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
}
