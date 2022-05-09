import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:split/Models/user.dart';
import 'package:split/Services/auth.dart';
import 'package:provider/provider.dart';
import 'package:split/Services/database.dart';
// import 'package:split/Screens/Groups/Create Groups.dart';
// import 'package:split/Screens/Groups/gotoGroup.dart';
import 'package:split/Services/database.dart';
import 'package:split/Screens/Home/users_list.dart';
import 'package:split/Models/appUser.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../Models/appUser.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser!;

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    String _username="";
    String _uid = user.uid.toString();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('SPLIT'),
          backgroundColor: Colors.yellow,
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
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
            children: <Widget> [
              UserList(),
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
                    children: const [
                      //replace text with profile details
                      Text(
                        "Full Name: __________",
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
  //need to have the size of groups below
  List<int> text = [1,2,3,4];
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
                  height: 30,
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
              children: [
                GroupList()
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: <Widget> [
            //     Align(
            //       alignment: Alignment.bottomCenter,
            //       child: RaisedButton(
            //         onPressed: () {
            //           //go to create group screen
            //           Navigator.pushNamed(context, '/createGroup');
            //         },
            //         child: const Text('Create Group'),
            //         color: Colors.blue,
            //       ),
            //     ),
            //   ],
            // ),

          ],

        ),

      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/createGroup');
        },
        backgroundColor: Colors.green,
        icon: const Icon(Icons.add),
        label: const Text('Create'),
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
                SizedBox(
                  height: 500,
                  width: 500,
                  child: SfCalendar(
                    view: CalendarView.month,
                    initialSelectedDate: DateTime.now(),
                    dataSource: MeetingDataSource(_getDataSource()),
                    monthViewSettings: MonthViewSettings(
                        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),

                  ),
                ),

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

// calender sample --------------------------
class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
  DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  meetings.add(Meeting(
      'Payment', startTime, endTime, const Color(0xFF0F8644), false));
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

//----------------------------- calender sample----------------------------







class GroupList extends StatelessWidget{


  @override
  Widget build(BuildContext context){
    final Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance.collection('Groups').snapshots();
    return Container(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: dataStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                if (snapshot.hasError){
                  //ToDO add snapbar
                }
                if(snapshot.connectionState==ConnectionState.waiting){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final List storedocs =[];
                snapshot.data!.docs.map((DocumentSnapshot document){
                  Map a = document.data() as Map<String, dynamic>;
                  storedocs.add(a);
                  // print(a.toString());
                }).toList();


                return Column(

                  children: List.generate(
                      storedocs.length,
                          (i)=>Container(

                            padding: EdgeInsets.all(5),
                            // margin: EdgeInsets.all(5),

                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context,
                                  '/gotoGroup',
                                  arguments: GroupArguments (storedocs[i])
                                );
                              },
                            child: Column(
                        children: [
                            Text( 'Group name: ' + storedocs[i]['groupName']
                            ),
                            const SizedBox(height:10, width: 200,),
                            Text(
                                'Leader name: ' + storedocs[i]['leaderName']
                            )
                        ],
                      ),
                            ),
                            )
                  ),
                );
              },
            )
          ],
        ),
      );
    // return Container(
    //   child: ElevatedButton(
    //     onPressed: () {
    //       Navigator.pushNamed(context, '/gotoGroup');
    //       },
    //     child: Container(
    //       width: 100,
    //       // height: 50,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Text("Group1"),
    //           Icon(Icons.person),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}

class GroupArguments {
  final Map groupid;

  GroupArguments(this.groupid);
}