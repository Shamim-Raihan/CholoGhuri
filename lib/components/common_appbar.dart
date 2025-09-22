import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helpers/color_helper.dart';
import 'common_components.dart';

Widget appbar({
  required VoidCallback onPrefixTap,
  required VoidCallback onSuffixTap,
  required String title,
  IconData? prefixIcon,
  IconData? suffixIcon,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
        onTap: onPrefixTap,
        child: Container(
          width: 24.w,
          height: 24.h,
          alignment: Alignment.center,
          child: Icon(prefixIcon, size: 18.w, color: ColorHelper.textPrimary),
        ),
      ),
      CommonComponents().commonText(
        fontSize: 16,
        textData: title,
        fontWeight: FontWeight.w500,
        color: ColorHelper.textPrimary,
      ),
      GestureDetector(
        onTap: onPrefixTap,
        child: Container(
          width: 24.w,
          height: 24.h,
          alignment: Alignment.center,
          child: Icon(suffixIcon, size: 18.w, color: ColorHelper.textPrimary),
        ),
      ),
    ],
  );
}
