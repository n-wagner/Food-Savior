import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:googleapis/tasks/v1.dart';
//import 'package:googleapis/fusiontables/v2.dart';
//import 'package:googleapis/fusiontables/v1.dart';
//import 'package:googleapis/cloudtasks/v2.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
import 'package:food_savior/services/database.dart';

class StorageService {

  final StorageReference storageRef = FirebaseStorage.instance.ref();

  Future uploadFoodItemImage (String filePath) async {
    while (true) {
      String fileName = Uuid().v4();
      print('path ${p.current}');
      StorageReference sRef = storageRef.child('food-item-images/' + fileName);
      String result = await sRef.getDownloadURL().then(
        (url) {
          print('filename already exists "$url" "$fileName"');
          return '';
        }, 
        onError: (error) async {
          print('file does not exist - path = $filePath');
          
          File f = File(filePath);
          print('file $f');
          StorageUploadTask uploadTask = sRef.putFile(f);
          StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
          print('File Uploaded');
          String url = await downloadUrl.ref.getDownloadURL();
          print('URL Is $url');
          return url;
        }
      );
      if (!(result != null && result.length == 0)) {
        return result;
      }
    }
  }
}