import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/views/login_view.dart';
import 'package:flutter_application_1/views/register_view.dart';
import 'package:flutter_application_1/views/verify_email_view.dart';
import 'dart:developer' as devtools show log;

void main() {
  WidgetsFlutterBinding.ensureInitialized(); //intialising the firebase before everything
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 82, 0, 223)),
      useMaterial3: true,
    ),
    home: const HomePage(),
    routes: {
      loginRoute:(context)=>const LoginView(),
      registerRoute:(context)=>const RegisterView(),
      notesRoute:(context)=>const NotesView(),
      verifyEmailRoute:(context) => const VerifyEmailView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context,snapshot){
          switch (snapshot.connectionState){
            case ConnectionState.done:

  final user = FirebaseAuth.instance.currentUser;//shows the current logged in user  
  
   if (user != null){ // if user is logged in
if(user.emailVerified) //check if email is verified
{
devtools.log('Email is verified'); // if verified print this
}
else{
return const VerifyEmailView();//else verify email page

}
   }
    else{
return const LoginView(); //if user is null, go to loginview
    }           
        return const NotesView();    
            
        default:
        return const CircularProgressIndicator();
          }

        },       
      );
  }
}
enum MenuAction {logout}

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}


class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main UI'),
      actions: [
        PopupMenuButton<MenuAction>(onSelected:(value) async{
          switch (value){
            
            case MenuAction.logout:
            final shouldLogout = await showLogOutDialog(context);
            if (shouldLogout) {
             await FirebaseAuth.instance.signOut();
             Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (_) => false);
            }

          devtools.log(shouldLogout.toString()); // logging an item
          break;

          }
        },
          itemBuilder:(context){
            return [const PopupMenuItem<MenuAction>(value:MenuAction.logout, child:Text('Log Out'))];
            
          } )
      ],
      backgroundColor: Colors.blue,),
      body: const Text('Hello World'),
    );
  }
}

Future<bool>showLogOutDialog(BuildContext context){
  return showDialog<bool>(
    context: context, builder: (context){
    return AlertDialog(
      title: const Text('Sign Out'),
      content: const Text('Are you sure you want to sign out?'),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop(false);
        }, child: const Text('Cancel')),
        TextButton(onPressed: (){
          Navigator.of(context).pop(true);
        }, child: const Text('Log Out')),
      ],
    );
  }
  ).then((value) => value ?? false);  //may not return a value, if it doesn't, then false is returned
}