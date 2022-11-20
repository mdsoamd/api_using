// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:api_using/Models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleThree extends StatefulWidget {
  const ExampleThree({Key? key}) : super(key: key);

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  List<UserModel> userlist = [];

  Future<List<UserModel>> getUserApi() async {
    final resposne = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    var data = jsonDecode(resposne.body.toString());

    if (resposne.statusCode == 200) {
      for (Map i in data) {
        userlist.add(UserModel.fromJson(i));
      }
      return userlist;
    } else {
      return userlist;
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
                builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      itemCount: userlist.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ReusbaleRow(
                                    name: "Name",
                                    value:
                                        snapshot.data![index].name.toString()),
                                ReusbaleRow(
                                    name: "UserName",
                                    value: snapshot.data![index].username
                                        .toString()),
                                ReusbaleRow(
                                    name: "Email",
                                    value:
                                        snapshot.data![index].email.toString()),
                                ReusbaleRow(
                                    name: "address",
                                    value: snapshot.data![index].address!.city
                                            .toString() +
                                        snapshot.data![index].address!.geo!.lat
                                            .toString()),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                }))
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
