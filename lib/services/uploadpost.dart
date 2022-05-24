import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class UploadPost {
  static final UploadPost _singleton = UploadPost._();

  UploadPost._();

  factory UploadPost() => _singleton;

  static UploadPost get instance => _singleton;
  //PickedFile image;
  final _picker = ImagePicker();
  //XFile _imagePath;
  Future<String> pickImageCamera() async {
    var image = await _picker.pickImage(source: ImageSource.camera);
    return image.path;
  }

  Future pickImageGallery() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    return image.path;
  }

  Future uploadImageToFirebase(var _imagePath) async {
    //String fileName = basename(_imagePath.path);
    var downimgURL;
    firebase_storage.Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('posts/${randomAlphaNumeric(12)}');
    firebase_storage.UploadTask uploadTask =
        firebaseStorageRef.putFile(_imagePath);
    firebase_storage.TaskSnapshot taskSnapshot = await uploadTask
        .whenComplete(() => downimgURL = firebaseStorageRef.getDownloadURL());
    return downimgURL;
  }
}
