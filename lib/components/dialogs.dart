import 'package:chologhuri/components/common_components.dart';
import 'package:chologhuri/helpers/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dialogs {
  sendEmailVerificationDialog({required String email}) {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorHelper.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: ColorHelper.primary, width: 1),
          ),
          title: CommonComponents().commonText(
            fontSize: 12,
            color: ColorHelper.primary,
            textData: 'Email Verification',
            fontWeight: FontWeight.bold,
          ),
          content: CommonComponents().commonText(
            fontSize: 10,
            color: ColorHelper.background,
            textData:
                'Verification mail send to your email. Please check it and verify your account.\n$email',
            fontWeight: FontWeight.normal,
            maxLine: 5,
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: CommonComponents().commonText(
                fontSize: 12,
                color: ColorHelper.primary,
                textData: 'OK',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }
}
