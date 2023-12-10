import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AppConstant {
  static Color appbarcolor = Colors.grey;

  static Color backgroundcolor = const Color.fromRGBO(224, 224, 224, 1);

  static TextStyle font_roboto = GoogleFonts.roboto(
    fontSize: 40,
    color: Colors.grey[700],
  );
  static TextStyle font_roboto2 = GoogleFonts.roboto(
    fontSize: 24,
    color: Colors.grey[700],
  );

  static TextStyle textError = TextStyle(
    color: Colors.red[300],
    fontSize: 16,
    fontStyle: FontStyle.italic,
  );

  static TextStyle textlink = TextStyle(
    color: Colors.grey[600],
    fontSize: 16,
  );

  static TextStyle textbody = TextStyle(
    color: Colors.grey.shade500,
    fontSize: 16,
  );

  static TextStyle textbodyfocus = const TextStyle(
    color: Colors.grey,
    fontSize: 20,
  );

  static TextStyle textbodywhite = TextStyle(
    color: Colors.white,
    fontSize: 16,
  );

  static TextStyle textbodywhitebold = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static TextStyle textbodyfocuswhite = const TextStyle(
    color: Colors.white,
    fontSize: 20,
  );

  static bool isDate(String str) {
    try {
      var intputFormat = DateFormat('dd/MM/yyyy');
      var date1 = intputFormat.parseStrict(str);
      return true;
    } catch (e) {
      print('--- Đã có lỗi sảy ra ---');
      return false;
    }
  }
}
