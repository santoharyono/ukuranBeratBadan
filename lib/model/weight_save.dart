import 'package:firebase_database/firebase_database.dart';

class WeightSave {
  DateTime dateTime;
  double weight;
  String note;
  String key;

  WeightSave({this.dateTime, this.weight, this.note});

  WeightSave.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        dateTime =
            DateTime.fromMicrosecondsSinceEpoch(snapshot.value['datetime']),
        weight = double.parse(snapshot.value['weight'].toString()),
        note = snapshot.value['note'];

  toJson() {
    return {
      "weight": weight,
      "datetime": dateTime.millisecondsSinceEpoch,
      "note": note
    };
  }
}
