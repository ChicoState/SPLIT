import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:split/Models/user.dart';
import 'package:split/Screens/Authenticate/authenticate.dart';
import 'package:split/Screens/Home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    //return home authenticate
    if(user == null){
      return Authenticate();
    }
    else{
      return Home();
    }
  }
}
