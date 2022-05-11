import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';




class Group extends StatefulWidget {
  const Group({Key? key}) : super(key: key);

  @override
  State<Group> createState() => _GroupState();
}


class _GroupState extends State<Group> {
  // This widget is the root of your application.

  final groupvalueHolder = TextEditingController();
  //need to have the size of groups below
  List<int> text = [1,2,3,4];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.yellowAccent[400],
        title: Row(
          children: <Widget> [
            Container(
                width: 130.0,
                child: Icon(Icons.search)
            ),
            Container(
              width: 240.0,
              child: TextField(
                controller: groupvalueHolder,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: "Groups",
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget> [
            Row(
              children: const <Widget> [
                //put the list of groups here???
                SizedBox(
                  width: 400,
                  height: 30,
                  child: Card(
                    child: Text(
                      'Group List:',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GroupList()
              ],
            ),

          ],

        ),

      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/createGroup');
        },
        backgroundColor: Colors.green,
        icon: const Icon(Icons.add),
        label: const Text('Create'),
      ),
    );


  }
}
class GroupList extends StatelessWidget{


  @override
  Widget build(BuildContext context){
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser!;
    final String _uid = user.uid.toString();
    // print(_uid);

    List storeGroups =[];
    var docRef = FirebaseFirestore.instance.collection('User').doc(_uid).snapshots().listen((docSnapshot) {
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data()!;
        storeGroups = data['Groups'];
      }
    });
    print(storeGroups.length);
    final Stream<QuerySnapshot> subDataStream = FirebaseFirestore.instance.collection('Groups').snapshots();

    return Container(
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: subDataStream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (snapshot.hasError){
                //ToDO add snapbar
              }
              if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }


              // snapshot.data?.docs.map((DocumentSnapshot document)
              final List storedocs =[];
              for(int i=0;i<storeGroups.length;i++){
                snapshot.data!.docs.map((DocumentSnapshot document){
                  Map a = document.data() as Map<String, dynamic>;
                  if(a["groupid"].toString() == storeGroups[i]){
                    storedocs.add(a);
                  }
                  // print(a.toString());
                  // print(storedocs.length);
                }).toList();
              }


              return Column(
                children: List.generate(
                    storedocs.length,
                        (i)=>Container(

                      padding: EdgeInsets.all(5),
                      // margin: EdgeInsets.all(5),

                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context,
                              '/gotoGroup',
                              arguments: GroupArguments (storedocs[i])
                          );
                        },
                        child: Column(
                          children: [
                            Text( 'Group name: ' + storedocs[i]['groupName']
                            ),
                            const SizedBox(height:10, width: 200,),
                            Text(
                                'Leader name: ' + storedocs[i]['leaderName']
                            )
                          ],
                        ),
                      ),
                    )
                ),
              );
            },
          ),

        ],
      ),
    );
  }
}

class GroupArguments {
  final Map groupid;

  GroupArguments(this.groupid);
}