import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:split/Models/user.dart';
import 'package:split/Models/appUser.dart';
class DataBaseService{
  final String uid;
  DataBaseService( {required this.uid} );
  DataBaseService.withoutUID() : uid = "";
  //DataBaseService({required this.uid});


  //collection reference
  final CollectionReference userGroup = FirebaseFirestore.instance.collection('User');

  Future updateUserData(String email, String name, bool notification) async {
    return await userGroup.doc(uid).set({
      'email' : email,
      'name': name,
      'notifications' : notification,
    });
  }

  //get user list from snapshot
  List<AppUser> _myUserListFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return AppUser(
            uid: doc.data().toString().contains('UID') ? doc.get('UID') : '',
            name: doc.data().toString().contains('name') ? doc.get('name') : '',
            email: doc.data().toString().contains('email') ? doc.get('email') : '',
        );
      }).toList();
    } catch(e) {
      print(e.toString());
      return [];
    }
  }

  //getStream
  Stream<List<AppUser>> get user {
    return userGroup.snapshots()
    .map(_myUserListFromSnapshot);
  }
}