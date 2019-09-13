import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pay_me_app/widgets/admin_item.dart';

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
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.1),
                    child: Text(
                      'Membros',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2 / 3.4,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20),
                      itemBuilder: (ctx, index) {
                        return AdminItem(_users[index]);
                      },
                      itemCount: _users.length,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
