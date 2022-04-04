import 'package:flutter/material.dart';
import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter/foundation.dart';

//imports for the calendar and google authentication
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart' as prefix;

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Login(),
      '/homepage': (context) => HomePage(),
      '/register': (context) => Register(),
      '/group': (context) => Group(),
      '/group': (context) => DateTimePicker(),
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

//CALENDAR BEGINS HERE
class DateTimePicker extends StatefulWidget {
  @override
  _DateTimePickerState createState() => _DateTimePickerState();

}

class _DateTimePickerState extends State<DateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calendar(),
    );
  }
}


class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();

}

//final _nameController = TextEditingController();
class _CalendarState extends State<Calendar> {
  final _nameController = TextEditingController();
  String _date = "Date of Event";
  String _starttime = "Start Time";
  String _endtime = "End Time";//insert event time button just like Start time
  String _name = "Not Set";


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DateTime Picker'),
      ),
      body: Padding(
        //Textbox('Hello World'),
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //ADD INSERT EVENT BUTTON
              //Text('$_date'),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true,
                      minTime: DateTime(2000, 1, 1),
                      maxTime: DateTime(2222, 12, 31), onConfirm: (date) {
                        print('confirm $date');
                        _date = '${date.year} - ${date.month} - ${date.day}';
                        setState(() {});
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.date_range,
                                  size: 18.0,
                                  color: Colors.teal,
                                ),
                                Text(
                                  " $_date",
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  Change",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showTimePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true, onConfirm: (time) {
                        print('confirm $time');
                        _starttime = '${time.hour} : ${time.minute} : ${time.second}';
                        setState(() {});
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  size: 18.0,
                                  color: Colors.teal,
                                ),
                                Text(
                                  " $_starttime",
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  Change",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showTimePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true, onConfirm: (time) {
                        print('confirm $time');
                        _endtime = '${time.hour} : ${time.minute} : ${time.second}';
                        setState(() {});
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  size: 18.0,
                                  color: Colors.teal,
                                ),
                                Text(
                                  " $_endtime",
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  Change",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter Event name',
                  ),
              ),
              TextButton(
                onPressed:(){
                  _name = _nameController.text;
                  //print("Event name is: $_name");
                },
                child: Text("Enter Event")
              ),
            ],
          ),
        ),
      ),
    );
  }

 /* @override
  void createCRED() {
    var _credentials = "";
    if (io2.Platform.isAndroid)
    {
      _credentials = new ClientId(222352036945-3dkkfiehp7aavm1qur67fvevgbevvofi.apps.googleusercontent.com);
    }

  }*/

}
//CALENDAR ENDS HERE
