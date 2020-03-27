import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_savior/services/storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelect extends StatefulWidget {
  @override
  _ImageSelectState createState() => _ImageSelectState();
}

class _ImageSelectState extends State<ImageSelect> {
  File _image;    
  String _uploadedFileURL;
  StorageService _stor = StorageService();

  Future chooseFile() async {    
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {    
      setState(() {    
        _image = image;    
      });    
    });    
  }  

//   Future uploadFile() async {    
//    StorageReference storageReference = FirebaseStorage.instance    
//        .ref()    
//        .child('chats/${Path.basename(_image.path)}}');    
//    StorageUploadTask uploadTask = storageReference.putFile(_image);    
//    await uploadTask.onComplete;    
//    print('File Uploaded');    
//    storageReference.getDownloadURL().then((fileURL) {    
//      setState(() {    
//        _uploadedFileURL = fileURL;    
//      });    
//    });    
//  }

  @override    
  Widget build(BuildContext context) {    
   return Scaffold(    
     appBar: AppBar(    
       title: Text('Firestore File Upload'),    
     ),    
     body: Center(    
       child: Column(    
         children: <Widget>[    
           Text('Selected Image'),    
           _image != null    
               ? Image.asset(    
                   _image.path,    
                   height: 150,    
                 )    
               : Container(height: 150),    
           _image == null    
               ? RaisedButton(    
                   child: Text('Choose File'),    
                   onPressed: chooseFile,    
                   color: Colors.cyan,    
                 )    
               : Container(),    
           _image != null    
               ? RaisedButton(    
                   child: Text('Upload File'),    
                   onPressed: () async {
                     await _stor.uploadFoodItemImage(_image.path);
                     Navigator.pop(context);
                   },
                   color: Colors.cyan,    
                 )    
               : Container(),    
           _image != null    
               ? RaisedButton(    
                   child: Text('Clear Selection'),    
                   onPressed: () {}, // clearSelection,    
                 )    
               : Container(),    
           Text('Uploaded Image'),    
           _uploadedFileURL != null    
               ? Image.network(    
                   _uploadedFileURL,    
                   height: 150,    
                 )    
               : Container(),    
         ],    
       ),    
     ),    
   );
  }
}