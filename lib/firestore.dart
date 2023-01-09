import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider {
  // Collection名
  static const substance = 'substances';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void getSubstance() async {
    await _firestore.collection(substance).get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
  }
}
