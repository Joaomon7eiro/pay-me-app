import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../models/user.dart';
import '../widgets/user_item.dart';

class AdminPage extends StatefulWidget {
  static const routeName = '/admin-page';

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _firestore = Firestore.instance;
  List<User> _users = [];
  bool _isLoading = true;

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

  @override
  Widget build(BuildContext context) {
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
                  child: Text(
                    'Parças',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
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
