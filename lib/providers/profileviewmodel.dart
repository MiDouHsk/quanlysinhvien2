import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quanly_sinhvien_2/model/profile.dart';

import '../model/user.dart';
import '../repositories/user_repository.dart';

class ProfileViewModel with ChangeNotifier {
  int status = 0; //
  int modified = 0;
  int updatedavatar = 0;
  void updatescreen() {
    notifyListeners();
  }

  void setUpdateavatar() {
    updatedavatar = 1;
    notifyListeners();
  }

  Future<void> uploadAvatar(XFile image) async {
    status = 1;
    notifyListeners();
    await UserRepository().uploadAvatar(image);
    var user = await UserRepository().getUserInfo();
    Profile().user = User.fromUser(user);
    updatedavatar = 0;
    status = 0;
    notifyListeners();
  }

  void displayspinner() {
    status = 1;
    notifyListeners();
  }

  void setModified() {
    if (modified == 0) {
      modified = 1;
      notifyListeners();
    }
  }

  void hidespinner() {
    status = 0;
    notifyListeners();
  }

  Future<void> updateProfile() async {
    status = 1;
    notifyListeners();
    await UserRepository().updateProfile();
    status = 0;
    modified = 0;
    notifyListeners();
  }
}
