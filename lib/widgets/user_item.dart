import 'package:flutter/material.dart';

import '../models/user.dart';
import '../pages/user_home_page.dart';

class UserItem extends StatelessWidget {
  final User user;

  const UserItem(this.user);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () => Navigator.pushNamed(context, UserHomePage.routeName,
              arguments: user),
          child: CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(user.imageUrl),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          user.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        )
      ],
    );
  }
}
