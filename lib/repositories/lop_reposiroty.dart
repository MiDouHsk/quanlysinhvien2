import 'package:quanly_sinhvien_2/model/lop.dart';
import 'package:quanly_sinhvien_2/services/api_service.dart';

class LopRepository {
  Future<List<Lop>> getDsLop() async {
    List<Lop> list = [];
    list.add(Lop(ten: "--Chosse--"));
    final response = await ApiService().getDsLop();
    if (response != null) {
      var data = response.data['data'];
      for (var item in data) {
        var lop = Lop.fromJson(item);
        list.add(lop);
      }
    }
    return list;
  }
}
