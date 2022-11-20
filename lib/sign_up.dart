import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  

  login(String email,password)async{      // <-- User Sign Up Method API Use
      try {
        Response response = await post(
          Uri.parse('https://reqres.in/api/register'),
          body: {
            'email':email,
            'password':password
          }
        );

        if(response.statusCode == 200){
          var data = jsonDecode(response.body.toString());
          //print(data);
          print(data['token']);
           print("Account Created Successfully");
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
        title: Text('Sign Up API'),
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
            child: const Text("Sing Up"),
            style: TextButton.styleFrom(backgroundColor: Colors.pink[500]),
            )
          ],
        ),
      ),
    );
  }
}