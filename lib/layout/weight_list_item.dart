import 'package:flutter/material.dart';
import 'package:weighttracker/model/weight_save.dart';
import 'package:intl/intl.dart';

class WeightListItem extends StatelessWidget {
  final WeightSave weightSave;
  final double weightDifference;

  WeightListItem({this.weightSave, this.weightDifference});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                DateFormat.yMMMMd().format(weightSave.dateTime),
                textScaleFactor: 0.9,
                textAlign: TextAlign.left,
              ),
              Text(
                DateFormat.EEEE().format(weightSave.dateTime),
                textScaleFactor: 0.8,
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
          Expanded(
            child: Text(
              weightSave.weight.toString(),
              textScaleFactor: 2.0,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              weightDifference.toString(),
              textScaleFactor: 1.6,
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }
}
