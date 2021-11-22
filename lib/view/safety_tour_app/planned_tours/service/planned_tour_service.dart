class PlannedTourService {
  static PlannedTourService? _instance;
  static PlannedTourService? get instance {
    if (_instance == null) _instance = PlannedTourService._init();
    return _instance;
  }

  PlannedTourService._init();


  
}
