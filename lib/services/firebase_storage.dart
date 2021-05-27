import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
class StorageRepo {
 
  uploadFile(File file, String uid) async {
    FirebaseStorage _storage = FirebaseStorage.instance;
    //_storage.bucket = "gs://cooking-master-5dc52.appspot.com";
    try {
      
      var fileExtension = path.extension(file.path);
      await _storage.ref().child('user/profile/$uid$fileExtension').delete();
      var storageRef = _storage.ref().child('user/profile/$uid$fileExtension');
      await storageRef.putFile(file);
      var imageUrl = await storageRef.getDownloadURL();
      return imageUrl.toString();
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }
}
