import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static Future<XFile?> pickImageFromGallery() async {
    final picker = await ImagePicker().pickImage(source: ImageSource.gallery);
    return picker;
  }
}
