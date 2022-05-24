import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import './new_transcation.dart';
import './transcation_list.dart';
import '../models/transcation.dart';
import './chart.dart';

class UserTranscation extends StatefulWidget {
  @override
  State<UserTranscation> createState() => _UserTranscationState();
}

class _UserTranscationState extends State<UserTranscation> {
  final List<Transcation> transcations = [];
  var SwitchValue = false;
  List<Transcation> get recentTranscations {
    return transcations.where((each) {
      return each.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void AddTranscation(String TxTitle, double TxAmount, DateTime selectedDate) {
    var NewTrans = Transcation(
        id: DateFormat.yMEd().format(selectedDate),
        title: TxTitle,
        amount: TxAmount,
        date: selectedDate);

    setState(() {
      transcations.add(NewTrans);
    });
  }

  void showBottomSheet(BuildContext contx) {
    setState(() {
      showModalBottomSheet(
          context: contx,
          builder: (context) {
            return NewTransction(AddTranscation: AddTranscation);
          });
    });
  }

  void deleleTransaction(String id) {
    setState(() {
      transcations.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    var DeviceHeight = MediaQuery.of(context).size.height;
    var DeviceWidth = MediaQuery.of(context).size.width;

    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    var totalHeight = DeviceHeight -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Expensive"),
        actions: [
          IconButton(
            onPressed: () => showBottomSheet(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          if (isLandScape)
            Container(
              height: totalHeight * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Show Chart"),
                  Switch.adaptive(
                    value: SwitchValue,
                    onChanged: (val) {
                      setState(() {
                        SwitchValue = val;
                      });
                    },
                  )
                ],
              ),
            ),
          if (SwitchValue && isLandScape)
            Container(
              height: totalHeight * 0.8,
              width: DeviceWidth * 0.8,
              child: Chart(recentTranscations),
            ),
          if (!SwitchValue && isLandScape)
            Container(
              height: totalHeight * 0.9,
              child: TranscationList(
                transcations: transcations,
                Deletetranscations: deleleTransaction,
              ),
            ),
          if (!isLandScape)
            Container(
              height: totalHeight * 0.4,
              child: Chart(recentTranscations),
            ),
          if (!isLandScape)
            Container(
              height: totalHeight * 0.6,
              child: TranscationList(
                transcations: transcations,
                Deletetranscations: deleleTransaction,
              ),
            ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
          onPressed: () => showBottomSheet(context),
          child: const Icon(Icons.add)),
    );
  }
}
