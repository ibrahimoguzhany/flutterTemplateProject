import 'package:esd_mobil/view/confirmation_inbox/model/confirmation_model.dart';
import 'package:flutter/material.dart';

class BuildTable extends StatelessWidget {
  final ConfirmationModel model;
  const BuildTable({
    Key? key,
    required this.model,
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
            Text(model.formCreator ?? '',
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
          Column(children: [
            Text(model.company ?? '', style: TextStyle(color: Colors.white))
          ]),
        ]),
        TableRow(children: [
          Column(children: [
            Text('Ünite:', style: TextStyle(color: Colors.white))
          ]),
          Column(children: [
            Text(model.unit ?? '', style: TextStyle(color: Colors.white))
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
            Text(model.safetySystemStatement ?? '',
                style: TextStyle(color: Colors.white))
          ]),
        ]),
        TableRow(children: [
          Column(children: [
            Text('By-pass Nedeni',
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white))
          ]),
          Column(children: [
            Text(model.bypassReason ?? '',
                style: TextStyle(color: Colors.white))
          ]),
        ]),
        TableRow(children: [
          Column(children: [
            Text('Emniyet Sistemi Tipi', style: TextStyle(color: Colors.white))
          ]),
          Column(children: [
            Text(model.safetySystemType ?? '',
                style: TextStyle(color: Colors.white))
          ]),
        ]),
        TableRow(children: [
          Column(children: [
            Text('Trip Parametre Tag No', style: TextStyle(color: Colors.white))
          ]),
          Column(children: [
            Text(model.tripParameterTagNo ?? '',
                style: TextStyle(color: Colors.white))
          ]),
        ]),
        TableRow(children: [
          Column(children: [
            Text('Emniyet Sistemi Alt Tipi',
                style: TextStyle(color: Colors.white))
          ]),
          Column(children: [
            Text(model.safetySystemSubType ?? '',
                style: TextStyle(color: Colors.white)),
          ]),
        ]),
        TableRow(children: [
          Column(children: [
            Text("Tahmini By-Pass Süresi",
                style: TextStyle(color: Colors.white))
          ]),
          Column(children: [
            Text(model.estimatedBypassTime ?? '',
                style: TextStyle(color: Colors.white))
          ]),
        ]),
        TableRow(children: [
          Column(children: [
            Text("By-Pass'a Alan Kişiler",
                style: TextStyle(color: Colors.white))
          ]),
          Column(children: [
            Text(model.peopleWhoBypass ?? '',
                style: TextStyle(color: Colors.white))
          ]),
        ]),
      ],
    );
  }
}
