import 'package:flutter/material.dart';

import '../models/user.dart';

class AdminItem extends StatelessWidget {
  final User user;

  const AdminItem(this.user);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                child: Container(
                  width: 200,
                  height: 200,
                  child: Image.network(
                    user.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 10,
                child: Icon(
                  Icons.check_circle,
                  size: 40,
                ),
              )
            ],
          ),
          Divider(),
          Text(user.name),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.money_off),
                color: Colors.red,
                onPressed: () {},
              ),
              IconButton(
                  icon: Icon(Icons.monetization_on),
                  onPressed: () {},
                  color: Colors.green.shade300),
            ],
          )
        ],
      ),
    );
  }
}
