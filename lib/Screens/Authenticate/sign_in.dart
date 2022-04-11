import 'package:flutter/material.dart';
import 'package:split/Services/auth.dart';
import 'package:split/shared/constants.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();//so we can use the sign in class
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {//makes the sign in screen
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text('Sign in to SPLIT'),
        actions: <Widget>[//buttton that switches between sign in and register
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () => widget.toggleView(),
          )
        ],
      ),
      body: Container(//where the sign in page is
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget> [
              SizedBox(height: 20.0),//Email stuff
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (String?val){//making sure the email form is filled
                  if(val != null && val.isEmpty){
                    return "Email can't be empty";
                  }
                  return null;
                },
                onChanged: (val){setState(() => email = val.trim());}
              ),
              SizedBox(height: 20.0),//Password stuff
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (String?val){//making sure the password form is filled
                  if(val != null && val.length < 6){
                    return "Enter a password with more than 6 char";
                  }
                  return null;
                },
                onChanged: (val){setState(() => password = val.trim());}
              ),
              SizedBox(height: 20.0),//sign in button
              RaisedButton(
                color: Colors.red,
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async{
                  if(_formKey.currentState!.validate()){
                    dynamic result = await _auth.signInWithEmailAndPassword(email.trim(), password.trim());
                    if(result == null){
                      setState(() {
                        error = 'Could not sign in';
                      });
                    }
                  }
                }
              ),
              SizedBox(height: 15.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
