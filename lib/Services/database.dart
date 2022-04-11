import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService{

  //collection referernce
  final CollectionReference userGroup = FirebaseFirestore.instance.collection('Groups');

}