enum UnplannedTourURLs {
  GetAllTours,
  GetAllCategories,
  GetAllLocations,
  GetAllFields,
  GetUsers,
  CreateUnplannedTourMobile,
  UpdateTourMobile,
  GetTourByIdMobile,
  DeleteTour
}

enum UnplannedTourDetailURLs {
  CreateFindingForTour,
  RemoveFindingFromTour,
  GetFindingFiles,
  UploadFiles
}

extension UnplannedTourURLsExtension on UnplannedTourURLs {
  String get rawValue {
    switch (this) {
      case UnplannedTourURLs.GetAllTours:
        return "/Tours/GetAllTours";
      case UnplannedTourURLs.GetAllCategories:
        return "/Categories/GetAllCategories";
      case UnplannedTourURLs.GetAllLocations:
        return "/Locations/GetAllLocations";
      case UnplannedTourURLs.GetAllFields:
        return "/Fields/GetAllFields";
      case UnplannedTourURLs.GetUsers:
        return "/User/GetUsers";
      case UnplannedTourURLs.CreateUnplannedTourMobile:
        return "/Tours/CreateUnplannedTourMobile";
      case UnplannedTourURLs.UpdateTourMobile:
        return "/Tours/UpdateTourMobile";
      case UnplannedTourURLs.GetTourByIdMobile:
        return "/Tours/GetTourByIdMobile";
      case UnplannedTourURLs.DeleteTour:
        return "/Tours/DeleteTour";
    }
  }
}

extension UnplannedTourDetailURLsExtension on UnplannedTourDetailURLs {
  String get rawValue {
    switch (this) {
      case UnplannedTourDetailURLs.CreateFindingForTour:
        return "/Tours/CreateFindingForTour";
      case UnplannedTourDetailURLs.GetFindingFiles:
        return "/Tours/GetFindingFiles";
      case UnplannedTourDetailURLs.RemoveFindingFromTour:
        return "/Tours/RemoveFindingFromTour";
      case UnplannedTourDetailURLs.UploadFiles:
        return "/Tours/UploadFiles";
    }
  }
}
