// import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
//
// void main() {
//   final instance = FakeFirebaseFirestore();
//   await instance.collection('users').add({
//     'username': 'Bob',
//   });
//   final snapshot = await instance.collection('users').get();
//   print(snapshot.docs.length); // 1
//   print(snapshot.docs.first.get('username')); // 'Bob'
//   print(instance.dump());
// }
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

// this the test for making group in the firestore cloud
void main()  {
  testWidgets('Check if firestore works', (WidgetTester tester) async {
    final instance = FakeFirebaseFirestore();
    final List<String> memberNames = [];
    memberNames.add('Jonathan');
    memberNames.add('Alex');
    memberNames.add('Wataru');
    memberNames.add('Dylan');
    await instance.collection('Groups').add({
      'groupName': 'group1 ',
      'leaderName': 'Javier',
      'members': memberNames
    });
    final snapshot =  await instance.collection('Groups').get();
    print(snapshot.docs.length); // 1
    print(snapshot.docs.first.get('Groups'));
    print(instance.dump());
  });


  testWidgets('Check if users are being created', (WidgetTester tester) async {
    final instance = FakeFirebaseFirestore();
    String email = "123@gmail.com";
    String uid1 = "123akhfkjsahfd";
    String name = "Bill Nye";
    String username = name;
    String notification = "True";

    await instance.collection('User').add({
      'email' : email,
      'name': name,
      'username': username,
      'notification' : notification,
      'uid' : uid1,
    });
    final snapshot =  await instance.collection('User').get();
    print(snapshot.docs.length); // 1
    print(snapshot.docs.first.get('User'));
    print(instance.dump());
  });

}