import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:quanly_sinhvien_2/model/user.dart';
import 'package:quanly_sinhvien_2/services/api_service.dart';

import 'package:image/image.dart' as img;

class UserRepository {
  Future<User> getUserInfo() async {
    User user = User();
    final response = await ApiService().getUserInfo();
    if (response != null) {
      var json = response.data['data'];
      user = User.fromJson(json);
    }
    return user;
  }

  Future<bool> updateProfile() async {
    bool kq = false;
    var response = await ApiService().updateProfile();
    if (response != null) {
      kq = true;
    }
    return kq;
  }

  Future<void> uploadAvatar(XFile image) async {
    ApiService api = ApiService();

    if (image != null) {
      final File imageFile = File(image.path);
      if (imageFile.existsSync()) {
        final img.Image originalImage =
            img.decodeImage(imageFile.readAsBytesSync())!;

        final img.Image resizedImage =
            img.copyResize(originalImage, width: 300);
        final File resizedFile =
            File(imageFile.path.replaceAll('.jpg', '_resized.jpg'));
        resizedFile.writeAsBytesSync(img.encodeJpg(resizedImage));
        await api.uploadAvatarToServer(resizedFile);
      }
    }
  }
}
