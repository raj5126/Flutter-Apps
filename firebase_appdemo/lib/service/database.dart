import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_appdemo/models/details.dart';


class DatabaseService{

  final String uid;
  DatabaseService({this.uid});
  final CollectionReference collections = Firestore.instance.collection('demo');

  Future updateUserData(String name,String username) async{
    return await collections.document(uid).setData({
        'name': name,
        'username': username 
    });
  }

 List<Details> _detaillistfromsnapshot(QuerySnapshot querySnapshot){
   return querySnapshot.documents.map((doc){
          return Details(
            name:doc.data['name']??'',
            username: doc.data['username']??''    
          );
   }).toList();
 }
  
  Stream <List<Details>> get data{
    return collections.snapshots().map(_detaillistfromsnapshot);
  }

}