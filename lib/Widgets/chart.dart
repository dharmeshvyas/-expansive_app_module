import 'package:expansivelist_app/models/transcation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  late List<Transcation> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get weekTransactionAmount {
    return List.generate(7, (index) {
      var weekday = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (Transcation eachdayTrans in recentTransaction) {
        if (eachdayTrans.date.day == weekday.day &&
            eachdayTrans.date.month == weekday.month &&
            eachdayTrans.date.year == weekday.year) {
          totalSum += eachdayTrans.amount;
        }
      }
      return {"Day": DateFormat.E().format(weekday), "Amount": totalSum};
    });
  }

  double get totalSpending {
    return weekTransactionAmount.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element["Amount"] as double));
  }

  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraint) {
        return Card(
          margin: EdgeInsets.all(20),
          elevation: 10,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: weekTransactionAmount.map((e) {
                // return Text("");

                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                      e,
                      totalSpending == 0.0
                          ? 0.0
                          : (e["Amount"] as double) / totalSpending),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
