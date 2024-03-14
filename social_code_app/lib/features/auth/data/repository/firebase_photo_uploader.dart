import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_code_app/features/auth/domain/repository/photo_loader_repository.dart';

class FirebaseStoragePhotoUpLoader extends IPhotoUpLoaderRepository {
  final picker = ImagePicker();
  final storage = FirebaseStorage.instance;
  @override
  Future<String?> uploadPhoto(String email) async {
    var pickedfile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      File imageFile = File(pickedfile.path);
      Reference storageReference = storage.ref().child(
          "user_profile_images/${DateTime.now().microsecondsSinceEpoch}");
      UploadTask task = storageReference.putFile(imageFile);
      TaskSnapshot snapshot = await task;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    }
    return null;
  }
}
