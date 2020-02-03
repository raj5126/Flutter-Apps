import 'package:firebase_appdemo/models/details.dart';
import 'package:firebase_appdemo/screens/home/info.dart';
import 'package:firebase_appdemo/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_appdemo/service/database.dart';
import 'package:provider/provider.dart';


class  Home extends StatelessWidget {

  final AuthService _auth = AuthService(); 

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Details>>.value(
        value: DatabaseService().data,
        child: Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          title : Text("Home Screen"), 
          backgroundColor: Colors.black,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon:Icon(Icons.person),
              label: Text("Logout"),
              color : Colors.red,
              onPressed: () async{
                await _auth.signOut();
              }, 
             )
          ],
        ),
        body:Info(),
      ),
    );
  }
}