import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_project/Helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
class HomeScreen extends StatelessWidget {
  final currentUser=FirebaseAuth.instance;
  AuthService authService=AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
           StreamBuilder(
            stream: FirebaseFirestore.instance.collection("user").where("uid",isEqualTo: currentUser.currentUser!.uid).snapshots(),
            builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
             if(snapshot.hasData){

               return ListView.builder(
                 shrinkWrap: true,
                 itemCount: snapshot.data!.docs.length,
                   itemBuilder: (context,i){
                     var data=snapshot.data!.docs[i];
                 return UserAccountsDrawerHeader(accountName: Text(data["name"]), accountEmail: Text(data["email"]));
               });
             }else{
return CircularProgressIndicator();
             }
           })
          ],
        ),
      ),
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () {
            AuthService authservice=AuthService();
            authservice.logout(context);
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
       child: Column(
         children: [
           TextField(
             controller: authService.name,
             decoration: InputDecoration(
               hintText: "Name",
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(14)
               )
             ),
           ),
           SizedBox(
height: 12,
           ),
           TextField(
             controller: authService.address,
             decoration: InputDecoration(
                 hintText: "Address",
                 border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(14)
                 )
             ),
           ),
           SizedBox(
             height: 12,
           ),
           TextField(
             controller: authService.order,
             decoration: InputDecoration(
                 hintText: "Item Ordered",
                 border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(14)
                 )
             ),
           ),
           SizedBox(
             height: 12,
           ),
           TextField(
             controller: authService.amount,
             decoration: InputDecoration(
                 hintText: "Amount Paid",
                 border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(14)
                 )
             ),
           ),
           SizedBox(
             height: 12,
           ),
           IntlPhoneField(
             controller: authService.number,
             decoration: InputDecoration(
               labelText: 'Phone Number',
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(20)
               ),
             ),
             initialCountryCode: 'IN',
             onChanged: (phone) {
               print(phone.completeNumber);
             },
           ),
           // TextField(
           //   controller: authService.number,
           //   decoration: InputDecoration(
           //       hintText: "phone_Number",
           //       border: OutlineInputBorder(
           //           borderRadius: BorderRadius.circular(14)
           //       )
           //   ),
           // ),
           SizedBox(height: 12,),
           ElevatedButton(onPressed: (){
             if(authService.name!="" && authService.address!=""&& authService.order!=""&& authService.amount!=""&& authService.number!=""){
               authService.SaveUserData(context);
             }
           }, child: Text("SAVE"))
         ],
       ),
      ),
    );
  }
}
