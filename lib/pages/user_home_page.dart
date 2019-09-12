import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../models/month.dart';
import '../models/user.dart';
import '../payment_status.dart';
import '../widgets/month_item.dart';

import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class UserHomePage extends StatefulWidget {
  static const routeName = '/user-page';

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  String id;
  final _firestore = Firestore.instance;

  List<Month> months = [];

  final currentMonth = DateTime.now().month - 1;

  bool isLoading = true;

  List<Month> defaultMonths = [
    Month(
      number: 1,
      title: 'Janeiro',
      status: PaymentStatus.OnTime,
    ),
    Month(
      number: 2,
      title: 'Fevereiro',
      status: PaymentStatus.OnTime,
    ),
    Month(
      number: 3,
      title: 'Março',
      status: PaymentStatus.OnTime,
    ),
    Month(
      number: 4,
      title: 'Abril',
      status: PaymentStatus.OnTime,
    ),
    Month(
      number: 5,
      title: 'Maio',
      status: PaymentStatus.OnTime,
    ),
    Month(
      number: 6,
      title: 'Junho',
      status: PaymentStatus.OnTime,
    ),
    Month(
      number: 7,
      title: 'Julho',
      status: PaymentStatus.OnTime,
    ),
    Month(
      number: 8,
      title: 'Agosto',
      status: PaymentStatus.OnTime,
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

  void updateMonths() async {
    final currentYear = DateTime.now().year.toString();
    final monthsReference = _firestore
        .collection('users')
        .document(id)
        .collection('years')
        .document(currentYear)
        .collection('months');

    final monthsData = await monthsReference.getDocuments();

    print(monthsData.documents.length);

    if (monthsData.documents.length == 0) {
      var batch = _firestore.batch();
      for (var i = 0; i < 12; i++) {
        batch.setData(
            monthsReference.document(defaultMonths[i].number.toString()), {
          'title': defaultMonths[i].title,
          'id': defaultMonths[i].number.toString(),
          'number': defaultMonths[i].number,
          'status': defaultMonths[i].status.index,
        });
      }
      batch.commit();
      updateMonths();
    } else {
      months = [];
      final monthsQuery = monthsReference.orderBy('number', descending: false);
      final monthsQueryData = await monthsQuery.getDocuments();
      for (var month in monthsQueryData.documents) {
        print(month.data);
        months.add(Month(
          title: month.data['title'],
          number: month.data['number'],
          status: paymentIndex(month.data['status']),
        ));
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context).settings.arguments;
    if (id == null) {
      id = user.id;
      updateMonths();
    }

    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? Center(
                child: SpinKitCubeGrid(
                  color: Colors.indigo,
                  size: 50,
                ),
              )
            : RefreshIndicator(
                onRefresh: () {
                  updateMonths();
                  return;
                },
                child: SingleChildScrollView(
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
                                style: TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.bold),
                              ),
                              width: MediaQuery.of(context).size.width * 0.4,
                            ),
                            Spacer(),
                            IconButton(
                                icon: Icon(Icons.message),
                                iconSize: 30,
                                onPressed: () {
                                  FlutterOpenWhatsapp.sendSingleMessage(
                                      "+5514981996163", 'Eai Monteiro');
                                }),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {},
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(user.imageUrl),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text(
                              months[currentMonth].title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                            Icon(
                              paymentIcon(months[currentMonth].status),
                              size: 220,
                              color: paymentColor(months[currentMonth].status),
                            ),
                            Text(
                              paymentStatus(months[currentMonth].status),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
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
              ),
      ),
    );
  }
}
