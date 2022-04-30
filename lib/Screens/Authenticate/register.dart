import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:split/Services/auth.dart';
import 'package:split/shared/constants.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  const Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();//so we can use the sign in class
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';
  String fullName = '';
  bool notifications = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: const Text('Sign Up for SPLIT'),
        actions: <Widget> [
          FlatButton.icon(
              icon: const Icon(Icons.person),
              label: const Text('Sign In'),
              onPressed: () => widget.toggleView(),
          )
        ],

      ),
      body: SingleChildScrollView(
        child: Container(//where the sign in page is
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget> [
                  const Text(
                    "Register",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 20.0),//Name stuff
                  TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Full Name'),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (String?val){//making sure the email form is filled
                        if(val != null && val.isEmpty){
                          return "Name can't be empty";
                        }
                        return null;
                      },

                      onChanged: (val){setState(() => fullName = val.trim());}
                  ),
                  const SizedBox(height: 20.0),//Email stuff
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (String?val){//making sure the email form is filled
                      if(val != null && val.isEmpty){
                        return "Email can't be empty";
                      }
                      return null;
                    },
                    onChanged: (val){setState(() => email = val.trim());}
                  ),
                  const SizedBox(height: 20.0),//Password stuff
                  TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Password'),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      validator: (String?val){//making sure the password form is filled
                        if(val != null && val.length < 6){
                          return "Enter a password with more than 6 char";
                        }
                        return null;
                      },
                      onChanged: (val){setState(() => password = val.trim());}
                  ),
                  const SizedBox(height: 20.0),//notifications
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget> [
                      //put in if notifications are enabled or not
                      const Text("Notifications: "),
                      //for the notifications options
                      Switch(
                        value: notifications,
                        onChanged: (value) {
                          setState(() {
                            notifications = value;
                            print(notifications);
                          });
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),//sign in button
                  RaisedButton(
                      color: Colors.red,
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async{
                        if(_formKey.currentState!.validate()){
                          //loading screen
                          setState(() => loading = true);
                          dynamic result = await _auth.registerWithEmailAndPassword(email.trim(), password.trim(), fullName.trim(), notifications.toString().trim());
                          if(result == null){
                            setState(() {
                              error = 'Please supply a valid email';
                              loading = false;
                            });
                          }
                        }
                      }
                  ),
                  const SizedBox(height: 15.0),
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
