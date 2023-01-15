import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
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
                //1
                child: StreamBuilder<QuerySnapshot>(
                  //2
                  stream: FirebaseFirestore.instance
                      .collection('substances')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('エラーが発生しました');
                    }
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    //3
                    final list = snapshot.requireData.docs
                        .map<String>((DocumentSnapshot document) {
                      final documentData =
                          document.data()! as Map<String, dynamic>;
                      return documentData['formula']! as String;
                    }).toList();

                    final reverseList = list.reversed.toList();

                    return ListView.builder(
                      itemCount: reverseList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Center(
                          child: Text(
                            reverseList[index],
                            style: const TextStyle(fontSize: 20),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
