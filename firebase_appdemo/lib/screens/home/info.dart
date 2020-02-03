import 'package:firebase_appdemo/models/details.dart';
import 'package:firebase_appdemo/screens/home/infotile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {

    final data = Provider.of<List<Details>>(context);
    // data.forEach((u){
    //   print(u.name);
    //   print(u.username);
    // });
    return ListView.builder (
      itemCount: data.length,
      itemBuilder: (context,index){
        return InfoTile(d : data[index]);
      },
    );
  }
}