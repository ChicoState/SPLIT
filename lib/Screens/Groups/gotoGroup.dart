import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:split/Screens/Home/group.dart';


// class Goto_group extends StatefulWidget {
//   @override
//   State<Goto_group> createState() => _Goto_GroupState();
// }

class Goto_group extends StatelessWidget {
  const Goto_group({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    // final arguments = (ModalRoute.of(context)?.settings.arguments ?? <dynamic>{}) as Map;
    final arguments = ModalRoute.of(context)!.settings.arguments as GroupArguments;

    print(arguments.groupid.toString());
    final String groupName = arguments.groupid["groupName"];
    final double totalPayment = arguments.groupid["totalPayment"];
    final String leaderName = arguments.groupid["leaderName"];
    final List members = arguments.groupid["members"];
    final double splitPayment = arguments.groupid["splitPayment"];
    final DateTime paymentDate = arguments.groupid["paymentDate"].toDate();

    final Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance.collection('Groups').snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(groupName),
           ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
                  Container(
                    alignment: Alignment.center,
                    // width: 100,
                    padding: const EdgeInsets.all(20),
                    margin: EdgeInsets.all(20),
                    color: Colors.blue,
                    child:   Text("Leader: " + leaderName)
                  ),
                  Container(
                      alignment: Alignment.center,
                      // width: 100,
                      padding: const EdgeInsets.all(20),
                      margin: EdgeInsets.all(20),
                      color: Colors.red,
                      child:   Text("totalPayment: \$" + totalPayment.toString())
                  ),
                 Container(
                      child: Column(
                      children: List.generate(
                            members.length,
                                (i)=>Column(
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    // width: 100,
                                    padding: const EdgeInsets.all(20),
                                    margin: EdgeInsets.all(2),
                                    color: Colors.greenAccent,
                                    child:   Text("member: " + (i+1).toString() +" " + members[i] + "\nPayment: \$" + splitPayment.toString())
                                ),
                                // const SizedBox(height:20,)
                              ],
                            )
                      ),
                    ),
                 ),
                Container(
                    alignment: Alignment.center,
                    // width: 100,
                    padding: const EdgeInsets.all(20),
                    margin: EdgeInsets.all(20),
                    color: Colors.grey,
                    child:   Text("paymentDate: " + paymentDate.toString())
                ),

          ],
        ),
      ),
    );
    // return StreamBuilder<List<AppUser>>(
    //
    //   //表示したいFiresotreの保存先を指定
    //     stream: db.user,
    //
    //     //streamが更新されるたびに呼ばれる
    //     builder: (BuildContext context,
    //         AsyncSnapshot<List<AppUser>> snapshot) {
    //
    //       //データが取れていない時の処理
    //       if (!snapshot.hasData) return const Text('Loading...');
    //       String? str = snapshot.data?.toString();
    //       return Text(str!);
    //
    //     }
    // );

    // dynamic data= db.getData();
    // String? username;

    // body: StreamBuilder<QuerySnapshot>(
    //     stream: db.getStream(),
    //     builder: (context, snapshot) {
    //       if (!snapshot.hasData) return LinearProgressIndicator();
    //
    //       return _buildList(context, snapshot.data?.docs ?? []);
    //     }),
    //
    //
    // return Container(
    //   child: ElevatedButton(
    //     onPressed: () {
    //       Navigator.pushNamed(context, '/gotoGroup');
    //     },
    //     child: Container(
    //       width: 100,
    //       // height: 50,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Text(data.toString()),
    //           Icon(Icons.person),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}