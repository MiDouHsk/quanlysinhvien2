import 'package:quanlysinhvien/model/profile.dart';
import 'package:quanlysinhvien/model/student.dart';
import 'package:quanlysinhvien/services/api_service.dart';

class StudentRepository {
  final ApiService api = ApiService();
  Future<Student> getStudentInfo() async {
    Student student = Student();
    var response = await api.getStudentInfo();
    if (response != null) {
      var data = response.data;
      student = Student.fromJson(data);
      //Profile().student = Student.fromStudent(student);
    }

    return student;
  }
}
