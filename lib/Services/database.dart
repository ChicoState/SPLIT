import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService{
  final String uid;
  DataBaseService({required this.uid});

  //collection referernce
  final CollectionReference userGroup = FirebaseFirestore.instance.collection('User');

  Future updateUserData(String name) async {
    return await userGroup.doc(uid).set({
      'name':name,
    });
  }

  Stream<QuerySnapshot> get User {
    return userGroup.snapshots();
  }
}