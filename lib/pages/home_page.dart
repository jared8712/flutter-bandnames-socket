import 'dart:ui';

import 'package:band_names/models/band.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  List<Band> bands = [
    Band(id: '1', name: 'Backstreet Boys', votes: 10),
    Band(id: '2', name: 'Buena Fe', votes: 8),
    Band(id: '3', name: 'Linkin Park', votes: 7),
    Band(id: '4', name: 'Metallica', votes: 5),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BandNames', style: TextStyle(color: Colors.black87),),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index){
          
          return _bandTile(bands[index]);
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand,
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id!),
      direction: DismissDirection.startToEnd,
      onDismissed: ( direction ){
        print(direction);
        print(band.id);
      },
      background: Container(
        padding: EdgeInsets.only(left: 10.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Borrar Banda', style: TextStyle(color: Colors.white),),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name!.substring(0,2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name!),
        trailing: Text('${band.votes}', style:  TextStyle( fontSize: 20),),
        onTap: (){
          print(band.name);
        },
      ),
    );
  }

  addNewBand(){

    final textController = new TextEditingController();

    return showDialog(
      context: context,
      builder: ( context ){

        return AlertDialog(
          title: Text('Add New Band Name'),
          content: TextField(
            controller: textController
          ),
          actions: [
            MaterialButton(
              onPressed: () => addBandName( textController.text ),
              elevation: 5,
              textColor: Colors.blue,
              child: Text('Agregar'),
            )
          ],
        );

      }
    );

  }

  addBandName( String name ){

    if( name.length > 1 ){

      this.bands.add(new Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});

    }

    Navigator.pop(context);

  }

}