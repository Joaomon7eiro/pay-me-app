import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

import '../models/month.dart';
import '../payment_status.dart';

class MonthItem extends StatelessWidget {
  final Month month;

  const MonthItem(this.month);

  Color get monthColor {
    if (month.number > DateTime.now().month) {
      return Colors.grey.shade300;
    }
    switch (month.status) {
      case PaymentStatus.NotPaid:
        return Colors.red.shade300;
      case PaymentStatus.Paid:
        return Colors.green.shade300;
      case PaymentStatus.PaidLate:
        return Colors.orange.shade300;
      case PaymentStatus.OnTime:
        return Colors.blue.shade200;
      default:
        return Colors.blue.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 1,
            offset: Offset.fromDirection(8),
          )
        ],
        color: monthColor,
        borderRadius: BorderRadius.circular(35),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: Text(
              month.title,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Icon(
            paymentIcon(month.status),
            size: 100,
            color: Colors.white,
          ),
          if (month.status == PaymentStatus.OnTime ||
              month.status == PaymentStatus.NotPaid)
            FlatButton(
              color: Colors.green.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Já Paguei',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                print('ja pago');
                FlutterOpenWhatsapp.sendSingleMessage(
                    "+5514981996163", 'Jão já paguei o mês de ${month.title}');
              },
            )
          else
            Text(
              paymentStatus(month.status),
              style: TextStyle(color: Colors.white),
            )
        ],
      ),
    );
  }
}
