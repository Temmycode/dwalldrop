import 'dart:io';

import 'package:image_picker/image_picker.dart';

extension XfileToFile on XFile? {
  File toFile() => File(this!.path);
}
