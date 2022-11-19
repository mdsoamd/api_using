import 'dart:convert';

import 'package:api_using/Models/PostModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  List<PostsModel> postList = [];
  
  Future<List<PostsModel>> getPostApi() async {
      final resposne = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      var data = jsonDecode(resposne.body.toString());
     if(resposne.statusCode == 200){
        // postList.clear();
        for(Map i in data){
            postList.add(PostsModel.fromJson(i));
        }
        return postList;
     }else{
      return postList;
     }
      
  }
  
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Using"),
      ),

      body: Column(
        children: [
           Expanded(
             child: FutureBuilder(
              initialData: getPostApi(),
              builder:(context, snapshot) {
               if(!snapshot.hasData){
                return Center(child: Text("Loading"));
               }else{
                return ListView.builder(
                  itemCount: postList.length,
                  itemBuilder:(context, index) {
                    return Card(child:
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        const  Text('Title',style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.bold),),
                          Text(postList[index].title.toString()),
                          
                         const SizedBox(
                            height: 5,
                          ),
                          Text('Description',style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.bold),),
                        const  SizedBox(
                            height: 5,
                          ),
                          Text('Description\n'+postList[index].body.toString()),
                         
                        ],
                    ),
                     ));
                },);
                
                
               }
             },),
           )
      ]),
      
    );
  }
}