import 'package:degree_quiz/bloc/substance/substance_bloc.dart';
import 'package:degree_quiz/bloc/substance/substance_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataPage extends StatelessWidget {
  const DataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SubstanceBloc(),
      child: const SubstanceView(),
    );
  }
}

class SubstanceView extends StatelessWidget {
  const SubstanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: BlocBuilder<SubstanceBloc, int>(
          builder: (context, count) {
            return Text('$count', style: Theme.of(context).textTheme.headline1);
          },
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              context.read<SubstanceBloc>().add(SubstanceIncrementPressed());
            },
          ),
        ],
      ),
    );
  }
}

// class _DataPageState extends State<DataPage> {
//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('firestore'),
//       ),
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: Container(
//                 height: double.infinity,
//                 alignment: Alignment.topCenter,
//                 child: StreamBuilder<QuerySnapshot>(
//                   stream: FirestoreProvider().substanceStream(),
//                   builder: ((context, snapshot) => FirestoreProvider()
//                       .substanceListBuilder(context, snapshot)),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
