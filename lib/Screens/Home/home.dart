import 'package:flutter/material.dart';
import 'package:split/Services/auth.dart';
import 'package:provider/provider.dart';
import 'package:split/Services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
        body: TabBarView(
          children: [
            Container(
              child: const HomeScreen(),
            ),
            Container(
              child: const Group(),
            ),
            Container(
              child: const Profile(),
            ),
          ],
        ),
        bottomNavigationBar: TabBar(
            tabs: [
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


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool notifications = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Name (First and Last Name)",
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

                /*
                Image.network('https://www.tuktukdesign.com/wp-content/uploads/2021/03/person-icon.jpg',
                  height: 100,
                  width: 100,
                ),
                */


                const SizedBox(width: 40.0,),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    //replace text with profile details
                    Text(
                      "Username: __________",
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 10.0,),
                    Text(
                      "Phone: __________",
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 10.0,),
                    Text(
                      "Country: __________",
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 10.0,),
                    Text(
                      "Email: __________",
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
                    //does something
                  },
                  child: const Text('Edit Profile'),
                  color: Colors.blue,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                child: const Text('Logout'),
                color: Colors.blue,
              ),
            ),
          ],
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
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget> [
            Row(
              children: const <Widget> [
                //put the list of groups here???
                SizedBox(
                  width: 400,
                  height: 400,
                  child: Card(
                    child: Text(
                      'Group List:',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget> [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    onPressed: () {
                      //go to create group page
                      //Navigator.pushNamed(context, '/register');
                    },
                    child: const Text('Create Group'),
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {

  final valueHolder = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.yellowAccent[400],
        title: Row(
          children: <Widget> [
            const SizedBox(
                width: 130.0,
                child: Icon(Icons.search)
            ),
            SizedBox(
              width: 240.0,
              child: TextField(
                controller: valueHolder,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: "Find Friends or Groups",
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            Text("Placeholder Calendar"),
            //placeholder calendar.  Should replace with google calendar

            // TableCalendar(
            //   firstDay: DateTime.utc(2010, 10, 16),
            //   lastDay: DateTime.utc(2030, 3, 14),
            //   focusedDay: DateTime.now(),
            // ),


            /*
            const SizedBox(height: 20.0),

            Row(
              //maybe don't need buttons? account info is already there
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget> [
                FlatButton.icon(
                  onPressed: () {
                    // go to create group page "const CreateGroup()";
                  },
                  label: Text('Add Groups'),
                  icon: Icon(Icons.add),
                  color: Colors.blue,
                ),
                const SizedBox(width: 20.0,),
                FlatButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                  label: Text('Account info'),
                  icon: Icon(Icons.face),
                  color: Colors.blue,
                ),
              ],
            ),
            */
          ],
        ),
      ),
    );
  }
}
