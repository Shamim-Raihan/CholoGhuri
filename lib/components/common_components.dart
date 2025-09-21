import 'package:chologhuri/helpers/space_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../helpers/color_helper.dart';

class CommonComponents {
  Widget commonButton({
    required text,
    required VoidCallback onPressed,
    bool disabled = false,
    Icon? icon,
    String? imagePath,
    double borderRadius = 60,
    double fontSize = 16,
    double paddingVertical = 12,
    double paddingHorizontal = 24,
    Color color = ColorHelper.primary,
    bool isLoading = false,
    Color? fontColor,
    double? height,
  }) {
    return GestureDetector(
      onTap: disabled ? null : onPressed,
      child: Container(
        height: height ?? 46.h,
        padding: EdgeInsets.symmetric(
          vertical: paddingVertical.h,
          horizontal: paddingHorizontal.w,
        ),
        decoration: BoxDecoration(
          color: disabled ? ColorHelper.primary.withValues(alpha: 0.5) : color,
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
        child: Center(
          child:
              isLoading
                  ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: ColorHelper.background,
                    ),
                  )
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon ??
                          (imagePath != null
                              ? Image.asset(imagePath)
                              : const SizedBox()),
                      if (icon != null || imagePath != null)
                        SpaceHelper.horizontalSpace5,
                      Text(
                        text,
                        style: GoogleFonts.poppins(
                          color: fontColor ?? ColorHelper.background,
                          fontSize: fontSize.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }

  Widget commonText({
    required int fontSize,
    required String textData,
    required FontWeight fontWeight,
    Color color = Colors.white,
    int maxLine = 1,
    TextAlign textAlign = TextAlign.start,
  }) {
    return Text(
      textData,
      textAlign: textAlign,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize.sp,
          color: color,
        ),
      ),
    );
  }

  Widget commonTextField({
    required TextEditingController controller,
    required String labelText,
    IconData? prefixIcon,
    Widget? suffixIcon,
    bool isPassword = false,
    bool enabled = true,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        color: ColorHelper.background,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: ColorHelper.borderColor.withValues(alpha: 0.35),
          width: 1.5,
        ),
      ),
      child: TextFormField(
        enabled: enabled,
        cursorColor: ColorHelper.primary,
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        validator: validator,
        style: GoogleFonts.poppins(
          color: ColorHelper.textPrimary,
          fontSize: 16.sp,
        ),
        decoration: InputDecoration(
          hintText: labelText,
          hintStyle: GoogleFonts.poppins(
            color: ColorHelper.textSecondary,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon:
              prefixIcon != null
                  ? Icon(prefixIcon, color: ColorHelper.textSecondary)
                  : null,
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 16.h,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget commonDialog({
    required BuildContext context,
    required String title,
    required String message,
    required String buttonText,
    VoidCallback? onButtonPressed,
    VoidCallback? onClose,
    Color backgroundColor = Colors.white,
    Color textColor = Colors.black,
    Color? buttonColor,
    Color? buttonTextColor,
    Color? iconColor,
    bool isConfirmationDialog = false,
    String? cancelButtonText,
    VoidCallback? onCancelPressed,
    VoidCallback? onOkPressed,
    Color? cancelButtonColor,
    Color? cancelButtonTextColor,
  }) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      backgroundColor: backgroundColor,
      title: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                IconButton(
                  onPressed: onClose ?? () => Navigator.of(context).pop(),
                  icon: Icon(Icons.cancel_rounded, color: iconColor),
                  iconSize: 24.sp,
                ),
              ],
            ),
            SpaceHelper.verticalSpace3,
            commonText(
              fontSize: 20,
              color: textColor,
              textData: title,
              fontWeight: FontWeight.w600,
            ),
            SpaceHelper.verticalSpace3,
          ],
        ),
      ),
      content: commonText(
        fontSize: 12,
        textAlign: TextAlign.center,
        color: textColor,
        textData: message,
        fontWeight: FontWeight.w400,
        maxLine: 5,
      ),
      actions: [
        isConfirmationDialog
            ? Row(
              children: [
                Expanded(
                  child: commonButton(
                    text: cancelButtonText ?? 'No',
                    onPressed: onCancelPressed ?? () => Navigator.pop(context),
                    color: ColorHelper.primary,
                    fontSize: 12,
                  ),
                ),
                SpaceHelper.horizontalSpace10,
                Expanded(
                  child: commonButton(
                    text: buttonText,
                    onPressed: onOkPressed!,
                    color: buttonColor ?? ColorHelper.primary,
                    fontColor: buttonTextColor ?? Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            )
            : commonButton(
              text: buttonText,
              onPressed: onButtonPressed!,
              color: buttonColor ?? ColorHelper.primary,
              fontColor: buttonTextColor ?? Colors.white,
            ),
      ],
    );
  }
}
