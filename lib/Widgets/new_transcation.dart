import './new_transcation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransction extends StatefulWidget {
  final Function AddTranscation;

  NewTransction({required this.AddTranscation});

  @override
  State<NewTransction> createState() => _NewTransctionState();
}

class _NewTransctionState extends State<NewTransction> {
  final TitleController = TextEditingController();
  final AmountController = TextEditingController();
  late DateTime selectedDate = DateTime.now();

  void submitData() {
    if (TitleController.text.isEmpty && AmountController.text.isEmpty) {
      return;
    }
    widget.AddTranscation(TitleController.text,
        double.parse(AmountController.text), selectedDate);

    Navigator.of(context).pop();
  }

  void showDataPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.utc(2020),
      lastDate: DateTime.now(),
    ).then((userselectedDate) {
      if (userselectedDate == null) {
        return;
      }
      selectedDate = userselectedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return LayoutBuilder(builder: (ctx, constraints) {
      return Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              //height: constraints.maxHeight * 0.2,
              margin: EdgeInsets.symmetric(
                  vertical: constraints.maxHeight * 0.01,
                  horizontal: constraints.maxWidth * 0.01),
              child: TextField(
                controller: TitleController,
                decoration: InputDecoration(
                  hintText: "Title",
                  filled: true,
                  fillColor: Colors.black12,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: constraints.maxHeight * 0.01,
                  horizontal: constraints.maxWidth * 0.01),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: AmountController,
                decoration: InputDecoration(
                  hintText: "Amount",
                  filled: true,
                  fillColor: Colors.black12,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
            Container(
              height: constraints.maxHeight * 0.15,
              margin: EdgeInsets.symmetric(
                  vertical: constraints.maxHeight * 0.01,
                  horizontal: constraints.maxWidth * 0.01),
              decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(5),
                    right: Radius.circular(5),
                  )),
              child: Container(
                padding: EdgeInsets.all(constraints.maxHeight * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate == null
                          ? "No Date selected"
                          : DateFormat.yMMMEd().format(selectedDate),
                    ),
                    IconButton(
                      onPressed: showDataPicker,
                      icon: const Icon(
                        Icons.calendar_month,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: constraints.maxHeight * 0.01,
                  right: constraints.maxHeight * 0.01),
              height: constraints.maxHeight * 0.1,
              child: ElevatedButton(
                onPressed: submitData,
                child: const Text("Add Transcation"),
              ),
            ),
          ],
        ),
      );
    });
  }
}
