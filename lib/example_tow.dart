// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  List<Photos> photoslist = [];

  Future<List<Photos>> getPhotos() async {
    final resposne = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    var data = jsonDecode(resposne.body.toString());

    if (resposne.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(
            albumId: i['albumId'],
            id: i['id'],
            title: i['title'],
            url: i['url'],
            thumbnailUrl: i['thumbnailUrl']);
        photoslist.add(photos);
      }
      return photoslist;
    } else {
      return photoslist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("API Using")),
      body: Column(children: [
        Expanded(
          child: FutureBuilder(
          future: getPhotos(),
          builder: (context, AsyncSnapshot<List<Photos>> snapshot) {

            return ListView.builder(
              itemCount: photoslist.length,
              itemBuilder: (context, index) {

                return ListTile(

                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(snapshot.data![index].url.toString()),
                  ),

                  title: Text(snapshot.data![index].title.toString()),
                  subtitle: Text(snapshot.data![index].id.toString()),
                );


              },
            );
          },
        ))
      ]),
    );
  }
}




class Photos {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  Photos({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  
}
