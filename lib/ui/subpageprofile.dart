import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quanly_sinhvien_2/model/profile.dart';
import 'package:quanly_sinhvien_2/providers/diachimodel.dart';
import 'package:quanly_sinhvien_2/providers/profileviewmodel.dart';
import '../providers/mainviewmodel.dart';
import 'AppConstant.dart';
import 'customcontroller.dart';

class SubPageProfile extends StatelessWidget {
  SubPageProfile({super.key});
  static int idpage = 1;
  XFile? image;

  Future<void> init(DiachiModel dcmodel, ProfileViewModel viewmodel) async {
    Profile profile = Profile();

    if (dcmodel.listCity.isEmpty ||
        dcmodel.curCityId != profile.user.provinceid ||
        dcmodel.curDistId != profile.user.districtid ||
        dcmodel.curWardId != profile.user.wardid) {
      viewmodel.displayspinner();
      await dcmodel.initialize(profile.user.provinceid, profile.user.districtid,
          profile.user.wardid);
      print('------finish ---- init -------');
      viewmodel.hidespinner();
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ProfileViewModel>(context);
    final dcmodel = Provider.of<DiachiModel>(context);
    final size = MediaQuery.of(context).size;
    final profile = Profile();
    Future.delayed(Duration.zero, () => init(dcmodel, viewmodel));

    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // --- start header --- //
                  Createheader(size, profile, viewmodel),
                  // end header ....
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomInputTextFormField(
                              title: 'PhoneNumber',
                              value: profile.user.phone,
                              width: size.width * .45,
                              callback: (output) {
                                profile.user.phone = output;
                                viewmodel.setModified();
                                viewmodel.updatescreen();
                              },
                              type: TextInputType.phone,
                            ),
                            CustomInputTextFormField(
                              title: 'Date',
                              value: profile.user.birthday,
                              width: size.width * .45,
                              callback: (output) {
                                if (AppConstant.isDate(output)) {
                                  profile.user.birthday = output;
                                }
                                viewmodel.setModified();
                                viewmodel.updatescreen();
                              },
                              type: TextInputType.datetime,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomPlaceDropDown(
                              width: size.width * .45,
                              title: 'Tỉnh / Thành phố',
                              valueId: profile.user.provinceid,
                              valueName: profile.user.provincename,
                              callback: (outputId, outputName) async {
                                viewmodel.displayspinner();
                                profile.user.provinceid = outputId;
                                profile.user.provincename = outputName;
                                await dcmodel.setCity(outputId);
                                profile.user.wardid = 0;
                                profile.user.districtid = 0;
                                profile.user.wardname = "";
                                profile.user.districtname = "";
                                viewmodel.setModified();
                                viewmodel.hidespinner();
                              },
                              list: dcmodel.listCity,
                            ),
                            CustomPlaceDropDown(
                                width: size.width * .45,
                                title: 'Quận / Huyện',
                                valueId: profile.user.districtid,
                                valueName: profile.user.districtname,
                                callback: (outputId, outputName) async {
                                  viewmodel.displayspinner();
                                  profile.user.districtid = outputId;
                                  profile.user.districtname = outputName;
                                  await dcmodel.setDistrict(outputId);
                                  profile.user.wardid = 0;
                                  profile.user.wardname = "";
                                  viewmodel.setModified();
                                  viewmodel.hidespinner();
                                },
                                list: dcmodel.listDistrict),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomPlaceDropDown(
                              width: size.width * .45,
                              valueId: profile.user.wardid,
                              valueName: profile.user.wardname,
                              title: 'Huyện / Xã',
                              callback: (outputId, outputName) async {
                                viewmodel.displayspinner();
                                profile.user.wardid = outputId;
                                profile.user.wardname = outputName;
                                await dcmodel.setWard(outputId);
                                viewmodel.setModified();
                                viewmodel.hidespinner();
                              },
                              list: dcmodel.listWard,
                            ),
                            CustomInputTextFormField(
                              title: 'Local',
                              value: profile.user.address,
                              width: size.width * .45,
                              callback: (output) {
                                profile.user.address = output;
                                viewmodel.setModified();
                                viewmodel.updatescreen();
                              },
                              type: TextInputType.streetAddress,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            height: size.height * .3,
                            width: size.width * .3,
                            child: QrImageView(
                              data:
                                  '{userid:' + profile.user.id.toString() + '}',
                              version: QrVersions.auto,
                              gapless: false,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            viewmodel.status == 1 ? CustomSpinner(size: size) : Container(),
          ],
        ),
      ),
    );
  }

  Container Createheader(
      Size size, Profile profile, ProfileViewModel viewModel) {
    return Container(
      // --- end ----
      height: size.height * .20,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppConstant.appbarcolor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star_border,
                    color: Colors.yellow.shade400,
                  ),
                  Text(
                    profile.student.diem.toString(),
                    style: AppConstant.textbodywhite,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: viewModel.updatedavatar == 1 && image != null
                    ? Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.file(
                                File(image!.path),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                viewModel.uploadAvatar(image!);
                              },
                              child: Container(
                                  color: Colors.white,
                                  child: Icon(size: 30, Icons.save)),
                            ),
                          ),
                        ],
                      )
                    : GestureDetector(
                        onTap: () async {
                          final ImagePicker _picker = ImagePicker();
                          image = await _picker.pickImage(
                              source: ImageSource.gallery);
                          viewModel.setUpdateavatar();
                        },
                        child: CustomAvatar1(size: size)),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.user.first_name,
                style: AppConstant.textbodyfocuswhite,
              ),
              Row(
                children: [
                  Text(
                    'Mssv: ',
                    style: AppConstant.textbodywhite,
                  ),
                  Text(
                    profile.student.mssv,
                    style: AppConstant.textbodywhitebold,
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    'Lop: ',
                    style: AppConstant.textbodywhite,
                  ),
                  Text(
                    profile.student.tenlop,
                    style: AppConstant.textbodywhitebold,
                  ),
                  profile.student.duyet == 0
                      ? Text(
                          "(Chưa Duyệt)",
                          style: AppConstant.textbodywhite,
                        )
                      : Text(""),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Vai trò: ',
                    style: AppConstant.textbodywhite,
                  ),
                  profile.user.role_id == 4
                      ? Text(
                          'Sinh Vien',
                          style: AppConstant.textbodywhitebold,
                        )
                      : Text(
                          'Giang Vien',
                          style: AppConstant.textbodywhitebold,
                        )
                ],
              ),
              SizedBox(
                width: size.width * .4,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: viewModel.modified == 1
                      ? GestureDetector(
                          onTap: () {
                            viewModel.updateProfile();
                          },
                          child: Icon(Icons.save))
                      : Container(),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
