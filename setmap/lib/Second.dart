import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Edit extends StatefulWidget {
  @override
  Edit({Key key}) : super(key: key);
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _formkey = GlobalKey<FormState>();
  String dropdownValue=' ';
  String value;
  String error='';
  DateTime date;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Details'),
        backgroundColor: Colors.black,
        elevation: 10.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * .50,
        padding: EdgeInsets.symmetric(vertical:30.0,horizontal:50.0),
        child: Form(
          key:_formkey,
          child: Column(
            children:<Widget>[
              //SizedBox(height: 30.0),
              Text(
                error,
                style: TextStyle(
                  color:Colors.red,
                  fontSize: 20.0,
                ),  
              ),
              SizedBox(height: 20.0),
              // TextFormField(
              //   decoration: InputDecoration(
              //       hintText : 'Vehicle Type',
              //       fillColor: Colors.white,
              //       filled: true,
              //   ),
              //   )
              DropdownButton<String>(
                isExpanded: true,
                value: value,
                hint: new Text('Vehicle Type'),
                icon:Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                 ),
                underline: Container(
                  height:2,
                  color: Colors.black,
                  ),
                onChanged: (String newvalue){
                    setState(() {
                      value=newvalue;
                    }); 
                },
                items: <String>['CAR / JEEP','BUS / 2 AXLE','TRUCK / 3 AXLE','LCV'].map<DropdownMenuItem<String>>((String value){
                     return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                    hintText : 'Vehicle No.',
                    fillColor: Colors.white,
                ),
                style: TextStyle(
                  fontSize:20.0,                
                   ),
                ),
                SizedBox(height: 20),
                DateTimePickerFormField(
                    inputType: InputType.date,
                    format: DateFormat("yyyy-MM-dd"),
                    initialDate: DateTime(2019, 1, 1),
                    editable: true,
                    decoration: InputDecoration(
                    labelText: 'Date',
                    hasFloatingPlaceholder: false  
                  ),
                onChanged: (dt) {
                       setState(() => date = dt);
                        print('Selected date: $date');
                    },
                  style: TextStyle(fontSize: 20.0),
  ),
            ]
          ),
        ),
      ),  
    );
  }
}