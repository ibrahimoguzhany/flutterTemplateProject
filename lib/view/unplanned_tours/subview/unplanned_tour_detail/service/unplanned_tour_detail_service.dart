import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:esd_mobil/view/unplanned_tours/subview/unplanned_tour_detail/model/finding_entry_model.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

import '../../../../../core/constants/app/network_constants.dart';
import '../../../../../product/enum/unplannedtours_url_enum.dart';
import '../../../../_product/_model/finding_file.dart';
import '../../../model/unplanned_tour_model.dart';
import '../../../service/unplanned_tour_service.dart';
import 'package:http_parser/http_parser.dart';

class UnPlannedTourDetailService {
  static UnPlannedTourDetailService? _instance;
  static UnPlannedTourDetailService? get instance {
    if (_instance == null) _instance = UnPlannedTourDetailService._init();
    return _instance;
  }

  UnPlannedTourDetailService._init();

  final dio = Dio(
    BaseOptions(
      baseUrl: NetworkConstants.BASE_URL,
      headers: {"Content-Type": "application/json-patch+json"},
    ),
  );

  Future<FindingModel?> createFindingForTour(
    FindingEntryModel finding,
    int tourId,
  ) async {
    print(tourId);
    print(finding.findingType);
    final response = await dio.post(
        UnplannedTourDetailURLs.CreateFindingForTour.rawValue,
        data: json.encode(finding),
        queryParameters: {"tourId": tourId});
    print(response);
    print(response.data);
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await response.data["result"];
        return FindingModel.fromJson(responseBody);
      default:
        return null;
    }
  }

  Future<void> uploadFindingFile(File fileInput, int findingId) async {
    var formDio = Dio(
      BaseOptions(
        queryParameters: {"findingId": "$findingId"},
        baseUrl: NetworkConstants.BASE_URL,
        headers: {
          "Content-Type": "multipart/form-data",
        },
      ),
    );
    List<String> mimeType = lookupMimeType(fileInput.path)!.split("/").toList();

    String type = mimeType[0];
    String subType = mimeType[1];
    String fileName = basename(fileInput.path);
    // print(mimeType);
    // print(fileName);
    // print(type);
    // print(subType);
    // file formatini header formatini anlamak icin metodum.
    //print(fileInput.readAsBytesSync().sublist(0, 4));

    FormData formData = FormData.fromMap({
      "files": [
        await MultipartFile.fromFile(fileInput.path,
            filename: fileName, contentType: MediaType(type, subType)),
      ],
    });

    var response = await formDio.post(
      UnplannedTourDetailURLs.UploadFiles.rawValue,
      data: formData,
    );
    print(response.statusCode);
    print(response.data);
    print(response.statusMessage);

    final result = json.decode(response.toString())['result'];
    print(result);
  }

  Future<FindingFile?> uploadFindingFiles(
      List<File?> items, int findingId) async {
    for (var item in items) {
      await uploadFindingFile(item ?? File(""), findingId);
    }
  }

  Future<List<FindingFile>?> getFindingFiles(int findingId) async {
    final response = await dio.post(
        UnplannedTourDetailURLs.GetFindingFiles.rawValue,
        data: findingId,
        queryParameters: {"findingId": "$findingId"});
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await response.data["result"];

        if (responseBody is List) {
          return responseBody.map((e) => FindingFile.fromJson(e)).toList();
        }
        return Future.error(responseBody);
    }
    print(response.data);
    return Future.error(response);
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

  Future<bool> deleteFindingFile(int findingId, String fileName) async {
    final response = await dio.post(
        UnplannedTourDetailURLs.RemoveFindingFile.rawValue,
        queryParameters: {"findingId": "$findingId", "fileName": fileName});

    if (response.statusCode == HttpStatus.ok) {
      return true;
    }
    return false;
  }

  Future<List<FindingModel>>? getFindings(int tourId) async {
    final response = await dio.post(
      UnplannedTourDetailURLs.GetFindingsOfTourMobile.rawValue,
      queryParameters: {"tourId": "$tourId"},
    );
    if (response.statusCode == HttpStatus.ok) {
      final responseBody = await response.data["result"];
      if (responseBody is List) {
        return responseBody.map((e) => FindingModel.fromJson(e)).toList();
      }
      return Future.error(responseBody);
    }
    return Future.error(response);
  }
}
