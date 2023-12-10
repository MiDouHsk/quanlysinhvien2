import 'package:quanly_sinhvien_2/model/student.dart';
import 'package:quanly_sinhvien_2/services/api_service.dart';

class StudentRepository {
  final ApiService api = ApiService();
  Future<bool> dangkylop() async {
    bool kq = false;
    var response = await api.dangkiLop();
    if (response != null) {
      kq = true;
    }
    return kq;
  }

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
