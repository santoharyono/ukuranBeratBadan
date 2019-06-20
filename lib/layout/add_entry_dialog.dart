import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:weighttracker/model/weight_save.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'datetime_item.dart';

class AddEntryDialog extends StatefulWidget {
  final double initialWeight;
  final WeightSave weightForEdit;

  AddEntryDialog.add(this.initialWeight) : weightForEdit = null;
  AddEntryDialog.edit(this.weightForEdit)
      : initialWeight = weightForEdit.weight;

  @override
  _AddEntryDialogState createState() {
    if (weightForEdit != null) {
      return _AddEntryDialogState(
          datetime: weightForEdit.dateTime,
          weight: weightForEdit.weight,
          note: weightForEdit.note);
    } else {
      return _AddEntryDialogState(
          datetime: DateTime.now(), weight: initialWeight, note: null);
    }
  }
}

class _AddEntryDialogState extends State<AddEntryDialog> {
  DateTime datetime = DateTime.now();
  double weight;
  String note;

  _AddEntryDialogState({this.datetime, this.weight, this.note});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.weightForEdit == null
            ? Text('New Entry')
            : Text('Edit Entry'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop(
                  WeightSave(dateTime: datetime, weight: weight, note: note));
            },
            child: Icon(Icons.save),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(FontAwesomeIcons.calendar),
            title: DateTimeItem(
              dateTime: datetime,
              onChanged: (dateTime) {
                setState(() {
                  datetime = dateTime;
                });
              },
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.weight),
            title: Text('$weight Kg'),
            onTap: () {
              _showWeightPicker(context);
            },
          )
        ],
      ),
    );
  }

  void _showWeightPicker(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return NumberPickerDialog.decimal(
              minValue: 1, maxValue: 250, initialDoubleValue: weight);
        }).then((value) {
      if (value != null) {
        setState(() {
          weight = value;
        });
      }
    });
  }
}
