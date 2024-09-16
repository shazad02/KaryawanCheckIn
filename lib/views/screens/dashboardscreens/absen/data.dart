import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class StoreData {
  Future<String> uploadImage(
      String childName, Uint8List file, String fileName) async {
    Reference ref = _storage
        .ref()
        .child(childName)
        .child(fileName); // Use fileName as the file name
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveData({
    required Uint8List file,
    required String userId,
  }) async {
    String resp = "error";
    try {
      String fileName = DateTime.now()
          .millisecondsSinceEpoch
          .toString(); // Generate unique file name based on time
      String imageUrl = await uploadImage('buktiImage', file, fileName);
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('buktii').add({
          'imageLink': imageUrl,
          'userId': userId,
        });
        resp = 'Berhasil Upload Bukti';

        // Clear the image cache after uploading
        file = Uint8List(0);
      } else {
        resp = 'User tidak ditemukan.';
      }
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}
