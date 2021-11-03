import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../_product/_model/finding_file.dart';
import '../../model/unplanned_tour_model.dart';

class UnPlannedTourDetailService {
  static UnPlannedTourDetailService? _instance;
  static UnPlannedTourDetailService? get instance {
    if (_instance == null) _instance = UnPlannedTourDetailService._init();
    return _instance;
  }

  UnPlannedTourDetailService._init();

  final _addFindingURL =
      "http://esdmobil.demos.arfitect.net/api/services/app/Tours/CreateFindingForTour";

  final _deleteFindingURL =
      "http://esdmobil.demos.arfitect.net/api/services/app/Tours/CreateFindingForTour";

  final _findingFilesURL =
      "http://esdmobil.demos.arfitect.net/api/services/app/Tours/GetFindingFiles";

  final _uploadFileToFindingURL =
      "http://esdmobil.demos.arfitect.net/api/services/app/Tours/UploadFiles";

  Future<UnplannedTourModel?> addFinding(
    FindingModel finding,
    String tourId,
  ) async {
    final response = await http.post(
      Uri.parse(_addFindingURL + "?tourId=" + tourId),
      body: json.encode(finding),
      headers: {
        "Content-Type": "application/json-patch+json",
      },
    );
    print(response.body);
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await json.decode(response.body)["result"];
        return UnplannedTourModel.fromJson(responseBody);
      default:
        return null;
    }
  }

  Future<bool> deleteFinding(int findingId) async {
    final response = await http.post(
      Uri.parse(_deleteFindingURL),
      body: json.encode(findingId),
    );
    if (response.statusCode == HttpStatus.ok) {
      return true;
    }
    return false;
  }

  // UploadTask? uploadFile(String destination, File file) {
  //   try {
  //     final ref = FirebaseStorage.instance.ref(destination);

  //     return ref.putFile(file);
  //   } on FirebaseException catch (e) {
  //     return null;
  //   }
  // }

  // UploadTask? uploadBytes(String destination, Uint8List data) {
  //   try {
  //     final ref = FirebaseStorage.instance.ref(destination);

  //     return ref.putData(data);
  //   } on FirebaseException catch (e) {
  //     return null;
  //   }
  // }

  Future<List<FindingFile>?> getFindingFiles(int findingId) async {
    final response = await http.post(
        Uri.parse(_findingFilesURL + "?findingId=$findingId"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(findingId));
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await json.decode(response.body)["result"];
        print(responseBody);

        if (responseBody is List) {
          return responseBody.map((e) => FindingFile.fromJson(e)).toList();
        }
        return Future.error(responseBody);
    }
    print(response);
    return Future.error(response);
  }

//   uploadFiles(int findingId, List<FindingFile> findingFiles) async {
//     var stream = http.ByteStream()
//     //  ?findingId=7
//     final response = await http.MultipartRequest(
//         "POST", Uri.parse(_uploadFileToFindingURL + "?findingId=$findingId"))
//         ...findingFiles.add(http.MultipartFile("UploadedFile", stream, lenght, ))
//   }
// }

// Future<Uint8List> loadFilesBytes(int findingId) async {
//   var bytesResponse = await http.post(Uri.parse(_findingFilesURL),
//       body: json.encode(findingId));
//   if (bytesResponse.statusCode != 200) {
//     throw Exception("something went wrong");
//   }
//   var bytes = bytesResponse.bodyBytes;
//   return bytes;
// }
}
