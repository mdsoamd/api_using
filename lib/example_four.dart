import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;





class ExampleFoue extends StatefulWidget {
  const ExampleFoue({Key? key}) : super(key: key);

  @override
  State<ExampleFoue> createState() => _ExampleFoueState();
}

class _ExampleFoueState extends State<ExampleFoue> {
 


  var data;

  Future<void> getUserApi() async {      // <-- WithOut Model Create Show data

    final resposne = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (resposne.statusCode == 200) {
          data = jsonDecode(resposne.body.toString());
    } else {
     
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("API Using")),
      body: Column(children: [
        Expanded(
            child: FutureBuilder(
                future: getUserApi(),
                builder: (context, snapshot) {
                   if(snapshot.connectionState == ConnectionState.waiting){
                          return Center(child: Text("Loading"));
                   }else{
                      return ListView.builder(
                        itemCount:data.length,
                        itemBuilder:(context, index) {
                          return Card(
                            color: Colors.pink[200],
                            child: Column(
                              children: [
                                ReusbaleRow(name:'Name', value: data[index]['name'].toString()),
                                ReusbaleRow(name:'Username', value: data[index]['username'].toString()),
                                ReusbaleRow(name:'address', value: data[index]['address']['street'].toString()),
                                ReusbaleRow(name:'Lat', value: data[index]['address']['geo']['lat'].toString()),
                                ReusbaleRow(name:'Lan', value: data[index]['address']['geo']['lng'].toString()),
                              ],
                            ),
                          );
                      },);
                   }
                   
                }
              )
            )


      ]),
    );
  }
}









class ReusbaleRow extends StatelessWidget {                          // <-- Component
  String name, value;
  ReusbaleRow({Key? key, required this.name, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Text(value),
        ],
      ),
    );
  }
}
