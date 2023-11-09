import 'dart:io';
import 'package:image_picker/image_picker.dart';

class VideoService {
  static Future getVideo({required ImageSource source}) async {
    XFile? pickedFile = await ImagePicker().pickVideo(
      source: source,
      preferredCameraDevice: CameraDevice.front,
    );
    if(pickedFile != null){
      return File(pickedFile.path);
    }
    else{
      return null;
    }
  }
}
