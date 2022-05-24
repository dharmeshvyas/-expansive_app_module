import 'package:flutter/material.dart';
import '../models/transcation.dart';
import 'package:intl/intl.dart';

class TranscationList extends StatelessWidget {
  final List<Transcation> transcations;
  final Function Deletetranscations;
  const TranscationList(
      {required this.transcations, required this.Deletetranscations});

  Widget TranscationCard(Transcation trans, BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FittedBox(
              child: Text(
                "₹${trans.amount}",
              ),
            ),
          ),
        ),
        title: Text(
          trans.title,
        ),
        subtitle: Text(
          DateFormat.yMMMEd().format(trans.date),
        ),
        trailing: IconButton(
          onPressed: () => Deletetranscations(trans.id),
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget noDataFoundCard(BuildContext context) {
    return Container(
      height: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "no transaction data",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 100,
            child: Image.asset(
              "essets/images/waiting.png",
              color: Colors.white60,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
      ),
      height: 450,
      child: transcations.isEmpty
          ? noDataFoundCard(context)
          : ListView.builder(
              itemBuilder: (context, index) {
                return TranscationCard(transcations[index], context);
              },
              itemCount: transcations.length,
            ),
    );
  }
}
