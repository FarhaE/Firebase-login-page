
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/enums/menu_action.dart';
import 'package:flutter_application_1/services/auth/auth_service.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}
class _NotesViewState extends State<NotesView> {
  get devtools => null;

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
             AuthService.firebase().logOut();
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