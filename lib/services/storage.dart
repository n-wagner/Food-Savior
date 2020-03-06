import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:food_savior/services/database.dart';

class StorageService {

  final StorageReference storageRef = FirebaseStorage.instance.ref();

  Future uploadFile (String filePath) async {
    final String fileName = Uuid().v4();

    final sRef = storageRef.child(fileName);

    final StorageUploadTask uploadTask = sRef.putFile(File(filePath));

    final StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
    final String url = await downloadUrl.ref.getDownloadURL();
    print('URL Is $url');
  }
}