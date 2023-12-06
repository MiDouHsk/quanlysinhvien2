import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/forgotviewmodel.dart';
import 'AppConstant.dart';
import 'customcontroller.dart';
import 'page_login.dart';

class PageForgot extends StatelessWidget {
  PageForgot({super.key});
  static String routename = "/forgot";
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ForgotViewModel>(context);

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppConstant.backgroundcolor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () =>
              Navigator.of(context).popAndPushNamed(PageLogin.routename),
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: viewmodel.status == 3
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage('assets/image/bronya_stick.gif'),
                      ),
                      Text(
                        "đã gửi yêu cầu thành công!",
                        style: AppConstant.font_roboto2,
                      ),
                      const Text(
                        "truy cap vao email va lam theo huong dan",
                        style:
                            TextStyle(fontSize: 16, color: Colors.blueAccent),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              viewmodel.status = 0;
                              Navigator.popAndPushNamed(
                                  context, PageLogin.routename);
                            },
                            child: Text(
                              "Bam vao day ",
                              style: AppConstant.textlink,
                            ),
                          ),
                          Text("de dang nhap")
                        ],
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(0),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Image(
                            image: AssetImage(
                              'assets/image/user.png',
                            ),
                            height: 200,
                            // width: 150,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Text(
                              "Enter your email to retrieve your password!"),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 2.2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                labelText: "Email",
                                border: OutlineInputBorder(),
                                prefixIcon:
                                    Icon(Icons.mark_email_read_outlined),
                                hintText: "",
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            viewmodel.errormessage,
                            style: AppConstant.textError,
                          ),
                          GestureDetector(
                            onTap: () {
                              final email = _emailController.text.trim();
                              viewmodel.forgotPassword(email);
                            },
                            child: const MyButton(textButton: "Send Links"),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // GestureDetector(
                          //   onTap: () => Navigator.of(context)
                          //       .popAndPushNamed(PageLogin.routename),
                          //   child: Text(
                          //     "<< Dang Nhap ",
                          //     style: AppConstant.textlink,
                          //   ),
                          // )
                        ],
                      ),
                      viewmodel.status == 1
                          ? CustomSpinner(size: size)
                          : Container(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
