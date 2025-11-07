import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ...existing imports...
import '../../../components/common_components.dart';
import '../../../helpers/color_helper.dart';
import '../../../helpers/space_helper.dart';
import '../controller/account_controller.dart';
import 'package:chologhuri/core/localization/localization_service.dart';
import 'package:get/get.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountController());

    return Scaffold(
      backgroundColor: ColorHelper.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SpaceHelper.verticalSpace20,
              _buildProfileSection(controller),
              SpaceHelper.verticalSpace24,
              _buildFAQSection(controller),
              SpaceHelper.verticalSpace15,
              _buildPaymentHistorySection(controller),
              SpaceHelper.verticalSpace15,
              _buildSettingsSection(controller),
              SpaceHelper.verticalSpace20,
              _buildLogoutSection(controller),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(AccountController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorHelper.mapBackground,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: ColorHelper.background,
              borderRadius: BorderRadius.circular(97.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(97.r),
              child: Icon(
                Icons.person,
                size: 30.sp,
                color: ColorHelper.textSecondary,
              ),
            ),
          ),
          SpaceHelper.horizontalSpace12,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonComponents().commonText(
                  fontSize: 14,
                  textData: 'Asif Rahman',
                  fontWeight: FontWeight.w500,
                  color: ColorHelper.textPrimary,
                ),
                SpaceHelper.verticalSpace4,
                GestureDetector(
                  onTap: () => controller.navigateToProfile(),
                  child: CommonComponents().commonText(
                    fontSize: 12,
                    textData: 'see_profile'.tr,
                    fontWeight: FontWeight.w400,
                    color: ColorHelper.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQSection(AccountController controller) {
    return Container(
      decoration: BoxDecoration(
        color: ColorHelper.mapBackground,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: _buildMenuItem(
        iconPath: 'assets/icons/message-search.png',
        title: 'faq'.tr,
        onTap: () => controller.navigateToFAQ(),
        showBorder: false,
      ),
    );
  }

  Widget _buildPaymentHistorySection(AccountController controller) {
    return Container(
      decoration: BoxDecoration(
        color: ColorHelper.mapBackground,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: _buildMenuItem(
        iconPath: 'assets/icons/wallet-minus.png',
        title: 'payment_history'.tr,
        onTap: () => controller.navigateToPaymentHistory(),
        showBorder: false,
      ),
    );
  }

  Widget _buildSettingsSection(AccountController controller) {
    return Container(
      decoration: BoxDecoration(
        color: ColorHelper.mapBackground,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: _buildMenuItem(
        iconPath: 'assets/icons/setting-2.png',
        title: 'settings'.tr,
        onTap: () => _showSettingsMenu(),
        showBorder: false,
      ),
    );
  }

  void _showSettingsMenu() {
    final loc = Get.find<LocalizationService>();
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorHelper.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonComponents().commonText(
              fontSize: 16,
              textData: 'select_language'.tr,
              fontWeight: FontWeight.w600,
              color: ColorHelper.textPrimary,
            ),
            SpaceHelper.verticalSpace12,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    await loc.changeLanguage('en');
                    Get.back();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color:
                          loc.currentLanguage == 'en'
                              ? ColorHelper.primary
                              : ColorHelper.mapBackground,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: CommonComponents().commonText(
                      fontSize: 14,
                      textData: 'EN',
                      fontWeight: FontWeight.w500,
                      color:
                          loc.currentLanguage == 'en'
                              ? ColorHelper.background
                              : ColorHelper.textPrimary,
                    ),
                  ),
                ),
                SpaceHelper.horizontalSpace12,
                GestureDetector(
                  onTap: () async {
                    await loc.changeLanguage('bn');
                    Get.back();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color:
                          loc.currentLanguage == 'bn'
                              ? ColorHelper.primary
                              : ColorHelper.mapBackground,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: CommonComponents().commonText(
                      fontSize: 14,
                      textData: 'BN',
                      fontWeight: FontWeight.w500,
                      color:
                          loc.currentLanguage == 'bn'
                              ? ColorHelper.background
                              : ColorHelper.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            SpaceHelper.verticalSpace15,
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required String iconPath,
    required String title,
    required VoidCallback onTap,
    required bool showBorder,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 58.h,
        decoration: BoxDecoration(
          border:
              showBorder
                  ? Border(
                    bottom: BorderSide(
                      color: ColorHelper.textSecondary.withValues(alpha: 0.1),
                      width: 1,
                    ),
                  )
                  : null,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              // Icon
              SizedBox(
                width: 20.w,
                height: 20.h,
                child: Image.asset(
                  iconPath,
                  width: 20.w,
                  height: 20.h,
                  color: ColorHelper.primary,
                ),
              ),
              SpaceHelper.horizontalSpace12,
              // Title
              Expanded(
                child: CommonComponents().commonText(
                  fontSize: 14,
                  textData: title,
                  fontWeight: FontWeight.w400,
                  color: ColorHelper.textPrimary,
                ),
              ),
              // Arrow
              Icon(
                Icons.arrow_forward_ios,
                size: 18.sp,
                color: ColorHelper.textPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutSection(AccountController controller) {
    return Obx(
      () => GestureDetector(
        onTap: controller.isLoadingValue ? null : controller.onLogoutPressed,
        child: Container(
          height: 58.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorHelper.mapBackground,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Center(
            child:
                controller.isLoadingValue
                    ? SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: ColorHelper.logoutColor,
                      ),
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/logout.png',
                          height: 24.sp,
                          width: 24.sp,
                          color: ColorHelper.logoutColor,
                        ),
                        SpaceHelper.horizontalSpace8,
                        CommonComponents().commonText(
                          fontSize: 16,
                          textData: 'logout'.tr,
                          fontWeight: FontWeight.w400,
                          color: ColorHelper.logoutColor,
                        ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}
