import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;


class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {

  File? image;
  final picker = ImagePicker();
  bool showSpinner = false;
  
  Future getImage()async{
    final images = await picker.pickImage(source: ImageSource.camera,imageQuality: 80);

    if(images!= null){
      image = File(images.path);
      setState(() {
        
      });
    }else{
       print("No Image selete");
    }
  }


  Future<void> uploadImage()async{
    setState(() {
      showSpinner = true ;
    });

    var stream  = new http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();

    var uri = Uri.parse('https://fakestoreapi.com/products');

    var request = new http.MultipartRequest('POST', uri);

    request.fields['title'] = "Static title" ;

    var multiport = new http.MultipartFile(
        'image',
        stream,
        length);

    request.files.add(multiport);

    var response = await request.send() ;

    print(response.stream.toString());
    if(response.statusCode == 200){
      setState(() {
        showSpinner = false ;
      });
      print('image uploaded');
    }else {
      print('failed');
      setState(() {
        showSpinner = false ;
      });

    }

  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar:AppBar(
          title: Text("Image Upload"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                getImage();
              },
              child: Container(
                child: image == null ? Center(child: Text('Pick Image'),)
              :
              Container(
                child: Center(
                  child: Image.file(
                    File(image!.path).absolute,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ),
            ),
            SizedBox(height: 150,),
            GestureDetector(
              onTap: (){
                uploadImage();
              },
              child: Container(
                height: 50,
                width: 200,
                color: Colors.green,
                child: Center(child: Text('Upload')),
              ),
            )
          ],
        ),
      ),
    );
  }
}