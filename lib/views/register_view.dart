
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/utitilities/show_error_dialog.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
   late final TextEditingController _email;
  late final TextEditingController _password;

  @override
void initState() {
  super.initState();
  _email=TextEditingController();
  _password=TextEditingController();
}

@override
  void dispose() {
   _email.dispose();
   _password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(title: const Text('Register')),
     body: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter your email here',
                ),
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter your password here',
                  
                ),
                controller: _password,
                enableSuggestions: false,
                autocorrect: false,
                obscureText: true,
              ),
              TextButton(
                onPressed: () async {
                   
                  final email=_email.text;
                  final password=_password.text;
                  try{
                     await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
               final user= FirebaseAuth.instance.currentUser; //get your user
               await user?.sendEmailVerification();
                Navigator.of(context).pushNamed(verifyEmailRoute);
                }
                 on FirebaseAuthException catch(e) {
                  if(e.code == 'weak-password') {
                   // devtools.log('Weak password');
                   await showErrorDialog(context, "Weak-Password");
                  } else if(e.code == 'email-already-in-use'){
                   await showErrorDialog(context, "email-already-in-use");}
                   else if(e.code == 'invalid-email'){
                  await showErrorDialog(context, "This is an invalid email");}
                  else {
                    await showErrorDialog(context, 'Error ${e.code}',);
                  }
 }catch (e) {
  await showErrorDialog(context, e.toString(),);
 }
                 
                }, 
                child: const Text('Register')),
                TextButton(onPressed: (){
      Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
                },child: 
                const Text('Already registered? Login Here'),)
            ],
          ),
   );
}

}