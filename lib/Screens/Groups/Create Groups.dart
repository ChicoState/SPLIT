import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:split/shared/constants.dart';
import 'package:split/Screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser!;
//variables
List<String> memberNames = [];
double calculate(double payment, int members) {
  double split = 0.00;
  if (payment == 0.0) {
    return split;
  } else if (members == 0) {
    return payment;
  } else {
    split = payment / members;
    return split;
  }
}

void addnames(List<String> memberNames, String memberName) {
  String name = memberName;
  if (name == '') {
    print("empty");
  } else {
    memberNames.add(memberName);
    print(memberName);
  }
}

class Create_Group extends StatefulWidget {
  @override
  State<Create_Group> createState() => _Create_GroupState();
}

class _Create_GroupState extends State<Create_Group> {
  final String _uid = user.uid.toString();
  final fieldText = TextEditingController();
  //variables
  //final List memberNames = [];
  String add_check = '';
  String groupName = '';
  String leaderName = '';
  String paymentId = '';
  List<String> _memberName = List.filled(5, '');
  String payment = '';
  DateTime paymentDate = DateTime.now();
  var groupCreation = '';
/*
 double calculate(double payment, int members) {
  double split = 0.00;
  split = payment / members;
  return split;
 }
 void addnames(String memberName) {
  String name = memberName;
  if (name == '') {
   print("empty");
  } else {
   memberNames.add(memberName);
   print(memberName);
  }
 }
*/
  // DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: paymentDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != paymentDate) {
      setState(() {
        paymentDate = picked;
      });
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              const Text(
                "Group Creation",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 2.0,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0), //Group Name stuff
              TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Group Name'),
                  textInputAction: TextInputAction.next,
                  validator: (String? val) {
                    //making sure the Group Name is filled
                    if (val != null && val.isEmpty) {
                      return "Group Name can't be empty";
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() => groupName = val.trim());
                  }),
              const SizedBox(height: 20.0), //Group Leader Name stuff
              TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Leader Name'),
                  textInputAction: TextInputAction.next,
                  validator: (String? val) {
                    //making sure the Leader Name is filled
                    if (val != null && val.isEmpty) {
                      return "Leader Name can't be empty";
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(
                      () => leaderName = val.trim(),
                    );
                  }),
              const SizedBox(height: 20.0), //Member Name stuff
              Column(
                children: List.generate(
                  5,
                  (index) => Container(
                    padding: EdgeInsets.all(3),
                    child: TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Member Name'),
                      textInputAction: TextInputAction.next,
                      validator: (String? val) {
                        //making sure the email form is filled
                        if (val != null && val.isEmpty) {
                          return "Member Name can't be empty";
                        }
                        return null;
                      },
                      onChanged: (val) async {
                        setState(() => _memberName[index] = val.trim());
                        // addnames(memberName);
                      },
                      // controller: fieldText,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0), //paymentId stuff
              TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Payment ID'),
                  textInputAction: TextInputAction.next,
                  validator: (String? val) {
                    //making sure the paymentId is filled
                    if (val != null && val.isEmpty) {
                      return "Payment ID can't be empty";
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() => paymentId = val.trim());
                  }),
              Text(
                "${paymentDate.toLocal()}".split(' ')[0],
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()..shader),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text('Select date'),
              ),
              const SizedBox(height: 20.0), //Payment Amount stuff
              TextFormField(
                  decoration: textInputDecoration.copyWith(
                      hintText: '\$ Payment Amount'),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  validator: (String? val) {
                    //making sure the email form is filled
                    if (val != null && val.isEmpty) {
                      return "Payment Amount can't be empty";
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() => payment = val.trim());
                  }),
              ElevatedButton(
                onPressed: () async {
                  DateTime now = DateTime.now();
                  var payment1 = double.parse(payment);
                  for (int i = 0; i < _memberName.length; i++) {
                    addnames(memberNames, _memberName[i]);
                  }
                  print(now);
                  print(groupName);
                  print(leaderName);
                  print(memberNames);
                  print(paymentDate);
                  print(payment1);
                  double total = calculate(payment1, memberNames.length);
                  print(total);
                  FirebaseFirestore.instance.collection('Groups').add({
                    "groupName": groupName,
                    "leaderName": leaderName,
                    "members": memberNames,
                    "paymentDate": paymentDate,
                    "totalPayment": payment1,
                    "splitPayment": total,
                    "paymentID": paymentId,
                    "groupid": "",
                  }).then((value) {
                    FirebaseFirestore.instance
                        .collection("User")
                        .doc(_uid)
                        .update({
                      "Groups": FieldValue.arrayUnion([value.id]),
                      "payments": FieldValue.arrayUnion([paymentDate]),
                    });
                    print(value.id);
                    FirebaseFirestore.instance
                        .collection("Groups")
                        .doc(value.id)
                        .update({"groupid": value.id});
                  });
                  // her you have to get the group id from the firebase database to store the id to the user
                  //it should be a list which means you can add any group
                  Navigator.defaultRouteName;
                  Navigator.pushNamed(context, '/home');
                },
                child: const Text("Create Group"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
