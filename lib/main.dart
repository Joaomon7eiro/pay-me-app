import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'page nois',
      home: UserHomePage(),
    );
  }
}

class UserHomePage extends StatelessWidget {
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
                      'Pagar o Monteiro',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                  CircleAvatar(),
                ],
              ),
            ),
            Icon(
              Icons.check_circle,
              size: 200,
              color: Colors.green.shade300,
            ),
            CarouselSlider(
              height: 400.0,
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return;
                  },
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
