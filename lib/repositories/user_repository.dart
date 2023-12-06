import 'package:quanlysinhvien/model/user.dart';
import 'package:quanlysinhvien/services/api_service.dart';

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
}
