import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../components/common_components.dart';
import '../../../helpers/color_helper.dart';
import '../../../helpers/space_helper.dart';
import '../controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: ColorHelper.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildCustomAppBar(controller),
            Expanded(
              child: Obx(
                () =>
                    controller.isLoadingValue
                        ? const Center(child: CircularProgressIndicator())
                        : SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              children: [
                                SpaceHelper.verticalSpace20,
                                _buildProfileHeader(controller),
                                SpaceHelper.verticalSpace20,
                                _buildUserName(controller),
                                SpaceHelper.verticalSpace30,
                                _buildUserInfoSection(controller),
                                SpaceHelper.verticalSpace50,
                              ],
                            ),
                          ),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Custom app bar with back button, title, and edit icon
  Widget _buildCustomAppBar(ProfileController controller) {
    return Container(
      height: 60.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => controller.goBack(),
            child: Icon(
              Icons.arrow_back_ios,
              size: 24.sp,
              color: ColorHelper.textPrimary,
            ),
          ),
          CommonComponents().commonText(
            fontSize: 16,
            textData: 'Profile',
            fontWeight: FontWeight.w500,
            color: ColorHelper.textPrimary,
          ),
          GestureDetector(
            onTap: () => controller.navigateToEditProfile(),
            child: Image.asset(
              'assets/icons/edit.png',
              width: 24.w,
              height: 24.h,
              color: ColorHelper.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  /// Profile header with circular avatar
  Widget _buildProfileHeader(ProfileController controller) {
    return Center(
      child: Obx(
        () => Container(
          width: 120.w,
          height: 120.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: ColorHelper.primary, width: 2.w),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60.r),
            child:
                controller.profileImageValue != null
                    ? Image.file(
                      controller.profileImageValue!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildDefaultAvatar();
                      },
                    )
                    : _buildDefaultAvatar(),
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      color: ColorHelper.mapBackground,
      child: Icon(Icons.person, size: 60.sp, color: ColorHelper.textSecondary),
    );
  }

  /// User name display
  Widget _buildUserName(ProfileController controller) {
    return Center(
      child: CommonComponents().commonText(
        fontSize: 18,
        textData: controller.userNameValue,
        fontWeight: FontWeight.w500,
        color: ColorHelper.textPrimary,
      ),
    );
  }

  /// User information section with phone, email, and joined date
  Widget _buildUserInfoSection(ProfileController controller) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorHelper.background,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: ColorHelper.textSecondary.withValues(alpha: 0.1),
            blurRadius: 10.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInfoItem(
            label: 'Mobile',
            value: controller.userPhoneValue,
            showBorder: true,
          ),
          _buildInfoItem(
            label: 'Email',
            value: controller.userEmailValue,
            showBorder: true,
          ),
          _buildInfoItem(
            label: 'Joined',
            value: controller.joinedDateValue,
            showBorder: false,
          ),
        ],
      ),
    );
  }

  /// Individual info item widget
  Widget _buildInfoItem({
    required String label,
    required String value,
    required bool showBorder,
  }) {
    return Container(
      height: 75.h,
      width: double.infinity,
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
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonComponents().commonText(
              fontSize: 12,
              textData: label,
              fontWeight: FontWeight.w400,
              color: ColorHelper.textSecondary,
            ),
            SpaceHelper.verticalSpace4,
            CommonComponents().commonText(
              fontSize: 14,
              textData: value,
              fontWeight: FontWeight.w500,
              color: ColorHelper.textPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
