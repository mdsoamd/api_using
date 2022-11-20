import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  


  login(String email,password)async{      // <-- User Login Method Api use
      try {
        Response response = await post(
          Uri.parse('https://reqres.in/api/login'),
          body: {
            'email':email,
            'password':password
          }
        );

        if(response.statusCode == 200){
          var data = jsonDecode(response.body.toString());
           // print(data);
           print(data['token']);
           print("Login Successfully");

        }else{
          print("Failed");
        }
        
        
      } catch (e) {
        print(e.toString());
      }
      
  }
  
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login API '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration:InputDecoration(
                hintText: "Email"
              ),
            ),
           const SizedBox(
              height: 20,
            ),
            TextField(
              controller: passwordController,
              decoration:InputDecoration(
                hintText: "Create password"
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(onPressed: (){
              login(emailController.text.toString(),passwordController.text.toString());
            }, 
            child: const Text("Login"),
            style: TextButton.styleFrom(backgroundColor: Colors.pink[500]),
            )
          ],
        ),
      ),
    );
  }
}