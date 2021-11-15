import 'package:esd_mobil/core/constants/app/network_constants.dart';

enum UnplannedTourURLs {
  BaseURL,
  GetAllTours,
  GetAllCategories,
  GetAllLocations,
  GetAllFields,
  GetUsers,
  CreateUnplannedTourMobile,
  UpdateTourMobile,
  GetTourByIdMobile,
  ApproveTourMobile,
  DeleteTour
}

extension UnplannedTourURLsExtension on UnplannedTourURLs {
  String get rawValue {
    switch (this) {
      case UnplannedTourURLs.BaseURL:
        return NetworkConstants.BASE_URL;
      case UnplannedTourURLs.GetAllTours:
        return "/Tours/GetAllToursMobile";
      case UnplannedTourURLs.GetAllCategories:
        return "/Categories/GetAllCategoriesMobile";
      case UnplannedTourURLs.GetAllLocations:
        return "/Locations/GetAllLocationsMobile";
      case UnplannedTourURLs.GetAllFields:
        return "/Fields/GetAllFieldsMobile";
      case UnplannedTourURLs.GetUsers:
        return "/User/GetUsersMobile";
      case UnplannedTourURLs.CreateUnplannedTourMobile:
        return "/Tours/CreateUnplannedTourMobile";
      case UnplannedTourURLs.UpdateTourMobile:
        return "/Tours/UpdateTourMobile";
      case UnplannedTourURLs.GetTourByIdMobile:
        return "/Tours/GetTourByIdMobile";
      case UnplannedTourURLs.ApproveTourMobile:
        return "/Tours/ApproveTourMobile";
      case UnplannedTourURLs.DeleteTour:
        return "/Tours/DeleteTourMobile";
    }
  }
}

enum UnplannedTourDetailURLs {
  CreateFindingForTour,
  RemoveFindingFromTour,
  GetFindingFiles,
  UploadFiles,
  RemoveFindingFile,
}

extension UnplannedTourDetailURLsExtension on UnplannedTourDetailURLs {
  String get rawValue {
    switch (this) {
      case UnplannedTourDetailURLs.CreateFindingForTour:
        return "/Tours/CreateFindingForTourMobile";
      case UnplannedTourDetailURLs.GetFindingFiles:
        return "/Tours/GetFindingFilesMobile";
      case UnplannedTourDetailURLs.RemoveFindingFromTour:
        return "/Tours/RemoveFindingFromTourMobile";
      case UnplannedTourDetailURLs.UploadFiles:
        return "/Tours/UploadFilesMobile";
      case UnplannedTourDetailURLs.RemoveFindingFile:
        return "/Tours/RemoveFindingFileMobile";
    }
  }
}
