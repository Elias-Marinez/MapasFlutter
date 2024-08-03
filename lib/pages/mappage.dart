import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Elias Mariñez, 2022-1073
class MapPage extends StatefulWidget{
  final String name;
  final String lastName;
  final double latitude;
  final double longitude;

  const MapPage({
    super.key, 
    required this.name, 
    required this.lastName, 
    required this.latitude, 
    required this.longitude
  });

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage>{
  String _address = '';

  @override
  void initState(){
    super.initState();
    _getAddress();
  }
  Future<void> _getAddress() async{
    try{
      List<Placemark> placemarks = await placemarkFromCoordinates(widget.latitude, widget.longitude);
      if(placemarks.isNotEmpty){
        final Placemark placemark = placemarks.first;
        setState(() {
          _address = '${placemark.country}';
        });
      }
    }catch(e){
        setState(() {
          _address = 'No se pudo obtener la direccion';
        });
    }
  } 

  @override
  Widget build(BuildContext context) {

    final marker = Marker(
      markerId: const MarkerId('Location'),
      position: LatLng(widget.latitude, widget.longitude),
      infoWindow: InfoWindow(
        title: '${widget.name} ${widget.lastName}',
        snippet: _address
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Mapa'),),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.latitude, widget.longitude),
          zoom: 12,
        ),
        markers: {marker},
        onMapCreated: (GoogleMapController controller) {},
        onTap: (LatLng latLng){
          showDialog(
            context: context, 
            builder: (context) => AlertDialog(
              title: Text('${widget.name} ${widget.lastName}'),
              content: Text('Ubicacion: $_address'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop, 
                  child: const Text('OK'),
                ), 
              ],
            )
          );
        },
      ),
    );
  }
}