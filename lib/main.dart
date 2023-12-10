import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quanly_sinhvien_2/model/profile.dart';
import 'package:quanly_sinhvien_2/providers/diachimodel.dart';
import 'package:quanly_sinhvien_2/providers/forgotviewmodel.dart';
import 'package:quanly_sinhvien_2/providers/loginviewmodel.dart';
import 'package:quanly_sinhvien_2/providers/mainviewmodel.dart';
import 'package:quanly_sinhvien_2/providers/menubarviewmodel.dart';
import 'package:quanly_sinhvien_2/providers/profileviewmodel.dart';
import 'package:quanly_sinhvien_2/providers/registerviewmodel.dart';
import 'package:quanly_sinhvien_2/ui/page_Forgot.dart';

import 'ui/page_login.dart';
import 'ui/page_main.dart';
import 'ui/page_register.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Profile profile = Profile();
  profile.initialize();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<LoginViewModel>(
      create: (context) => LoginViewModel(),
    ),
    ChangeNotifierProvider<RegisterViewModel>(
      create: (context) => RegisterViewModel(),
    ),
    ChangeNotifierProvider<ForgotViewModel>(
      create: (context) => ForgotViewModel(),
    ),
    ChangeNotifierProvider<MainViewModel>(
      create: (context) => MainViewModel(),
    ),
    ChangeNotifierProvider<MenuBarViewModel>(
      create: (context) => MenuBarViewModel(),
    ),
    ChangeNotifierProvider<ProfileViewModel>(
      create: (context) => ProfileViewModel(),
    ),
    ChangeNotifierProvider<DiachiModel>(
      create: (context) => DiachiModel(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => PageMain(),
        '/login': (context) => PageLogin(),
        '/register': (context) => PageRegister(),
        '/forgot': (context) => PageForgot()
      },
      title: "Quản Lý Sinh Viên",
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: PageMain(),
    );
  }
}
