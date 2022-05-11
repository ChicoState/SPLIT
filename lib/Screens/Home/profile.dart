import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:split/Services/database.dart';
import 'package:split/Screens/Home/users_list.dart';
import 'package:split/Models/appUser.dart';
import '../../Models/appUser.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser!;
final String _uid = user.uid.toString();
String username ='_______';
String email = '_______';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  var docRef = FirebaseFirestore.instance.collection('User').doc(_uid).snapshots().listen((docSnapshot) {
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      username = data['username'].toString();
      email = data['email'].toString();
    }else{
    }
  });


  // String
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)  {

    bool notifications = false;

    // print(username);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Profile",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.yellowAccent[400],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget> [
              // UserList(),
              const SizedBox(height: 20.0,),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Icon(Icons.person),
                  ),
                  const SizedBox(width: 40.0,),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      //replace text with profile details
                      Text(
                        "User Name: " + username,
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(height: 10.0,),
                      Text(
                        "Email: " + email,
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(height: 20.0,),
                    ],
                  ),
                ],

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                  //put in if notifications are enabled or not
                  const Text("Notifications: "),
                  //for the notifications options
                  Switch(
                    value: notifications,
                    onChanged: (value) {
                      setState(() {
                        notifications = value;
                      });
                    },
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget> [
                  SizedBox(
                    width: 400,
                    height: 200,
                    child: Card(child: Text("Payment:"),),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                  RaisedButton(
                    onPressed: () {
                      //go to edit profile screen
                      //Navigator.pushNamed(context, '/Edit Profile');
                    },
                    child: const Text('Edit Profile'),
                    color: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }
}