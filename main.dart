import 'package:flutter/material.dart';




void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //
  final List<String> names = [];

  final textFieldValueHolder = TextEditingController();

  //late final TextEditingController _names = TextEditingController();
  late final TextEditingController _payment = TextEditingController();

  late final TextEditingController _date = TextEditingController();

  late final TextEditingController _notifications = TextEditingController();

  late final TextEditingController _split = TextEditingController();

  void _calculate() {
  }

  void _addnames() {
    final String name = textFieldValueHolder.text;
    if (name == '') {
      print("empty");
    } else {
      names.add(name);
      print(names);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Split'),
        centerTitle: true,
        backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            const Text(
              "Group Creation",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            PopupMenuButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                child: Text("Add Names/People"),
              ),
                  itemBuilder: (context) => [
              PopupMenuItem(
              child: TextField (
              controller: textFieldValueHolder,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: "Enter names"
              ),
            ),
      ),
    ),

            TextField(
              controller: _payment,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: "Total Payment"
              ),
            ),
            TextField(
              controller: _date,
              keyboardType: TextInputType.datetime,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: "Date Payment due"
              ),
            ),
            TextField(
              controller: _notifications,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: "Notifications"
              ),
            ),
            TextField(
              controller: _split,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: "How do you want to split?"
              ),
            ),
            TextButton(
              onPressed: () async{
                //final name = _names.text;
                final payment = _payment.value;
                final date = _date.text;
                final notifications = _notifications.selection;
                final split = _split.selection;
              },
              child: const Text(
                  "Create Group"),

            ),
          ],
        ),
      ),
    );
  };

