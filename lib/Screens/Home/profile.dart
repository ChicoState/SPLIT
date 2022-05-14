import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:split/Services/database.dart';
import 'package:split/Screens/Home/users_list.dart';
import 'package:split/Models/appUser.dart';
import '../../Models/appUser.dart';
import 'package:split/Services/database.dart';
import 'package:split/Services/auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser!;
final String _uid = user.uid.toString();
String username ='_______';
String email = '_______';
List groups = [];
List payments = [];
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
    String password = '';
    String error = '';
    String fullName = '';
    bool notifications = false;
    User user = auth.currentUser!;
    AuthService _auth = AuthService();


  var docRef = FirebaseFirestore.instance.collection('User').doc(_uid).snapshots().listen((docSnapshot) {
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      username = data['username'].toString();
      email = data['email'].toString();
      groups = data['Groups'];
      payments = data['payments'];
    }else{
    }
  });


  // String
  // This widget is the root of your application.
    Widget _buildFutureBuilder() {
      return FutureBuilder(
        future: _auth.currUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Text(snapshot.data != null ? snapshot.data.toString() : ""),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      );
    }

    //future builder for getUserEmail()
    Widget _buildFutureBuilderEmail() {
      return FutureBuilder(
        future: _auth.getUserEmail(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Text(snapshot.data != null ? snapshot.data.toString() : ""),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      );
    }

    // String
    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
      return StreamProvider<List<AppUser>>.value(
        value: DataBaseService(uid: '').user,
        initialData: [],
        child: Scaffold(
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
              children: <Widget>[
                UserList(),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Icon(Icons.person),
                    ),
                    const SizedBox(
                      width: 40.0,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //replace text with profile details
                        //create
                        Text(
                          "Full Name: " + username,
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Email: " + email,
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
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
                //New row with text forms to change email, name, username, and notification settings
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 350,
                      height: 50,
                      child: Card(
                        child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (String? val) {
                              //making sure the email form is filled
                              if (val != null && val.isEmpty) {
                                return "Email can't be empty";
                              }
                              return null;
                            },
                            onChanged: (val) {
                              setState(() => email = val.trim());
                            }),
                      ),
                    ),
                  ],
                ),
                //now for the name
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 350,
                      height: 50,
                      child: Card(
                        child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            validator: (String? val) {
                              //making sure the name form is filled
                              if (val != null && val.isEmpty) {
                                return "Name can't be empty";
                              }
                              return null;
                            },
                            onChanged: (val) {
                              setState(() => fullName = val.trim());
                            }),
                      ),
                    ),
                  ],
                ),
                //now for the username
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 350,
                      height: 50,
                      child: Card(
                        child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Username',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            validator: (String? val) {
                              //making sure the username form is filled
                              if (val != null && val.isEmpty) {
                                return "Username can't be empty";
                              }
                              return null;
                            },
                            onChanged: (val) {
                              setState(() => username = val.trim());
                            }),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //create an 'Edit Profile' button that will update the user's profile using _auth.updateUser
                    SizedBox(
                      width: 350,
                      height: 50,
                      child: Card(
                        child: RaisedButton(
                            child: Text(
                              'Edit Profile',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            color: Colors.green,
                            onPressed: () async {
                              //update the user's profile
                              _auth.updateUser(email, fullName, username, groups, payments,
                                  notifications.toString());
                            }),
                      ),
                    ),
                  ],
                ),
                //Display all of the new profile details
                //create the _buildFutureBuilder
              ],
            ),
          ),
        ),
      );
    }
}
