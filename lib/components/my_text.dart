import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../appColors/app_color.dart';

class MyText extends StatelessWidget {
  String text;
  Color? color;
  FontWeight? fontWeight;
  int? maxLines;
  var fontSize;
  MyText(
      {required this.text,
      this.fontSize,
      this.fontWeight,
      this.color,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 13,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: fontSize ?? 14.sp,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color ?? AppColor.kWhiteColor),
    );
  }
}
