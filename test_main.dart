import 'package:flutter/material.dart';
import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter/foundation.dart';

//imports for the calendar and google authentication
/*import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart' as prefix;*/

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Login(),
      '/homepage': (context) => HomePage(),
      '/register': (context) => Register(),
      '/group': (context) => Group(),
    },
  ));
}

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String _username;

  late String _password;

  final usernamevalueHolder = TextEditingController();

  final passwordvalueHolder = TextEditingController();

  void _printLatestValue() {
    print('Second text field: ${usernamevalueHolder.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
            'Split',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 50.0),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.yellow,
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget> [
                    Container(
                      width: 350,
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: usernamevalueHolder,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: "Username, Email, or Phone Number",
                        ),
                      ),
                    ),
                    ],
            ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget> [
                    Container(
                      width: 350,
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        textInputAction: TextInputAction.done,
                        controller: passwordvalueHolder,
                        decoration: const InputDecoration(
                          hintText: "Password",
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40.0),
                RaisedButton(
                  child: Text('Login'),
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.pushNamed(context, '/homepage');
                    //display the value of the valueholder
                    print("username: "+ usernamevalueHolder.text + "\npassword: " + passwordvalueHolder.text);
                    //usernamevalueHolder.dispose();
                    //passwordvalueHolder.dispose();
                  },
                ),
                const SizedBox(height: 20.0),
                RaisedButton(
                  child: Text('Register'),
                  color: Colors.blue,
                  onPressed: (){
                    Navigator.pushNamed(context, '/register');
                  },
                ),
              ],
            )),
      ),
    );
  }
}

class HomePage extends StatelessWidget{
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Split',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 50.0),),
          backgroundColor: Colors.yellow,
          automaticallyImplyLeading: false,
        ),
        body: TabBarView(
          children: [
            Container(
              child: Icon(Icons.home),
            ),
            Container(
              child: new Group(),
            ),
            Container(
              //child: Icon(Icons.group),
              child: Icon(Icons.account_box),
            ),
          ],
        ),
        bottomNavigationBar: TabBar(
            tabs: const [
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.group),
              ),
              Tab(
                icon: Icon(Icons.account_box),
              ),
            ],
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.black38,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Theme.of(context).primaryColor
        ),
      ),
    );
  }
}

class Register extends StatefulWidget{
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameValueHolder = TextEditingController();
  final userNameValueHolder = TextEditingController();
  final telephoneValueHolder = TextEditingController();
  final emailValueHolder = TextEditingController();
  final paymentValueHolder = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Split: Register',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 50.0),
        ),
        backgroundColor: Colors.yellow,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget> [
              const SizedBox(height: 40.0),
              Row(
                children: <Widget> [
                     Container(
                       width: 130.0,
                       child: const Text(
                        "Name:\t",
                         style: TextStyle(fontSize: 20),
                       ),
                     ),
                      Container(
                        width: 280,
                        child: TextField(
                    controller: nameValueHolder,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black),
                        hintText: "First & Last Name",
                    ),
    ),
                      ),
          ],
              ),
        Row(
          children: <Widget> [
            Container(
              width: 130.0,
              child: const Text(
                "Username:\t",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              width: 280,
              child: TextField(
                controller: userNameValueHolder,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: "Username",
                ),
              ),
            ),
        ],
    ),
              Row(
                children: <Widget> [
                  Container(
                    width: 130.0,
                    child: const Text(
                      "*Phone:\t",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    width: 280,
                    child: TextField(
                      controller: telephoneValueHolder,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black),
                        hintText: "Phone Number",
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget> [
                  Container(
                    width: 130.0,
                    child: const Text(
                      "Email:\t",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    width: 280,
                    child: TextField(
                      controller: emailValueHolder,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black),
                        hintText: "Email",
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget> [
                  Container(
                    width: 130.0,
                    child: const Text(
                      "Payment:\t",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    width: 280,
                    child: TextField(
                      controller: paymentValueHolder,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black),
                        hintText: "Payment",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RaisedButton(
                    color: Colors.blue,
                    child: Text('Back'),
                    onPressed: (){
                      Navigator.pushNamed(context, '/');
                    },
                  ),
                  const SizedBox(width: 20.0,),
                  RaisedButton(
                    color: Colors.blue,
                    child: const Text('Register'),
                    onPressed: (){
                      Navigator.pushNamed(context, '/homepage');
                      print("Name: " + nameValueHolder.text + "\nUsername: " + userNameValueHolder.text + "\nPhone: " + telephoneValueHolder.text + "\nEmail: " + emailValueHolder.text + "\nPayment: " + paymentValueHolder.text );
                    //nameValueHolder.dispose();
                    //userNameValueHolder.dispose();
                    //telephoneValueHolder.dispose();
                    //emailValueHolder.dispose();
                    //paymentValueHolder.dispose();
                    },
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}


class Group extends StatefulWidget {
  const Group({Key? key}) : super(key: key);

  @override
  State<Group> createState() => _GroupState();
}


class _GroupState extends State<Group> {
  // This widget is the root of your application.

  final groupvalueHolder = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.yellowAccent[400],
        title: Row(
          children: <Widget> [
            Container(
                width: 130.0,
                child: Icon(Icons.search)
            ),
            Container(
              width: 240.0,
              child: TextField(
                controller: groupvalueHolder,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: "Groups",
                ),
              ),
            ),
            Container(

            ),
          ],
        ),
      ),
      //maybe a colored groups tab instead of an app group due to not needing a back button
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        RaisedButton(
          child: const Text('Create Group'),
          color: Colors.blue,
          onPressed: (){
            //Navigator.pushNamed(context, '/register');
          },

        ),
    ],
      ),
      );

  }
}
