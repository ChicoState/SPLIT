import 'package:flutter/material.dart';
import 'package:split/shared/constants.dart';
import 'package:split/Screens/wrapper.dart';

class Create_Group extends StatefulWidget {
  @override
  State<Create_Group> createState() => _Create_GroupState();
}

class _Create_GroupState extends State<Create_Group> {

  //variables
  final List<String> memberNames = [];
  String groupName = '';
  String leaderName = '';
  String memberName = '';
  String payment = '';
  var paymentDate = '';
  var groupCreation = '';

  double calculate(double payment, int members) {
    double split = 0.00;
    split = payment/members;
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
              const SizedBox(height: 20.0),//Group Name stuff
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Group Name'),
                  textInputAction: TextInputAction.next,
                  validator: (String?val){//making sure the Group Name is filled
                    if(val != null && val.isEmpty){
                      return "Group Name can't be empty";
                    }
                    return null;
                  },
                  onChanged: (val){setState(() => groupName = val.trim());}
              ),
              const SizedBox(height: 20.0),//Group Leader Name stuff
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Leader Name'),
                  textInputAction: TextInputAction.next,
                  validator: (String?val){//making sure the Leader Name is filled
                    if(val != null && val.isEmpty){
                      return "Leader Name can't be empty";
                    }
                    return null;
                  },
                  onChanged: (val){setState(() => leaderName = val.trim());}
              ),

              const SizedBox(height: 20.0),//Member Name stuff


              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Member Name'),
                  textInputAction: TextInputAction.next,
                  validator: (String?val){//making sure the email form is filled
                    if(val != null && val.isEmpty){
                      return "Member Name can't be empty";
                    }
                    return null;
                  },
                  onChanged: (val) async {
                    setState(() => memberName = val.trim());
                    //addnames(memberName);
                  }
              ),
              IconButton(
                onPressed: () {
                  if(memberName.isNotEmpty) {
                    addnames(memberName);
                  }
                },
                icon: const Icon(Icons.add),
              ),

              const SizedBox(height: 20.0),//Payment Date stuff
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Payment Date'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.datetime,
                  validator: (String?val){//making sure the email form is filled
                    if(val != null && val.isEmpty){
                      return "Payment Date can't be empty";
                    }
                    return null;
                  },
                  onChanged: (val){setState(() => paymentDate = val.trim());}
              ),
              const SizedBox(height: 20.0),//Payment Amount stuff
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: '\$ Payment Amount'),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  validator: (String?val){//making sure the email form is filled
                    if(val != null && val.isEmpty){
                      return "Payment Amount can't be empty";
                    }
                    return null;
                  },
                  onChanged: (val){setState(() => payment = val.trim());}
              ),
              RaisedButton(
                onPressed: () async {
                  DateTime now = DateTime.now();
                  var payment1 = double.parse(payment);
                  print(now);
                  print(groupName);
                  print(leaderName);
                  print(memberNames);
                  print(paymentDate);
                  print(payment1);
                  double total = calculate(payment1, memberNames.length);
                  print(total);
                  Navigator.defaultRouteName;
                  Navigator.pushNamed(context, '/Group');
                },
                child: const Text(
                    "Create Group"),

              ),
            ],
          ),
        ),
      ),
    );
  }
}