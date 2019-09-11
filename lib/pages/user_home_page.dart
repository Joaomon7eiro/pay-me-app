import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../models/month.dart';
import '../payment_status.dart';
import '../widgets/month_item.dart';

import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class UserHomePage extends StatelessWidget {
  static const routeName = '/user-page';

  String id = 'piIL4PCLE0HMD2Dnx2J3';

  List<Month> months = [
    Month(
      number: 1,
      title: 'Janeiro',
      status: PaymentStatus.Paid,
    ),
    Month(
      number: 2,
      title: 'Fevereiro',
      status: PaymentStatus.Paid,
    ),
    Month(
      number: 3,
      title: 'Março',
      status: PaymentStatus.PaidLate,
    ),
    Month(
      number: 4,
      title: 'Abril',
      status: PaymentStatus.PaidLate,
    ),
    Month(
      number: 5,
      title: 'Maio',
      status: PaymentStatus.Paid,
    ),
    Month(
      number: 6,
      title: 'Junho',
      status: PaymentStatus.Paid,
    ),
    Month(
      number: 7,
      title: 'Julho',
      status: PaymentStatus.PaidLate,
    ),
    Month(
      number: 8,
      title: 'Agosto',
      status: PaymentStatus.NotPaid,
    ),
    Month(
      number: 9,
      title: 'Setembro',
      status: PaymentStatus.OnTime,
    ),
    Month(
      number: 10,
      title: 'Outubro',
      status: PaymentStatus.OnTime,
    ),
    Month(
      number: 11,
      title: 'Novembro',
      status: PaymentStatus.OnTime,
    ),
    Month(
      number: 12,
      title: 'Dezembro',
      status: PaymentStatus.OnTime,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      'Pagar o Spotify',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                  InkWell(
                    onTap: () {
                      FlutterOpenWhatsapp.sendSingleMessage(
                          "+5514981996163", 'Eai Monteiro');
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.red.shade300,
                      radius: 30,
                      child: Icon(Icons.supervised_user_circle),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Text(
                    'Setembro',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Icon(
                    Icons.check_circle,
                    size: 220,
                    color: Colors.green.shade300,
                  ),
                  Text(
                    paymentStatus(PaymentStatus.Paid),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Prazo para pagamento atual 07/${DateTime.now().month}',
                    style: TextStyle(color: Colors.black54),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: CarouselSlider(
                initialPage: DateTime.now().month - 1,
                enableInfiniteScroll: false,
                height: 230.0,
                items: months.map((month) {
                  return Builder(
                    builder: (BuildContext context) {
                      return MonthItem(month);
                    },
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
