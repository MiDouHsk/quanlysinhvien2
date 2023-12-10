import 'package:flutter/material.dart';
import 'package:quanly_sinhvien_2/model/lop.dart';
import 'package:quanly_sinhvien_2/model/place.dart';

import '../model/profile.dart';
import 'AppConstant.dart';

class CustomPlaceDropDown extends StatefulWidget {
  CustomPlaceDropDown({
    super.key,
    // required this.profile,
    required this.width,
    required this.title,
    required this.callback,
    required this.list,
    required this.valueId,
    required this.valueName,
  });

  // final Profile profile;
  final double width;
  final String title;
  final int valueId;
  final String valueName;
  final List<Place> list;
  final Function(int outputId, String outputName) callback;

  @override
  State<CustomPlaceDropDown> createState() => _CustomPlaceDropDownFieldState();
}

class _CustomPlaceDropDownFieldState extends State<CustomPlaceDropDown> {
  int status = 0;
  int outputId = 0;
  String outputName = "";

  @override
  void initState() {
    // TODO: implement initState
    outputId = widget.valueId;
    outputName = widget.valueName;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: AppConstant.textbody,
          ),
          status == 0
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      status = 1;
                    });
                  },
                  child: Text(
                    // widget.profile.user.first_name + " Ten Ten Ten",

                    widget.valueName == "" ? "Nothing!" : widget.valueName,
                    style: AppConstant.textbodyfocus,
                  ),
                )
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade200),
                  width: widget.width - 20,
                  child: DropdownButton(
                    value: widget.valueId,
                    items: widget.list
                        .map((e) => DropdownMenuItem(
                              value: e.id,
                              child: Container(
                                  width: widget.width * .6,
                                  child: Text(
                                    e.name,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        outputId = value!;
                        for (var dropitem in widget.list) {
                          if (dropitem.id == outputId) {
                            outputName = dropitem.name;
                            widget.callback(outputId, outputName);
                            break;
                          }
                        }
                        status = 0;
                      });
                    },
                  ),
                ),
          Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}

class CustomInputDropDown extends StatefulWidget {
  CustomInputDropDown({
    super.key,
    // required this.profile,
    required this.width,
    required this.title,
    required this.callback,
    required this.list,
    required this.valueId,
    required this.valueName,
  });

  // final Profile profile;
  final double width;
  final String title;
  final int valueId;
  final String valueName;
  final List<Lop> list;
  final Function(int outputId, String outputName) callback;

  @override
  State<CustomInputDropDown> createState() => _CustomInputDropDownFieldState();
}

class _CustomInputDropDownFieldState extends State<CustomInputDropDown> {
  int status = 0;
  int outputId = 0;
  String outputName = "";

  @override
  void initState() {
    // TODO: implement initState
    outputId = widget.valueId;
    outputName = widget.valueName;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppConstant.textbody,
        ),
        status == 0
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    status = 1;
                  });
                },
                child: Text(
                  // widget.profile.user.first_name + " Ten Ten Ten",

                  outputName == "" ? "Nothing!" : outputName,
                  style: AppConstant.textbodyfocus,
                ),
              )
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade200),
                width: widget.width - 25,
                child: DropdownButton(
                  value: outputId,
                  items: widget.list
                      .map((e) => DropdownMenuItem(
                            value: e.id,
                            child: Container(
                                width: widget.width * .8,
                                child: Text(
                                  e.ten,
                                  overflow: TextOverflow.ellipsis,
                                )),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      outputId = value!;
                      for (var dropitem in widget.list) {
                        if (dropitem.id == outputId) {
                          outputName = dropitem.ten;
                          widget.callback(outputId, outputName);
                          break;
                        }
                      }
                      status = 0;
                    });
                  },
                ),
              ),
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}

class CustomInputTextFormField extends StatefulWidget {
  CustomInputTextFormField({
    super.key,
    // required this.profile,
    required this.width,
    required this.title,
    required this.value,
    required this.callback,
    this.type = TextInputType.text,
  });

  // final Profile profile;
  final double width;
  final String title;
  final String value;
  final TextInputType type;

  final Function(String output) callback;

  @override
  State<CustomInputTextFormField> createState() =>
      _CustomInputTextFormFieldState();
}

class _CustomInputTextFormFieldState extends State<CustomInputTextFormField> {
  int status = 0;
  String output = "";

  @override
  void initState() {
    // TODO: implement initState
    output = widget.value;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: AppConstant.textbody,
          ),
          status == 0
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      status = 1;
                    });
                  },
                  child: Text(
                    widget.value == "" ? "Nothing!" : widget.value,
                    style: AppConstant.textbodyfocus,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade200),
                      width: widget.width - 50,
                      child: TextFormField(
                        keyboardType: widget.type,
                        decoration: InputDecoration(border: InputBorder.none),
                        initialValue: output,
                        onChanged: (value) {
                          setState(() {
                            output = value;
                            widget.callback(output);
                          });
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          status = 0;
                          widget.callback(output);
                        });
                      },
                      child: const Icon(
                        Icons.save,
                        size: 18,
                      ),
                    ),
                  ],
                ),
          Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}

Image CustomLogo() {
  return Image.asset(
    "assets/image/user.png",
    height: 150,
    width: 150,
  );
}

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.textButton});
  final String textButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          textButton,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.lock,
      size: 100,
      color: Colors.black,
    );
  }
}

class CustomSpinner extends StatelessWidget {
  const CustomSpinner({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.grey.shade800.withOpacity(.5),
      child: const Center(
        child: Image(
          width: 150,
          image: AssetImage(
            "assets/image/Spinner.gif",
          ),
        ),
      ),
    );
  }
}

class CustomAvatar1 extends StatelessWidget {
  CustomAvatar1({
    super.key,
    required this.size,
  });

  final Size size;
  Profile profile = Profile();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size.height * .25),
      child: Container(
        width: 100,
        height: 100,
        child: Image.network(
          profile.user.avatar,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
