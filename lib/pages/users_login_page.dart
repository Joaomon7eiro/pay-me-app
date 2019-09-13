import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pay_me_app/pages/admin_page.dart';

import '../models/user.dart';
import '../widgets/user_item.dart';

class UsersLoginPage extends StatefulWidget {
  static const routeName = '/login-page';

  @override
  _UsersLoginPageState createState() => _UsersLoginPageState();
}

class _UsersLoginPageState extends State<UsersLoginPage> {
  final _firestore = Firestore.instance;
  List<User> _users = [];
  bool _isLoading = true;
  int _adminCount = 0;

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void getUsers() async {
    final usersReference = await _firestore.collection('users').getDocuments();
    for (var user in usersReference.documents) {
      print(user.data);
      _users.add(User(
        id: user.data['id'],
        name: user.data['name'],
        imageUrl: user.data['imageUrl'],
      ));
    }
    setState(() {
      _isLoading = false;
    });
  }

  void incrementAdmin() {
    _adminCount++;
    if (_adminCount == 7) {
      Navigator.pushNamed(context, AdminPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    _adminCount = 0;

    return Scaffold(
      body: _isLoading
          ? Center(
              child: SpinKitCubeGrid(
                color: Colors.black,
                size: 50,
              ),
            )
          : Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.2),
                  child: GestureDetector(
                    onTap: incrementAdmin,
                    child: Text(
                      'Pagar Spotify',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (ctx, index) {
                          return UserItem(_users[index]);
                        },
                        itemCount: _users.length,
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
