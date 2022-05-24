import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  double TotalSpendingAmountPerc;
  late Map<String, Object> Record;
  ChartBar(this.Record, this.TotalSpendingAmountPerc);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child:
                  Text("₹" + (Record["Amount"] as double).toStringAsFixed(0)),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 15,
            child:
                Stack(alignment: AlignmentDirectional.bottomCenter, children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.5),
                    borderRadius: BorderRadius.circular(10)),
              ),
              FractionallySizedBox(
                heightFactor: TotalSpendingAmountPerc,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      border: Border.all(color: Colors.grey, width: 1.5),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ]),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.15,
            child: Text(
              Record["Day"].toString(),
            ),
          ),
        ],
      );
    });
  }
}
