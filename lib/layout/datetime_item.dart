import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeItem extends StatelessWidget {
  final DateTime date;
  final TimeOfDay time;
  final ValueChanged<DateTime> onChanged;

  DateTimeItem({Key key, DateTime dateTime, @required this.onChanged})
      : assert(onChanged != null),
        date = DateTime(dateTime.year, dateTime.month, dateTime.day),
        time = TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: InkWell(
            onTap: () {
              showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: date.subtract(Duration(days: 30)),
                      lastDate: date.add(Duration(days: 30)))
                  .then<void>((DateTime value) {
                if (value != null) {
                  onChanged(DateTime(value.year, value.month, value.day,
                      time.hour, time.minute));
                }
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: <Widget>[
                  Text(DateFormat('EEEE, MMMM d').format(date)),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            showTimePicker(context: context, initialTime: time)
                .then<void>((TimeOfDay value) {
              if (value != null) {
                onChanged(DateTime(
                    date.year, date.month, date.day, value.hour, value.minute));
              }
            });
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: <Widget>[
                Text('${time.format(context)}'),
                Icon(Icons.arrow_drop_down)
              ],
            ),
          ),
        )
      ],
    );
  }
}
