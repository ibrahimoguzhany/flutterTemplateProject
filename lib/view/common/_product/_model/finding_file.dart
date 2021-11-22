import 'dart:convert';
import 'dart:typed_data';

class FindingFile {
  Uint8List? fileBytes;
  String? contentType;
  String? filename;

  FindingFile({this.fileBytes, this.contentType, this.filename});

  FindingFile.fromJson(Map<String, dynamic> json) {
    fileBytes = base64Decode(json['fileBytes']);
    contentType = json['contentType'];
    filename = json['filename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileBytes'] = this.fileBytes;
    data['contentType'] = this.contentType;
    data['filename'] = this.filename;
    return data;
  }
}
