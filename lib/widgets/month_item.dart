import 'package:flutter/material.dart';

class MonthItem extends StatelessWidget {
  final Month month;

  const MonthItem(this.month);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(color: Colors.amber),
        child: Text(
          'text $i',
          style: TextStyle(fontSize: 16.0),
        ));
  }
}
