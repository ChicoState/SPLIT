import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:split/Services/auth.dart';
import 'package:split/Screens/Home/profile.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:split/Screens/Home/group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser!;
final String _uid = user.uid.toString();

List storePayments =[];



class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    String _username="";
    String _uid = user.uid.toString();
    var docRef = FirebaseFirestore.instance.collection('User').doc(_uid).snapshots().listen((docSnapshot) {
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data()!;
        storePayments = data['payments'];
        // print(storePayments);
      }
    });
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

  // print(_uid);

  // print(storePayments);
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  for(int i=0;i<storePayments.length;i++){
    // print(storePayments[i]);
    final DateTime startTime = storePayments[i].toDate();
    // print(startTime);
    // DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Payment', startTime, endTime, const Color(0xFF0F8644), false));
  }
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







