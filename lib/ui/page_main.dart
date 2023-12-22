import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quanly_sinhvien_2/model/profile.dart';
import 'package:quanly_sinhvien_2/providers/loginviewmodel.dart';
import 'package:quanly_sinhvien_2/ui/customcontroller.dart';
import 'package:quanly_sinhvien_2/ui/page_dklop.dart';
import 'package:quanly_sinhvien_2/ui/page_login.dart';

import '../providers/mainviewmodel.dart';
import '../providers/menubarviewmodel.dart';
import 'AppConstant.dart';
import 'subpagediemdanh.dart';
import 'subpagedshocphan.dart';
import 'subpagedslop.dart';
import 'subpageprofile.dart';
import 'subpagetimkiem.dart';
import 'subpagetintuc.dart';

class PageMain extends StatelessWidget {
  static String routename = '/home';
  PageMain({super.key});
  final List<String> menuTitles = [
    "Tin Tức",
    "Profile",
    "Tim kiem",
    "Điểm Danh",
    "Danh Sách Lớp",
    "Danh Sách Học Phần",
  ];

  final menuBar = MenuItemlist();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewmodel = Provider.of<MainViewModel>(context);
    Profile profile = Profile();
    if (profile.token == "") {
      return PageLogin();
    }
    if (profile.student.mssv != "" || profile.user.first_name == "") {
      return pageDangKyLop();
    }

    Widget body = SubPageTintuc();
    if (viewmodel.activemenu == SubPageProfile.idpage) {
      body = SubPageProfile();
    } else if (viewmodel.activemenu == SubPageProfile.idpage) {
      body = SubPageProfile();
    } else if (viewmodel.activemenu == SubPageTimkiem.idpage) {
      body = SubPageTimkiem();
    } else if (viewmodel.activemenu == SubPageDiemdanh.idpage) {
      body = SubPageDiemdanh();
    } else if (viewmodel.activemenu == SubPageDslop.idpage) {
      body = SubPageDslop();
    } else if (viewmodel.activemenu == SubPageDsHocphan.idpage) {
      body = SubPageDsHocphan();
    }

    menuBar.initialize(menuTitles);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appbarcolor,
        leading: GestureDetector(
          onTap: () => viewmodel.toggleMenu(),
          child: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.logout),
        //     onPressed: () {
        //       Provider.of<LogoutViewModel>(context, listen: false).logout();
        //       Navigator.pushReplacementNamed(context, PageLogin.routename);
        // ],
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Consumer<MenuBarViewModel>(
            builder: (context, menuBarModel, child) {
              return GestureDetector(
                onTap: () {
                  viewmodel.closeMenu();
                },
                child: GestureDetector(
                  onTap: () => viewmodel.closeMenu(),
                  child: Container(
                    color: Colors.grey[300],
                    child: Center(
                      child: body,
                    ),
                  ),
                ),
              );
            },
          ),
          viewmodel.menustatus == 1
              ? Consumer<MenuBarViewModel>(
                  builder: (context, menuBarModel, child) {
                    return GestureDetector(
                        onPanUpdate: (details) {
                          menuBarModel.setOffset(details.localPosition);
                        },
                        onPanEnd: (details) {
                          menuBarModel.setOffset(Offset(0, 0));
                          viewmodel.closeMenu();
                        },
                        child: Stack(
                          children: [CustomeMenuSizeBar(size: size), menuBar],
                        ));
                  },
                )
              : Container(),
        ],
      )),
    );
  }
}

class MenuItemlist extends StatelessWidget {
  MenuItemlist({
    super.key,
  });

  final List<MenuBarItem> menuBarItems = [];
  void initialize(List<String> menuTitles) {
    menuBarItems.clear();
    for (int i = 0; i < menuTitles.length; i++) {
      menuBarItems.add(MenuBarItem(
        idpage: i,
        containnerkey: GlobalKey(),
        titles: menuTitles[i],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * .20,
          width: size.width * .65,
          child: Center(
            child: AvatarGlow(
              duration: Duration(milliseconds: 2000),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: Duration(milliseconds: 100),
              endRadius: size.height * .3,
              glowColor: AppConstant.appbarcolor,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size.height),
                child: SizedBox(
                  height: size.height * .16,
                  width: size.height * .16,
                  // child: Image(
                  //   image: AssetImage(
                  //       'assets/image/a49cc95673f4ebf3a4263ab933f51c22_5393919961047654631.gif'),
                  //   fit: BoxFit.cover,
                  // ),
                  child: CustomAvatar1(
                    size: size,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 2,
          width: size.width * .65,
          color: AppConstant.appbarcolor,
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: size.height * .6,
          width: size.width * .65,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: menuBarItems.length,
              itemBuilder: (content, index) {
                return menuBarItems[index];
              },
            ),
          ),
        ),
      ],
    );
  }
}

class MenuBarItem extends StatelessWidget {
  MenuBarItem({
    super.key,
    required this.titles,
    required this.containnerkey,
    required this.idpage,
  });
  final int idpage;
  final String titles;
  final GlobalKey containnerkey;
  TextStyle style = AppConstant.textbody;

  void onPanmove(Offset offset) {
    if (offset.dy == 0) {
      style = AppConstant.textbody;
    }
    if (containnerkey.currentContext != null) {
      RenderBox box =
          containnerkey.currentContext!.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);
      if (offset.dy < position.dy - 40 && offset.dy > position.dy - 80) {
        style = AppConstant.textbodyfocus;
        MainViewModel().activemenu = idpage;
      } else {
        style = AppConstant.textbody;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuBarModel = Provider.of<MenuBarViewModel>(context);
    onPanmove(menuBarModel.offset);

    return GestureDetector(
      onTap: () => MainViewModel().setActiveMenu(idpage),
      child: Container(
        key: containnerkey,
        alignment: Alignment.centerLeft,
        height: 40,
        child: Text(
          titles,
          style: style,
        ),
      ),
    );
  }
}

class CustomeMenuSizeBar extends StatelessWidget {
  const CustomeMenuSizeBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final sizeBarModel = Provider.of<MenuBarViewModel>(context);
    final size = MediaQuery.of(context).size;
    return CustomPaint(
      size: Size(size.width * .65, size.height),
      painter: DrawerCustomPaint(offset: sizeBarModel.offset),
    );
  }
}

class DrawerCustomPaint extends CustomPainter {
  final Offset offset;

  DrawerCustomPaint({super.repaint, required this.offset});
  double generatePointX(double width) {
    double kq = 0;
    if (offset.dx == 0) {
      kq = width;
    } else if (offset.dx < width) {
      kq = width + 75;
    } else {
      kq = offset.dx;
    }
    return kq;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(
        generatePointX(size.width), offset.dy, size.width, size.height);
    path.lineTo(0, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    // throw UnimplementedError();
    return true;
  }
}
