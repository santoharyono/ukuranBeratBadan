import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:weighttracker/layout/weight_list_item.dart';
import 'package:weighttracker/model/weight_save.dart';
import 'package:weighttracker/repository/weight_tracker.dart';

import 'add_entry_dialog.dart';

final mainReference = FirebaseDatabase.instance.reference();

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<WeightSave> weightSaves = new List();

  void _openEntryDialog() async {
    await Navigator.of(context)
        .push(MaterialPageRoute<WeightSave>(
            builder: (BuildContext context) {
              return AddEntryDialog.add(60.0);
            },
            fullscreenDialog: true))
        .then((value) {
      if (value != null) {
        // TODO: save to firebase database
        mainReference.push().set(value.toJson());
      }
    });
  }

  void _openEditDialog(WeightSave editedWeightRecord) {
    Navigator.of(context).push(MaterialPageRoute<WeightSave>(
        builder: (BuildContext context) {
          return AddEntryDialog.edit(editedWeightRecord);
        },
        fullscreenDialog: true));
  }

  void _addWeight(Event event) {
    // TODO: read from database
    setState(() {
      weightSaves.add(WeightSave.fromSnapshot(event.snapshot));
    });
  }

  void _editWeight(Event event) {
    // TODO: update record from database
    var oldRecord =
        weightSaves.singleWhere((entry) => entry.key == event.snapshot.key);
    print('oldRecord : $oldRecord');
    setState(() {
      weightSaves[weightSaves.indexOf(oldRecord)] =
          WeightSave.fromSnapshot(event.snapshot);
    });
  }

  @override
  void initState() {
    super.initState();
    mainReference.onChildAdded.listen(_addWeight);
    mainReference.onChildChanged.listen(_editWeight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: weightSaves.length,
          itemBuilder: (BuildContext context, int index) {
            var save = weightSaves[index];
            var difference = WeightTracker.difference(weightSaves, save);
            return InkWell(
              onTap: () {
                print(weightSaves[index]);
                _openEditDialog(weightSaves[index]);
              },
              child: WeightListItem(
                weightSave: save,
                weightDifference: double.parse(difference.toStringAsFixed(2)),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openEntryDialog();
        },
        tooltip: 'Add new weight entry',
        child: new Icon(Icons.add),
      ),
    );
  }
}
