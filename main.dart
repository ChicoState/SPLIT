import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Login(),
      '/homepage': (context) => HomePage(),
      '/register': (context) => Register()
    },
  ));
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.yellow,
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text('Login'),
                onPressed: () {
                  Navigator.pushNamed(context, '/homepage');
                },
              ),
              RaisedButton(
                child: Text('Register'),
                onPressed: (){
                  Navigator.pushNamed(context, '/register');
                },
              ),
            ],
          )),
    );
  }
}

class HomePage extends StatelessWidget{
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("SPLIT"),
          backgroundColor: Colors.yellow,
          automaticallyImplyLeading: false,
        ),
        body: TabBarView(
          children: [
            Container(
              child: Icon(Icons.home),
            ),
            Container(
              child: Icon(Icons.group),
            ),
            Container(
              child: Icon(Icons.account_box),
            ),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.home),
            ),
            Tab(
              icon: Icon(Icons.group),
            ),
            Tab(
              icon: Icon(Icons.account_box),
            ),
          ],
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.black38,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Theme.of(context).primaryColor
        ),
      ),
    );
  }
}

class Register extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: Colors.yellow,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: <Widget> [
            RaisedButton(
              child: Text('Back'),
              onPressed: (){
                Navigator.pushNamed(context, '/');
              },
            ),
            RaisedButton(
              child: Text('register'),
              onPressed: (){
                Navigator.pushNamed(context, '/homepage');
              },
            )
          ],
        ),
      ),
    );
  }
}

