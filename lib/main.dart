import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:split/Models/user.dart';
import 'package:split/Screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:split/Services/auth.dart';
import 'package:split/Screens/Groups/Create Groups.dart';
import 'package:split/Screens/Home/home.dart';
import 'firebase_options.dart';

import 'package:googleapis/calendar/v3.dart' hide Colors;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:add_2_calendar/add_2_calendar.dart' as i01;
import 'package:intl/intl.dart';


void main() => runApp(DateTimePicker());

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
  final _descController = TextEditingController();
  final _ocController = TextEditingController();
  final _intController = TextEditingController();
  String _date = "Date of Event";
  String _name = "Not Set";
  String _desc = "Not set";
  DateTime started = DateTime.now();
  DateTime ended = DateTime.now();
  DateTime dated = DateTime.now();
  int _ver = 0;
  int _oc = 0;

  i01.Event buildEvent({required var date, required var date2, required var title, required var desc, required var recurrence}) {
    return i01.Event(
      title: title,
      description: desc,
      location: 'SPLIT',
      startDate: DateTime(date),
      endDate: DateTime(date2),
      allDay: true,
      androidParams: i01.AndroidParams(
        emailInvites: ["arcollanton@gmail.com", "jvi1@mail.csuchico.edu"]
      ),
      recurrence: recurrence,
    );
  }




  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Creating Event...'),
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
                        _date ='${date.month}/${date.day}/${date.year}';// '${date.year} - ${date.month} - ${date.day}';
                        dated = DateFormat('MM/dd/yy').parse(_date);
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

              TextFormField(//START OF ENTEREVENT
                controller: _nameController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter Event name',
                ),
              ),//END OF ENTEREVENT
              TextFormField(//START OF ENTERDESC
                controller: _descController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter description of Event',
                ),
              ),//END OF ENTERDESC
              TextFormField(//START OF ENTERINT
                controller: _intController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter interval(For google calendar)',
                ),
              ),//END OF ENTERINT
              TextFormField(//START OF ENTEROC
                controller: _ocController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter number of Ocurrences(For google calendar)',
                ),
              ),//END OF ENTEROC
              TextButton(
                  onPressed:(){
                    _name = _nameController.text;
                    _desc = _descController.text;
                    _ver = int.parse(_intController.text);
                    _oc = int.parse(_ocController.text);
                    i01.Event _event = i01.Event(endDate: dated, startDate: dated, title: _name, description: _desc, recurrence: i01.Recurrence(
                      frequency: i01.Frequency.monthly,
                        interval: _ver,
                        ocurrences: _oc,
                    ));
                    i01.Add2Calendar.addEvent2Cal(_event);
                  },
                  child: Text("Enter Event")
              ),
            ],
          ),
        ),
      ),
    );
  }

}
