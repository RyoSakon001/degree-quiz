import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreProvider {
  // Collection名
  static const substances = 'substances';
  static const degrees = 'degrees';
  static const substanceListLength = 2;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> substanceStream() =>
      _firestore.collection(substances).snapshots();

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

  Future<Map<String, dynamic>> getRandomSubstance() async {
    final substanceSnapshot = await FirebaseFirestore.instance
        .collection(substances)
        .where('id', isEqualTo: Random().nextInt(substanceListLength) + 1)
        .get();

    final substanceData = substanceSnapshot.docs.first;

    return (substanceData.exists) ? substanceData.data() : {};
  }

  Future<Map<String, dynamic>> getRandomDegree(int type) async {
    final degreeSnapshot = await FirebaseFirestore.instance
        .collection(degrees)
        .where('type', isEqualTo: type)
        .get();
    final degreeData = degreeSnapshot.docs.first;

    return (degreeData.exists) ? degreeData.data() : {};
  }
}
