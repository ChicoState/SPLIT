import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:split/Models/user.dart';
import 'package:split/Models/appUser.dart';

class DataBaseService {
  final String uid;
  DataBaseService({required this.uid});
  DataBaseService.withoutUID() : uid = "";
  //DataBaseService({required this.uid});

  //collection reference
  final CollectionReference userGroup =
      FirebaseFirestore.instance.collection('User');
  final CollectionReference groups =
      FirebaseFirestore.instance.collection('Groups');

  Future updateUserData(String email, String name, String username,
      String notification, String uid1) async {
    return await userGroup.doc(uid).set({
      'email': email,
      'name': name,
      'username': username,
      'notification': notification,
      'uid': uid1,
    });
  }

  // Future<dynamic> getData() async {
  //   dynamic data;
  //   final DocumentReference document = FirebaseFirestore.instance.collection(
  //       "User").doc(uid);
  //   await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
  //     data = snapshot.data;
  //   });
  // }
  // Stream<QuerySnapshot> getStream() {
  //   return userGroup.snapshots();
  // }
  // Future<dynamic> getData() async {
  //   return await FirebaseFirestore.instance
  //       .collection("User")
  //       .where("email", isEqualTo: "email_here")
  //       .getDocuments();
  // }

  // dynamic getData() {
  //
  //   final DocumentReference document = FirebaseFirestore.instance.collection(
  //       "User").doc(uid);
  //   val snapshot = document.get();
  //   return snapshot.data;
  // }

  //get user list from snapshot
  List<AppUser> _myUserListFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return AppUser(
          uid: doc.data().toString().contains('uid')
              ? doc.get('uid')
              : 'cannot find',
          name: doc.data().toString().contains('name')
              ? doc.get('name')
              : 'cannot find',
          username: doc.data().toString().contains('username')
              ? doc.get('username')
              : 'cannot find',
          email: doc.data().toString().contains('email')
              ? doc.get('email')
              : 'cannot find',
          notification: doc.data().toString().contains('notification')
              ? doc.get('notification')
              : 'cannot find',
          groupId: doc.data().toString().contains('groupID')
              ? doc.get("groupID")
              : 'none',
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  //getStream
  Stream<List<AppUser>> get user {
    return userGroup.snapshots().map(_myUserListFromSnapshot);
  }

  Stream<List<AppUser>> get group {
    return groups.snapshots().map(_myUserListFromSnapshot);
  }
}

//return user email
Future<String> getUserEmail() async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final User? user = _auth.currentUser;
  return user?.email;
}

/*
//create group
Future createGroup(String groupName, String leaderName, List<String> memberNames, String payment) async {
  String result = "error";

  try{
    return await groups.doc().set({
      'email' : email,
      'name': name,
      'notification' : notification,
      'uid' : uid1,
    });
  } catch (e)
  {
    print(e);
  }

}
*/