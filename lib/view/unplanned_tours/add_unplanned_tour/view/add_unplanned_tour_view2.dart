// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_number_picker/flutter_number_picker.dart';
// // import 'package:(mult)i_select_flutter/dialog/(multi_select_dialog_field.dart';
// // import 'package:(mult)i_select_flutter/util/(multi_select_item.dart';
// import 'package:esd_mobil/core/extensions/context_extension.dart';
// import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
// import 'package:multi_select_flutter/util/multi_select_item.dart';

// import '../../../../core/base/view/base_view.dart';
// import '../../../../core/components/text/auto_locale.text.dart';
// import '../model/unplanned_tour_model.dart';
// import '../model/tour_accompanies_dd_model.dart';
// import '../model/tour_team_members_model.dart';
// import '../viewmodel/add_unplanned_tour_view_model.dart';
// import 'package:intl/intl.dart';

// class AddUnPlannedTourView2 extends StatefulWidget {
//   const AddUnPlannedTourView2({Key? key}) : super(key: key);

//   @override
//   _AddUnPlannedTourViewState createState() => _AddUnPlannedTourViewState();
// }

// class _AddUnPlannedTourViewState extends State<AddUnPlannedTourView2> {
//   FocusNode _focusNodeObservedPositiveFindings = new FocusNode();
//   late UnPlannedTourModel tour;
//   String? dropdownValue;
//   late TextEditingController _datePickerController;

//   static List<TourAccompaniesDDModel> _tourAccompaniesList = [
//     TourAccompaniesDDModel(1, "Oğuzhan Yılmaz"),
//     TourAccompaniesDDModel(2, "Ercan Tırman"),
//     TourAccompaniesDDModel(3, "Gülden Kelez"),
//     TourAccompaniesDDModel(4, "Buse Kara"),
//   ];

//   static List<TourTeamMembersDDModel> _tourTeamMembers = [
//     TourTeamMembersDDModel(1, "Oğuzhan Yılmaz"),
//     TourTeamMembersDDModel(2, "Ercan Tırman"),
//     TourTeamMembersDDModel(3, "Gülden Kelez"),
//     TourTeamMembersDDModel(4, "Buse Kara"),
//   ];
//   final _itemsTourAccompanies = _tourAccompaniesList
//       .map(
//         (accompany) =>
//             MultiSelectItem<TourAccompaniesDDModel>(accompany, accompany.name),
//       )
//       .toList();

//   final _itemsTourTeamMembers = _tourTeamMembers
//       .map((teamMember) =>
//           MultiSelectItem<TourTeamMembersDDModel>(teamMember, teamMember.name))
//       .toList();
//   @override
//   void initState() {
//     super.initState();
//     _datePickerController =
//         TextEditingController(text: DateTime.now().toString());

//     DateTime now = DateTime.now();
//     String formattedDate = DateFormat('yyyy-MM-dd').format(now);
//     tour = UnPlannedTourModel(
//         location: "",
//         field: "",
//         tourTeamMembers: [],
//         tourAccompanies: [],
//         tourDate: formattedDate,
//         fieldOrganizationScore: "0",
//         observedPositiveFindings: "",
//         key: "");
//   }

//   var _controllerPositiveFindings = TextEditingController();

//   final _formKey = GlobalKey<FormBuilderState>();

//   @override
//   Widget build(BuildContext context) {
//     return BaseView<AddUnPlannedTourViewModel>(
//       viewModel: AddUnPlannedTourViewModel(),
//       onModelReady: (AddUnPlannedTourViewModel model) {
//         model.setContext(context);
//         model.init();
//       },
//       onPageBuilder: (BuildContext context,
//               AddUnPlannedTourViewModel viewModel) =>
//           Scaffold(
//               appBar: AppBar(
//                 title: Text("Plansız Tur Ekleme Sayfası"),
//               ),
//               body: FormBuilder(
//                 key: _formKey,
//                 child: Padding(
//                   padding: context.paddingNormalAll,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         buildLittleTextWidget("Lokasyon"),
//                         buildSingleDropdown(tour.location,
//                             ["Istanbul", "Izmir", "Ankara", "Bursa"]),
//                         SizedBox(height: 20),
//                         buildLittleTextWidget("Saha"),
//                         buildSingleDropdown(tour.field, [
//                           "Istanbul Rafineri",
//                           "Izmir Rafineri",
//                           "Ankara Rafineri",
//                           "Bursa Rafineri"
//                         ]),
//                         SizedBox(height: 20),
//                         buildLittleTextWidget("Tura Eşlik Edenler"),
//                         buildTourAccompaniesMultiDropdownField(
//                             _tourAccompaniesList, "Tura Eşlik Edenler"),
//                         SizedBox(height: 20),
//                         buildLittleTextWidget("Ekip Üyeleri"),
//                         buildTourAccompaniesMultiDropdownField(
//                             _tourTeamMembers, "Ekip Üyeleri"),
//                         SizedBox(height: 20),
//                         buildLittleTextWidget("Tur Tarihi"),
//                         buildDateTimePicker(),
//                         SizedBox(height: 20),
//                         buildLittleTextWidget("Saha Tertip Skoru"),
//                         buildFieldOrganizationScoreField,
//                         SizedBox(height: 20),
//                         buildLittleTextWidget("Gözlenen Pozitif Bulgular"),
//                         buildObservedPositiveFinding,
//                         FloatingActionButton.extended(
//                           label: Text("Kaydet"),
//                           onPressed: () async {
//                             FocusScope.of(context).unfocus();
//                             final isValid = _formKey.currentState!.validate();
//                             if (isValid) {
//                               _formKey.currentState!.save();
//                               await viewModel.addUnPlannedTour(tour, context);
//                               Navigator.pop(context);
//                               final snackBar = SnackBar(
//                                 content: Text("Plansız Tur başarıyla eklendi."),
//                                 backgroundColor: Colors.green,
//                               );
//                               ScaffoldMessenger.of(context)
//                                   .showSnackBar(snackBar);
//                             } else {
//                               final snackBar = SnackBar(
//                                 content:
//                                     Text("Lütfen gerekli alanları doldurunuz."),
//                                 backgroundColor: Colors.red,
//                               );
//                               ScaffoldMessenger.of(context)
//                                   .showSnackBar(snackBar);
//                             }
//                           },
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               )),
//     );
//   }

