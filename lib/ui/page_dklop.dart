import 'package:flutter/material.dart';
import 'package:quanly_sinhvien_2/model/lop.dart';
import 'package:quanly_sinhvien_2/model/profile.dart';
import 'package:quanly_sinhvien_2/repositories/lop_reposiroty.dart';
import 'package:quanly_sinhvien_2/repositories/student_repository.dart';
import 'package:quanly_sinhvien_2/repositories/user_repository.dart';
import 'package:quanly_sinhvien_2/ui/AppConstant.dart';
import 'package:quanly_sinhvien_2/ui/customcontroller.dart';
import 'package:quanly_sinhvien_2/ui/page_main.dart';
import 'package:quanly_sinhvien_2/ui/subpageprofile.dart';
import 'page_login.dart';

class pageDangKyLop extends StatefulWidget {
  const pageDangKyLop({super.key});

  @override
  State<pageDangKyLop> createState() => _pageDangKyLopState();
}

class _pageDangKyLopState extends State<pageDangKyLop> {
  List<Lop>? listlop = [];
  Profile profile = Profile();
  String mssv = '';
  String ten = '';
  int idlop = 0;
  String tenlop = '';

  @override
  void initState() {
    // TODO: implement initState
    mssv = profile.student.mssv;
    ten = profile.user.first_name;
    idlop = profile.student.idlop;
    tenlop = profile.student.tenlop;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () =>
              Navigator.of(context).popAndPushNamed(PageMain.routename),
          child: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Them thong tin co ban",
                style: AppConstant.font_roboto,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'bạn không thể quay trở lại trang sau khi rời đi. vì vậy hãy kiểm tra thật kĩ nhé!',
                style: AppConstant.textError,
              ),
              SizedBox(
                height: 20,
              ),
              CustomInputTextFormField(
                title: "Ten: ",
                value: ten,
                width: size.width,
                callback: (output) {
                  ten = output;
                },
              ),
              CustomInputTextFormField(
                title: "Mssv: ",
                value: mssv,
                width: size.width,
                callback: (output) {
                  mssv = output;
                },
              ),
              listlop!.isEmpty
                  ? FutureBuilder(
                      future: LopRepository().getDsLop(),
                      builder: (context, AsyncSnapshot<List<Lop>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasData) {
                          listlop = snapshot.data;
                          return CustomInputDropDown(
                            width: size.width,
                            list: listlop!,
                            title: "Class",
                            valueId: idlop,
                            valueName: tenlop,
                            callback: (outputId, outputName) {
                              idlop = outputId;
                              tenlop = outputName;
                            },
                          );
                        } else {
                          return Text('Error');
                        }
                      },
                    )
                  : CustomInputDropDown(
                      width: size.width,
                      list: listlop!,
                      title: "Class",
                      valueId: idlop,
                      valueName: tenlop,
                      callback: (outputId, outputName) {
                        idlop = outputId;
                        tenlop = outputName;
                      },
                    ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () async {
                    profile.student.mssv = mssv;
                    profile.student.idlop = idlop;
                    profile.student.tenlop = tenlop;
                    profile.user.first_name = ten;
                    await UserRepository().updateProfile();
                    await StudentRepository().dangkylop();

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => PageMain(),
                      ),
                    );
                  },
                  child: MyButton(textButton: 'Lưu thông tin')),
            ],
          ),
        ),
      )),
    );
  }
}
