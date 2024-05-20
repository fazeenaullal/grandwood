import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_project/Helper.dart';
import 'package:flutter/material.dart';
class AdminPanel extends StatelessWidget {
  // const AdminPanel({super.key});
AuthService authService=AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: Text("Admin Panel"),
),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Orders").snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasData){
return ListView.builder(
  itemCount: snapshot.data!.docs.length,

    itemBuilder: (context,i){
      DocumentSnapshot document=snapshot.data!.docs[i];
      String docId=document.id;
return SingleChildScrollView(
  child: ListTile(

    // margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
    // color: Colors.green.shade200,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Name: "+snapshot.data!.docs[i]["name"]),
        SizedBox(
  height: 10,
        ),
        Text("Address: "+snapshot.data!.docs[i]["address"]),
        SizedBox(
          height: 10,
        ),
        Text("Item_Ordered: "+snapshot.data!.docs[i]["order"]),
        SizedBox(
          height: 10,
        ),
        Text("Amount: "+snapshot.data!.docs[i]["amount"]),
        SizedBox(
          height: 10,
        ),
        Text("Phone_number: "+snapshot.data!.docs[i]["number"]),
      ],
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // IconButton(
        //   onPressed:() => openNoteBox(docId: docId),
        //   icon: const Icon(Icons.settings),
        //
        // ),
        IconButton(
          onPressed:() => authService.deleteData(docId),
          icon: const Icon(Icons.delete),

        ),
      ],
    ),
  ),
);
    }
);
          }else{
return CircularProgressIndicator();
          }
        },

      ),
    );
  }
}
