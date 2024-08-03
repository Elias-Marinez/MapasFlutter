
import 'package:flutter/material.dart';
import 'package:tarea9y10app/pages/mappage.dart';

// Elias Mariñez, 2022-1073
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  void _navigateToMap(){
    final name = _nameController.text;
    final lastName = _lastNameController.text;
    final latitude = double.tryParse(_latitudeController.text);
    final longitude = double.tryParse(_longitudeController.text);
    
    if(latitude != null && longitude != null){
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => MapPage(
            name: name, 
            lastName: lastName, 
            latitude: latitude, 
            longitude: longitude
          ),
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarea 9 y 10'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Apellido'),
            ),
            TextField(
              controller: _latitudeController,
              decoration: const InputDecoration(labelText: 'Latitud'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _longitudeController,
              decoration: const InputDecoration(labelText: 'Longitud'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: _navigateToMap, 
              child: const Text('Siguiente'),
            )
          ],
        ),
      ),
    );
  }
}
