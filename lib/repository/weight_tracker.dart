import 'dart:math';

import 'package:weighttracker/model/weight_save.dart';

class WeightTracker {
  static double difference(List<WeightSave> weightList, WeightSave weight) {
    return weightList.first == weight
        ? 0.0
        : weight.weight - weightList[weightList.indexOf(weight) - 1].weight;
  }

  // For testing purpose
  static WeightSave addWeightSave() {
    return WeightSave(
        dateTime: DateTime.now(), weight: Random().nextInt(100).toDouble());
  }
}
