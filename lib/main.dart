import 'package:demo_project/Helper.dart';
import 'package:demo_project/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
final auth=FirebaseAuth.instance;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home:auth.currentUser==null?Login():HomeScreen(),
  ));
}

class Login extends StatelessWidget {
AuthService authservice=AuthService();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/woodbackground.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
       body: Padding(
         padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text("Login Your account",style: TextStyle(
               fontWeight: FontWeight.bold,fontSize: 20,color: Colors.green
             ),),
             SizedBox(height: 15,),
             TextField(
               controller: authservice.email,
               decoration: InputDecoration(
                 labelText: AutofillHints.email,
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(10),
                 )
               ),
             ),
             SizedBox(height: 15,),
             TextField(
               controller: authservice.password,
               decoration: InputDecoration(
                   labelText: AutofillHints.password,
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(10),
                   )
               ),
             ),
             SizedBox(height: 15,),
             ElevatedButton(
                 style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 70)),
                 onPressed: () {
                   if(authservice.email!="" && authservice.password!=""){
                     authservice.loginUser(context);
                   }
                 }, child: Text('Login')),
             TextButton(onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder:(context)=>Register()));
             }, child: Text("Dont have an account ? Register")),
           Align(
             alignment: Alignment.centerRight,
             child: TextButton(onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder:(context)=>AdminLogin()));
             }, child: Text("Goto Admin Account")),
           )
           ],
         ),
       ),
      ),

    );
  }
}
class AdminLogin extends StatelessWidget {
  AuthService authservice=AuthService();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Login to admin account",style: TextStyle(
                fontWeight: FontWeight.bold,fontSize: 20,color: Colors.green
            ),),
            SizedBox(height: 15,),
            TextField(
              controller: authservice.Adminemail,
              decoration: InputDecoration(
                  labelText: AutofillHints.email,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
            ),
            SizedBox(height: 15,),
            TextField(
              controller: authservice.Adminpassword,
              decoration: InputDecoration(
                  labelText: AutofillHints.password,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
            ),
            SizedBox(height: 15,),
            ElevatedButton(
                style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 70)),
                onPressed: () {
                  if(authservice.Adminemail!="" && authservice.Adminpassword!=""){
                    authservice.AdminloginUser(context);
                  }
                }, child: Text('Login')),
            TextButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder:(context)=>Login()));
            }, child: Text("Not Admin"))
          ],
        ),
      ),
    );
  }
}
class Register extends StatelessWidget {
AuthService authService=AuthService();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Register Your account",style: TextStyle(
                fontWeight: FontWeight.bold,fontSize: 20,color: Colors.green
            ),),
            SizedBox(height: 15,),
            TextField(
              controller: authService.name,
              decoration: InputDecoration(
                  labelText: AutofillHints.name,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
            ),
            SizedBox(height: 15,),
            TextField(
              controller: authService.email,
              decoration: InputDecoration(
                  labelText: AutofillHints.email,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
            ),
            SizedBox(height: 15,),
            TextField(
              controller: authService.password,
              decoration: InputDecoration(
                  labelText: AutofillHints.password,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
            ),
            SizedBox(height: 15,),
            ElevatedButton(
                style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 70)),
                onPressed: () {
                  if(authService.email!="" && authService.password!=""){
                    authService.RegisterUser(context);
                  }
                }, child: Text('Register')),
            TextButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder:(context)=>Login()));
            }, child: Text("Already have an account ? Login"))
          ],
        ),
      ),
    );
  }
}


