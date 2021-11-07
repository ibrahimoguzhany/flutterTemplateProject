import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import '../../../../../core/constants/app/network_constants.dart';
import '../../../../../product/enum/unplannedtours_url_enum.dart';
import '../../../../_product/_model/finding_file.dart';
import '../../../model/unplanned_tour_model.dart';
import 'package:esd_mobil/view/unplanned_tours/service/unplanned_tour_service.dart';

class UnPlannedTourDetailService {
  static UnPlannedTourDetailService? _instance;
  static UnPlannedTourDetailService? get instance {
    if (_instance == null) _instance = UnPlannedTourDetailService._init();
    return _instance;
  }

  UnPlannedTourDetailService._init();

  final dio = Dio(BaseOptions(
      baseUrl: NetworkConstants.BASE_URL,
      headers: {"Content-Type": "application/json-patch+json"}));

  Future<UnplannedTourModel?> addFinding(
    FindingModel finding,
    String tourId,
  ) async {
    final response = await dio.post(
        UnplannedTourDetailURLs.CreateFindingForTour.rawValue,
        data: json.encode(finding),
        queryParameters: {"tourId": "$tourId"});
    print(response.data);
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await response.data["result"];
        return UnplannedTourModel.fromJson(responseBody);
      default:
        return null;
    }
  }

  Future<UnplannedTourModel?> deleteFinding(int findingId, int tourId) async {
    final response = await dio.post(
        UnplannedTourDetailURLs.RemoveFindingFromTour.rawValue,
        queryParameters: {"findingId": "$findingId"});
    if (response.statusCode == HttpStatus.ok) {
      final refreshedTour = UnPlannedTourService.instance!.getTourById(tourId);
      return refreshedTour;
    }
    return null;
  }

  Future<List<FindingFile>?> getFindingFiles(int findingId) async {
    final response = await dio.post(
        UnplannedTourDetailURLs.GetFindingFiles.rawValue,
        data: json.encode(findingId),
        queryParameters: {"findingId": "$findingId"});
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await response.data["result"];
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
