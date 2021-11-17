import 'dart:typed_data';

import 'package:flutter/material.dart';

class SingleFileView extends StatelessWidget {
  final Uint8List fileBytes;
  final String filename;
  final String contentType;
  const SingleFileView(
      {Key? key,
      required this.fileBytes,
      required this.filename,
      required this.contentType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dosya")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Dosya Adı: \n" + filename,
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(left: 31.5),
              alignment: Alignment.centerLeft,
              child: Text(
                "Dosya Türü: " + contentType,
              ),
            ),
            SizedBox(height: 50),
            Image.memory(fileBytes),
          ],
        ),
      ),
    );
  }
}
