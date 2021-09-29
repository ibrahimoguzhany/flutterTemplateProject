import 'package:esd_mobil/core/extensions/string_extension.dart';

class SVGImagePaths {
  static SVGImagePaths? _instance;
  static SVGImagePaths? get instance {
    if (_instance == null) _instance = SVGImagePaths._init();
    return _instance;
  }

  SVGImagePaths._init();

  final contractSVG = "undraw_Contract_re_ves9".toSVG;
  final design_process_SVG = "undraw_Design_process_re_0dhf".toSVG;
  final real_time_sync_SVG = "undraw_Real_time_sync_re_nky7".toSVG;
  final socar_logo_SVG = "socarlogo".toSVG;
  final no_data = "undraw_No_data".toSVG;
}
