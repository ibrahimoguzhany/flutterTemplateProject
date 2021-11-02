import 'package:esd_mobil/core/constants/image/image_constants.dart';
import 'package:flutter/material.dart';

class ConfirmationDetailView extends StatelessWidget {
  const ConfirmationDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 24.0, left: 48),
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
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                            Table(
                              border: TableBorder.all(
                                  color: Colors.white10,
                                  style: BorderStyle.solid),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              defaultColumnWidth: FixedColumnWidth(
                                  MediaQuery.of(context).size.width / 2.2),
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
                                  Column(children: [
                                    Text('STAD',
                                        style: TextStyle(color: Colors.white))
                                  ]),
                                ]),
                                TableRow(children: [
                                  Column(children: [
                                    Text('Ünite:',
                                        style: TextStyle(color: Colors.white))
                                  ]),
                                  Column(children: [
                                    Text('Terminal A',
                                        style: TextStyle(color: Colors.white))
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
                                    Text('Lorem Ipsum',
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
                                    Text('Lorem Ipsum',
                                        style: TextStyle(color: Colors.white))
                                  ]),
                                ]),
                                TableRow(children: [
                                  Column(children: [
                                    Text('Emniyet Sistemi Tipi',
                                        style: TextStyle(color: Colors.white))
                                  ]),
                                  Column(children: [
                                    Text('Yangın ve Gaz',
                                        style: TextStyle(color: Colors.white))
                                  ]),
                                ]),
                                TableRow(children: [
                                  Column(children: [
                                    Text('Trip Parametre Tag No',
                                        style: TextStyle(color: Colors.white))
                                  ]),
                                  Column(children: [
                                    Text('Algılama',
                                        style: TextStyle(color: Colors.white))
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
                                    Text('2 saat',
                                        style: TextStyle(color: Colors.white))
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
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                          side: BorderSide(color: Colors.red),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                    icon: Icon(Icons.check_circle_outline),
                                    label: Text("Accept")),
                                TextButton.icon(
                                    style: ButtonStyle(
                                        fixedSize: MaterialStateProperty.all(
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
                                                side:
                                                    BorderSide(color: Colors.red)))),
                                    onPressed: () {},
                                    icon: Icon(Icons.close),
                                    label: Text("Deny"))
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
