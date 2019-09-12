import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';
import '../widgets/user_item.dart';

class UsersLoginPage extends StatefulWidget {
  static const routeName = '/login-page';

  @override
  _UsersLoginPageState createState() => _UsersLoginPageState();
}

class _UsersLoginPageState extends State<UsersLoginPage> {
  final _firestore = Firestore.instance;
  List<User> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void getUsers() async {
    final usersReference = await _firestore.collection('users').getDocuments();
    for (var user in usersReference.documents) {
      print(user.data);
      users.add(User(
        id: user.data['id'],
        name: user.data['name'],
        imageUrl: user.data['imageUrl'],
      ));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Text('...'),
            )
          : Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.2),
                  child: Text(
                    'Pagar Spotify',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 400,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 2,
                            mainAxisSpacing: 20),
                        itemBuilder: (ctx, index) {
                          return UserItem(users[index]);
                        },
                        itemCount: users.length,
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
