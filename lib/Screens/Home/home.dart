import 'package:flutter/material.dart';
import 'package:split/Services/auth.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('SPLIT'),
        backgroundColor: Colors.yellow,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: ()async{
              await _auth.signOut();
            },
          )
        ],
      ),
      // body: TabBarView(
      //   children: [
      //     Container(
      //       child: Icon(Icons.home),
      //     ),
      //     Container(
      //       child:Icon(Icons.group),
      //     ),
      //     Container(
      //       child: Icon(Icons.account_box),
      //     ),
      //   ],
      // ),
      // bottomNavigationBar: TabBar(
      //     tabs: const [
      //       Tab(
      //         icon: Icon(Icons.home),
      //       ),
      //       Tab(
      //         icon: Icon(Icons.group),
      //       ),
      //       Tab(
      //         icon: Icon(Icons.account_box),
      //       ),
      //     ],
      //     labelColor: Theme.of(context).primaryColor,
      //     unselectedLabelColor: Colors.black38,
      //     indicatorSize: TabBarIndicatorSize.label,
      //     indicatorPadding: EdgeInsets.all(5.0),
      //     indicatorColor: Theme.of(context).primaryColor
      // ),
    );
  }
}
