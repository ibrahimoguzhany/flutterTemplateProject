import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/finding_model.dart';

class FindingService {
  static FindingService? _instance;
  static FindingService? get instance {
    if (_instance == null) _instance = FindingService._init();
    return _instance;
  }

  FindingService._init();

  final firestoreInstance = FirebaseFirestore.instance;
  CollectionReference findingsCollection =
      FirebaseFirestore.instance.collection('findings');

  // Future<List<FindingModel>> getFindings() {
  //   return findingsCollection.get().then((QuerySnapshot querySnapshot) {
  //     List<FindingModel> findingList = <FindingModel>[];
  //     querySnapshot.docs.forEach((doc) {
  //       findingList.add(FindingModel.fromDocumentSnapshot(doc));
  //     });
  //     return findingList;
  //   });
  // }
}
