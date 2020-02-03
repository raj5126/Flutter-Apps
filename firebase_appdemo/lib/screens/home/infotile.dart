import 'package:firebase_appdemo/models/details.dart';
import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  final Details d;
  InfoTile({this.d}); 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Card(
         margin: EdgeInsets.fromLTRB(10.0,4.0,10.0,0.0),
         child: ListTile(
           leading: Icon(
             Icons.person,
             color: Colors.black,
             ),
           title: Text(d.name),
           subtitle: Text(d.username),
         ),
      ),
    );
  }
}