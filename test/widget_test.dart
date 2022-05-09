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
<<<<<<< HEAD
*/
  /*
  testWidgets("test email", (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    //await tester.tap(find.byIcon(Icons.person));
   Widget button = find.widgetWithText(FlatButton, 'Register').evaluate().first.widget;
    button.onPressed();
    await tester.tap(find.byType(FlatButton));
    await tester.pump();

    expect(find.text("Sign up to Split"), findsOneWidget);
  });
  */

  testWidgets("test button", () {

    expect(button, findsOneWidget);
  });





}
=======
}
>>>>>>> d6256f75d083931bb48aef1d4ec0fdb043517551
