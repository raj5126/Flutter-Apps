import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Second.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home : Myhome(),
    );
  }
}

class Myhome extends StatefulWidget {
  @override
  _MyhomeState createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {

  GoogleMapController mapController;
  final Map<String, Marker> _markers = {};
  final Set<Polyline> _polylines ={};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String _googleAPiKey = "AIzaSyCiDJB5FFFCwTBl4Nk8dxvK1-3ajF9IMRI";
  GoogleMapPolyline googleMapPolyline = new GoogleMapPolyline(apiKey: 'AIzaSyCiDJB5FFFCwTBl4Nk8dxvK1-3ajF9IMRI');
  String search;
  String source,dest;
  double _sourceA,_sourceB;
  double _destA,_destB;
  var tolls=[];

 BitmapDescriptor tollicon; 
 BitmapDescriptor destination;
 BitmapDescriptor src; 
 

  
  @override
  Widget build(BuildContext context) {
    createMarker(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 160.0, 0.0, 0.0),
              child: GoogleMap(
                compassEnabled: true,
                onMapCreated: _onMapCreated,
                initialCameraPosition :CameraPosition(
                    target: LatLng(20.5937, 78.9629),
                    zoom: 5.0,
                  ),
                myLocationEnabled: true,
                tiltGesturesEnabled: true,
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true,
                mapType: MapType.normal,
                markers: _markers.values.toSet(),
                polylines: _polylines,
              ),
            ),
            Positioned(
              top: 40.0,
              right :15.0,
              left: 15.0,
              child: Container(
                height: 45.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  border: Border.all(color: Colors.blue, width:2.00),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Source',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0,top: 10.0),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.my_location),
                      onPressed: searchandnavigatesource,
                      iconSize: 25.0,
                    ),
                  ),
                  onChanged: (val){
                    setState(() {
                      search = val;
                      source = search;
                    });
                  },
                ),
              ),
            ), 
            SizedBox(height :20.0),
            Positioned(
              top: 100.0,
              right :15.0,
              left: 15.0,
              child: Container(
                height: 45.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  border: Border.all(color: Colors.blue, width:2.00),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Destination',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0,top: 10.0),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: searchandnavigatedest,
                      iconSize: 30.0,
                    ),
                  ),
                  onChanged: (val){
                    setState(() {
                      search = val;
                      dest = search;
                    });
                  },
                ),
              ),
            ), 
      ],  
    ),
        floatingActionButton: FloatingActionButton(
        onPressed: locateToll,
        tooltip: 'Get Path',
        child: Icon(Icons.location_on),
      ),     
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(70.0, 5.0, 70.0, 5.0),
            child: ButtonTheme(
              height: 40.0,
              minWidth: 20,
              child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                      color: Colors.black ,
                      child: Text(
                        'Pay Toll',
                         style :TextStyle(
                           color: Colors.white,
                           fontSize: 20.0,
                         ),
                      ), 
                      onPressed: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context) => Edit()));
                      },
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      
            ),
        ),
          ), 
    )
    );
  }

 void _onMapCreated(GoogleMapController controller){
    setState(() {
      mapController = controller;
    });
  }

tollmark(toll,length){
  for(int j=0;j<length;++j)
  {
   setState(() {
      final marker = Marker(
          markerId: MarkerId(j.toString()),
          position: LatLng(toll[j].latitude,toll[j].longitude),
          infoWindow: InfoWindow(title: 'Toll '),
          icon:tollicon
      );
      _markers[j.toString()] = marker;
   });
  }      
}


  searchandnavigatesource(){
    Geolocator().placemarkFromAddress(search).then ((result){
      mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target : LatLng(result[0].position.latitude,result[0].position.longitude),
        zoom :10.0
      ),
      
      ));
      setState(() {
        //_markers.clear();
        final marker = Marker(
            markerId: MarkerId("source_loc"),
            position: LatLng(result[0].position.latitude,result[0].position.longitude),
            infoWindow: InfoWindow(title: 'Start Location'),
            icon: src,
      );
      _markers["Source"] = marker;
    });
    _sourceA = result[0].position.latitude;
    _sourceB = result[0].position.longitude;
    print(_sourceA);
    print(_sourceB);
});
}

searchandnavigatedest(){
  Geolocator().placemarkFromAddress(search).then ((result){
    mapController.animateCamera(CameraUpdate.newCameraPosition(
     CameraPosition(
      target : LatLng(result[0].position.latitude,result[0].position.longitude),
      zoom :10.0
     ),
     
    ));
     setState(() {
      //_markers.clear();
      final marker = Marker(
          markerId: MarkerId("dest_loc"),
          position: LatLng(result[0].position.latitude,result[0].position.longitude),
          infoWindow: InfoWindow(title: 'End Location'),
          icon: destination
      );
      _markers["dest"] = marker;
    });
    _destA = result[0].position.latitude;
    _destB = result[0].position.longitude;
    print(_destA);
    print(_destB);
    });
}

locateToll() {
    tolls=[];
    Firestore.instance.collection('TollBooth').where('source', isEqualTo : source.toLowerCase() ).where('destination', isEqualTo : dest.toLowerCase() ).getDocuments().then((docs){
      if(docs.documents.isNotEmpty)
      {
        for (int i=0;i<docs.documents.length;++i)
        {
          for (var doc in docs.documents[i].data['tolls'])
          {
            tolls.add(doc);
          }
          tollmark(tolls,tolls.length);
        }
      }
    });
  } 


createMarker(context)
{
  if (tollicon==null){
  ImageConfiguration configuration = createLocalImageConfiguration(context);
  BitmapDescriptor.fromAssetImage(configuration, 'assets/tollbooth.png').then((icon){
      setState(() {
        tollicon=icon;
      });
  });
  }
  if (destination==null){
  ImageConfiguration configuration = createLocalImageConfiguration(context);
  BitmapDescriptor.fromAssetImage(configuration, 'assets/dest.png').then((icon){
      setState(() {
        destination=icon;
      });
  });
  if (src==null){
  ImageConfiguration configuration = createLocalImageConfiguration(context);
  BitmapDescriptor.fromAssetImage(configuration, 'assets/source.png').then((icon){
      setState(() {
       src=icon;
      });
  });
  }
}




addPolyLine()
  {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        //_polylines[id] = polyline;
        color: Colors.blue, points: polylineCoordinates
    );
    _polylines.add(polyline);
    setState(() {
    });
    // _polylines.add(Polyline(
    //       polylineId: PolylineId('route1'),
    //       visible: true,
    //       points: polylineCoordinates,
    //       width: 4,
    //       color: Colors.blue,
    //       startCap: Cap.roundCap,
    //       endCap: Cap.buttCap));
    
  }

  getPolyline() async
  {
      List<PointLatLng> result = await polylinePoints.getRouteBetweenCoordinates(_googleAPiKey,6.5212402,3.3679965,6.849660,3.648190);
      if(result.isNotEmpty){
      result.forEach((PointLatLng point){
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    //   var permissions =
    //     await Permission.getPermissionsStatus([PermissionName.Location]);
    // if (permissions[0].permissionStatus == PermissionStatus.notAgain) {
    //   var askpermissions =
    //       await Permission.requestPermissions([PermissionName.Location]);
    // } else {
          // polylineCoordinates = await googleMapPolyline.getCoordinatesWithLocation(
          // origin: LatLng(_sourceA, _sourceB),
          // destination: LatLng(_destA,_destB),
          // mode: RouteMode.driving);
    // }
    print(polylineCoordinates); 
    addPolyLine();
  }
 }
}

}