//   FormBuilderTextField get buildObservedPositiveFinding => FormBuilderTextField(
//         focusNode: _focusNodeObservedPositiveFindings,
//         validator: (val) {
//           if (val == null) {
//             return "Lütfen alınması gereken aksiyonlar alanını doldurunuz.";
//           }
//         },
//         name: 'Gözlenen Pozitif Bulgular',
//         controller: _controllerPositiveFindings,
//         keyboardType: TextInputType.multiline,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         maxLines: 5,
//         onSaved: (val) {
//           tour.observedPositiveFindings = _controllerPositiveFindings.text;
//         },
//       );

//   FormBuilderDateTimePicker buildDateTimePicker() {
//     return FormBuilderDateTimePicker(
//       validator: (val) {
//         if (val == null) {
//           return "Bu alan boş bırakılamaz";
//         }
//       },
//       format: DateFormat('yyyy-MM-dd'),
//       firstDate: DateTime.now().subtract(Duration(days: 365)),
//       lastDate: DateTime.now().add(Duration(days: 365)),
//       name: "Tur Tarihi",
//       controller: _datePickerController,
//       enabled: true,
//       onChanged: (selectedDate) {
//         if (selectedDate != null) {
//           tour.tourDate = selectedDate.toString();
//         }
//       },
//     );
//   }

//   FormBuilderDropdown<String> buildSingleDropdown(
//       String field, List<String> items) {
//     return FormBuilderDropdown(
//       validator: (val) {
//         if (val == null) {
//           return "Bu alan boş bırakılamaz";
//         }
//       },
//       icon: const Icon(
//         Icons.arrow_downward,
//       ),
//       name: "Lokasyon",
//       onSaved: (val) {
//         setState(() {
//           field = val.toString();
//         });
//       },
//       onChanged: (val) {
//         setState(() {
//           field = val.toString();
//         });
//       },
//       decoration: InputDecoration(),
//       items: items.map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           child: Text(value),
//           value: value,
//         );
//       }).toList(),
//     );
//   }

//   Widget buildLittleTextWidget(String title) {
//     return AutoLocaleText(
//       value: title,
//       style: TextStyle(
//           fontSize: 12,
//           decoration: TextDecoration.underline,
//           fontWeight: FontWeight.w800),
//     );
//   }

//   MultiSelectDialogField<TourAccompaniesDDModel>
//       buildTourAccompaniesMultiDropdownField(
//           List<dynamic>? results, String title) {
//     return MultiSelectDialogField(
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       validator: (val) {
//         if (val == null) {
//           return "Bu alan boş bırakılamaz.";
//         }
//       },
//       items: _itemsTourAccompanies,
//       title: Text(title),
//       // autovalidateMode: AutovalidateMode.onUserInteraction,
//       selectedColor: Colors.blue,
//       decoration: BoxDecoration(
//         // color: Colors.black26.withOpacity(0.1),4

//         borderRadius: BorderRadius.all(
//           Radius.circular(5),
//         ),

//         border: Border.all(color: Colors.black26, width: 2),
//       ),
//       buttonIcon: Icon(
//         Icons.work_rounded,
//         color: Colors.black26,
//       ),
//       buttonText: Text(
//         title,
//         style: TextStyle(
//           // color: Colors.blue[800],
//           color: Colors.black54,
//           fontSize: 16,
//           fontWeight: FontWeight.values[4],
//         ),
//       ),
//       onConfirm: (List<dynamic> results) {
//         List<Map<String, dynamic>> result = <Map<String, dynamic>>[];
//         results.forEach((item) {
//           result.add(item.toJson());
//         });
//         setState(() {
//           tour.tourAccompanies = result;
//         });
//       },
//     );
//   }

//   Center get buildFieldOrganizationScoreField => Center(
//         child: CustomNumberPicker(
//           initialValue: 0,
//           maxValue: 100,
//           minValue: 0,
//           step: 1,
//           onValue: (value) {
//             setState(() {
//               tour.fieldOrganizationScore = value.toString();
//             });
//           },
//         ),
//       );
// }
