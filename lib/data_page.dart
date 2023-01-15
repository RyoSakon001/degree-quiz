import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:degree_quiz/firestore.dart';
import 'package:flutter/material.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('firestore'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: double.infinity,
                alignment: Alignment.topCenter,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirestoreProvider().substanceStream(),
                  builder: ((context, snapshot) => FirestoreProvider()
                      .substanceListBuilder(context, snapshot)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
