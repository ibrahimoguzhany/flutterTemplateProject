import 'package:flutter/material.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/text/auto_locale.text.dart';
import '../../../_product/_widgets/little_text_widget.dart';
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
  List<String> findingTypes = ['Emniyetsiz Durum', "Emniyetsiz Davranış"];
  List<String> findingCategories = [
    'Kaygan Zemin',
    "Yüksek Sıcaklık",
    "Baretsiz Çalışma",
    "Uykusuz Çalışma"
  ];

  FindingModel? finding = FindingModel();

  @override
  Widget build(BuildContext context) {
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
              TextField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), labelText: "Dosya"),
                onChanged: (val) {
                  finding!.file = val;
                },
              ),
              SizedBox(height: 10),
              FloatingActionButton.extended(
                onPressed: () async {
                  final isValid = _formKey.currentState!.validate();
                  if (isValid) {
                    _formKey.currentState!.save();
                    await viewModel.addFinding(finding!, context, tour.key);
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

  Padding get buildFindingCategoryDropdown => Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: DropdownButtonFormField<String>(
          validator: (val) {
            if (val != null) {
              return "Kategori alanı boş bırakılamaz.";
            }
          },
          hint: Text('Bulgu Türü'),
          value: finding!.category,
          icon: const Icon(
            Icons.arrow_downward,
            color: Colors.black38,
          ),
          iconSize: 24,
          elevation: 20,
          onChanged: (String? newValue) {
            setState(() {
              finding!.category = newValue!;
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
            if (val != null) {
              return "Bulgu Türü alanı boş bırakılamaz.";
            }
          },
          hint: Text('Bulgu Türü'),
          value: finding!.findingType,
          icon: const Icon(
            Icons.arrow_downward,
            color: Colors.black38,
          ),
          iconSize: 24,
          elevation: 20,
          onChanged: (String? newValue) {
            setState(() {
              finding!.findingType = newValue!;
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
          if (val == null) {
            return "Lütfen alınması gereken aksiyonlar alanını doldurunuz.";
          }
        },
        keyboardType: TextInputType.multiline,
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
        onChanged: (val) {
          finding!.actionsMustBeTaken = val;
        },
      );

  TextFormField get buildActionTakenInField => TextFormField(
        validator: (val) {
          if (val == null) {
            return "Lütfen sahada alınması gereken aksiyonlar alanını doldurunuz.";
          }
        },
        keyboardType: TextInputType.multiline,
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
        onChanged: (val) {
          finding!.actionsTakenInField = val;
        },
      );

  TextFormField get buildFieldManagerStatements => TextFormField(
        validator: (val) {
          if (val == null) {
            return "Lütfen Saha Yöneticisi Açıklaması alanını doldurunuz.";
          }
        },
        keyboardType: TextInputType.multiline,
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
        onChanged: (val) {
          finding!.fieldManagerStatements = val;
        },
      );

  TextFormField get buildObservations => TextFormField(
        validator: (val) {
          if (val == null) {
            return "Gözlemler alanını doldurunuz.";
          }
        },
        keyboardType: TextInputType.multiline,
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
        onChanged: (val) {
          finding!.observations = val;
        },
      );
}
