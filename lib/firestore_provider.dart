import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreProvider {
  // Collection名
  static const substance = 'substances';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> substanceStream() =>
      _firestore.collection(substance).snapshots();

  Widget substanceListBuilder(
      BuildContext context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    if (snapshot.hasError) {
      return const Text('error');
    }
    if (!snapshot.hasData) {
      return const Center(child: CircularProgressIndicator());
    }
    final list =
        snapshot.requireData.docs.map<String>((DocumentSnapshot document) {
      final documentData = document.data()! as Map<String, dynamic>;
      return documentData['formula']! as String;
    }).toList();

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return Center(
          child: Text(
            list[index],
            style: const TextStyle(fontSize: 20),
          ),
        );
      },
    );
  }

  void getSubstance() async {
    await _firestore.collection(substance).get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
  }
}
