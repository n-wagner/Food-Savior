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

  Future<String> uploadImage (File upload, [String folder]) async {
    while (true) {
      String fileName = Uuid().v4();
      print('path ${p.current}');
      StorageReference sRef = storageRef.child(folder + fileName);
      String result = await sRef.getDownloadURL().then(
        (url) {
          print('filename already exists "$url" "$fileName"');
          return '';
        }, 
        onError: (error) async {
          // print('file does not exist - path = ${upload.path}');
          
          // File f = File(filePath);
          print('file "$upload" path "${upload.path}"');
          StorageUploadTask uploadTask = sRef.putFile(upload);
          StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
          print('File Uploaded');
          String url = await downloadUrl.ref.getDownloadURL();
          print('URL Is $url');
          return url;
        }
      );
      if (!(result != null && result.length == 0)) {
        print('file name in Storage Server $result');
        return result;
      }
    }
  }
}