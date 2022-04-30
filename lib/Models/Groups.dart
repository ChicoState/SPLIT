import 'package:cloud_firestore/cloud_firestore.dart';

class Groups {
  final String groupName;
  final List<String> members;
  final String leader;
  final  Timestamp creationDate;
  final DateTime paymentDue;
  final double paymentTotal;
  final double split;

  Groups({required this.groupName, required this.members, required this.leader, required this.creationDate, required this.paymentDue, required this.paymentTotal, required this.split});

}