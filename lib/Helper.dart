import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_project/HomeScreen.dart';
import 'package:demo_project/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'adminPanel.dart';

class AuthService{
  final auth=FirebaseAuth.instance;
  final firestore=FirebaseFirestore.instance;
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController Adminemail=TextEditingController();
  TextEditingController Adminpassword=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController address=TextEditingController();
  TextEditingController order=TextEditingController();
  TextEditingController amount=TextEditingController();
  TextEditingController number=TextEditingController();


  void loginUser(context) async{
    try{
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Center(
            child: CircularProgressIndicator(),
          )

        );
      });
await auth.signInWithEmailAndPassword(email: email.text, password: password.text).then((value){
  print('user is logged in');
  // Navigator.push(context, MaterialPageRoute(builder: (c)=>HomeScreen()));
  // Navigator.pop(context);
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
});
    }catch(e){
      Navigator.pop(context);
      showDialog(context: context, builder: (context){
      return AlertDialog(
          title: Text(
            "Error Message"
          ),
        content:Text(e.toString()) ,

      );
    });}
  }
  void AdminloginUser(context) async{

      showDialog(context: context, builder: (context){
        return AlertDialog(
            title: Center(
              child: CircularProgressIndicator(),
            )

        );
      });
      await FirebaseFirestore.instance.collection("admin").doc("adminLogin").snapshots().forEach((element) {
if(element.data()?["adminEmail"]==Adminemail.text && element.data()?["adminPassword"]==Adminpassword.text){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AdminPanel()), (route) => false);
}

      }).catchError((e){
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text(
                "Error Message"
            ),
            content:Text(e.toString()) ,

          );
        });
      });

  }
  void RegisterUser(context) async{
    try{
      showDialog(context: context, builder: (context){
        return AlertDialog(
            title: Center(
              child: CircularProgressIndicator(),
            )

        );
      });
await auth.createUserWithEmailAndPassword(email: email.text, password: password.text).then((value){
  print('user is registered');
  firestore.collection("user").add({
    "email":email.text,
    "password":password.text,
    "name":name.text,
    "uid":auth.currentUser!.uid
  });
  Navigator.push(context, MaterialPageRoute(builder: (c)=>HomeScreen()));
  // Navigator.pop(context);
});
    }catch(e){
      Navigator.pop(context);
      showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text(
            "Error Message"
        ),
        content:Text(e.toString()) ,

      );
    });}
  }
  void SaveUserData(context) async{
    try{
      showDialog(context: context, builder: (context){
        return AlertDialog(
            title: Center(
              child: CircularProgressIndicator(),
            )

        );
      });
      await firestore.collection("Orders").add({
          "name":name.text,
          "address":address.text,
          "order":order.text,
      "amount":amount.text,
      "number":number.text,

        // Navigator.push(context, MaterialPageRoute(builder: (c)=>HomeScreen()));
        // Navigator.pop(context);
      });
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c)=>HomeScreen()), (route) => false);
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text(
              "Successfully saved your data"
          ),


        );
      });
    }catch(e){
      Navigator.pop(context);
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text(
              "Error Message"
          ),
          content:Text(e.toString()) ,

        );
      });}
  }
  //delete
  Future<void> deleteData(String docId){
    return FirebaseFirestore.instance.collection("Orders").doc(docId).delete();
  }
  void logout(context) async{
    await auth.signOut();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c)=> Login()), (route) => false);
}
}