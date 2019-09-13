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
  String _id;
  var _refreshKey = GlobalKey<RefreshIndicatorState>();
  final _firestore = Firestore.instance;

  List<Month> _months = [];

  final _currentMonth = DateTime.now().month - 1;

  bool _isLoading = true;

  List<Month> _defaultMonths = [
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

  Future<Null> updateMonths() async {
    final currentYear = DateTime.now().year.toString();
    final monthsReference = _firestore
        .collection('users')
        .document(_id)
        .collection('years')
        .document(currentYear)
        .collection('months');

    final monthsData = await monthsReference.getDocuments();

    print('Quantidade de meses: ${monthsData.documents.length}');

    if (monthsData.documents.length == 0) {
      var batch = _firestore.batch();
      for (var i = 0; i < 12; i++) {
        batch.setData(
            monthsReference.document(_defaultMonths[i].number.toString()), {
          'title': _defaultMonths[i].title,
          'id': _defaultMonths[i].number.toString(),
          'number': _defaultMonths[i].number,
          'status': _defaultMonths[i].status.index,
          'year': currentYear,
        });
      }
      batch.commit();
      updateMonths();
    } else {
      _months = [];
      final monthsQueryData = await monthsReference
          .orderBy('number', descending: false)
          .getDocuments();

      for (var month in monthsQueryData.documents) {
        print(month.data);
        _months.add(Month(
          title: month.data['title'],
          number: month.data['number'],
          year: currentYear,
          status: paymentIndex(
            month.data['status'],
          ),
        ));
      }
      setState(() {
        _isLoading = false;
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context).settings.arguments;
    if (_id == null) {
      _id = user.id;
      updateMonths();
    }

    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: SpinKitCubeGrid(
                  color: Colors.black,
                  size: 50,
                ),
              )
            : RefreshIndicator(
                color: Colors.black,
                key: _refreshKey,
                onRefresh: updateMonths,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
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
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(user.imageUrl),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: <Widget>[
                            Text(
                              _months[_currentMonth].title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                            Icon(
                              paymentIcon(_months[_currentMonth].status),
                              size: 220,
                              color:
                                  paymentColor(_months[_currentMonth].status),
                            ),
                            Text(
                              paymentStatus(_months[_currentMonth].status),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Prazo para pagamento atual 07/${DateTime.now().month}/${DateTime.now().year}',
                              style: TextStyle(color: Colors.black54),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        child: CarouselSlider(
                          initialPage: DateTime.now().month - 1,
                          enableInfiniteScroll: false,
                          height: 230,
                          items: _months.map((month) {
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
