import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:split/Models/user.dart';
import 'package:split/Screens/Groups/gotoGroup.dart';
import 'package:split/Screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:split/Services/auth.dart';
import 'package:split/Screens/Groups/Create Groups.dart';
import 'package:split/Screens/Home/home.dart';
import 'firebase_options.dart';
import 'package:split/Screens/Home/group.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      initialData: null,
      value: AuthService().user,
        child: MaterialApp(
          home: Wrapper(),
          routes: {
            '/createGroup' : (context) => Create_Group(),
            '/Group' : (context) => const Group(),
            '/gotoGroup': (context) =>  Goto_group(),
            '/home': (context) =>  Home(),
          },
      ),
    );
  }
}


