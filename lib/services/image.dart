import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'storage.dart';


class ImageService {

  final String _foodItemImagesFolder = 'food-item-images/';
  File _image;
  final StorageService _stor = StorageService();

  Future<File> _initialize () async {
    ByteData byteImage = await rootBundle.load('assets/images/noImage.jpg');
    String name = '${(await getTemporaryDirectory()).path}/noImage.jpg';
    print('name $name');
    _image = File(name);
    await _image.writeAsBytes(byteImage.buffer.asUint8List(byteImage.offsetInBytes, byteImage.lengthInBytes));
    // _image = file;
    print("image is set $_image");
    print("image path ${_image.path}");
    return _image;
    // print('imageName = $imageName');    //for debug
    // return imageName;
  }

  ImageService([File imageFile]) {
    if (imageFile == null) {
      print("initializing");
      _initialize();
      // .then((File initializedImage) {
      //   image = initializedImage;
      // },
      // onError: () {
      //   image = null;
      //   print("Failed to initialize image");
      // });
    } else {
      print("image file is non null $imageFile");
      print("Image path ${imageFile.path}");
      _image = imageFile;
    }
  }

  Image getImageForDisplay () {
    if (_image == null) {
      return Image.asset('assets/images/noImage.jpg', height: 150);
    } else {
      print("image $_image path ${_image.path}");
      return Image.file(_image, height: 150);
    }
  }

  Future<String> uploadFoodItemImage () async {
    // String result;
    return await _stor.uploadImage(_image, _foodItemImagesFolder);
    //  .then((String imageUrl) {
    //   print("ImageURL in Image Service $imageUrl");
    //   result = imageUrl;
    // });
    // print("result being returned in Image Service $result");
    // return result;
  }

  Future<File> getImageFromGallery () async {
    return await ImagePicker.pickImage(source: ImageSource.gallery).then((File imagePicked) {
      if (imagePicked != null) {
        _image = imagePicked;
      } else {
        print("Failed to pick an image from the gallery (null)");
      }
      return imagePicked;
    }, onError: (error) {
      print("Failed to pick an image from the gallery (Future)");
    });
  }
}