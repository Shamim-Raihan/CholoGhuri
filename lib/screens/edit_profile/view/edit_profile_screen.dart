import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../components/common_components.dart';
import '../../../helpers/color_helper.dart';
import '../../../helpers/space_helper.dart';
import '../controller/edit_profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());

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
                            child: Form(
                              key: controller.formKey,
                              child: Column(
                                children: [
                                  SpaceHelper.verticalSpace20,
                                  _buildProfileHeader(controller),
                                  SpaceHelper.verticalSpace30,
                                  _buildEditForm(controller),
                                  SpaceHelper.verticalSpace40,
                                  _buildSaveButton(controller),
                                  SpaceHelper.verticalSpace30,
                                ],
                              ),
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

  /// Custom app bar with back button and title
  Widget _buildCustomAppBar(EditProfileController controller) {
    return Container(
      height: 60.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => controller.goBack(),
            child: Icon(
              Icons.arrow_back_ios,
              size: 24.sp,
              color: ColorHelper.textPrimary,
            ),
          ),
          SpaceHelper.horizontalSpace12,
          CommonComponents().commonText(
            fontSize: 16,
            textData: 'Edit Profile',
            fontWeight: FontWeight.w500,
            color: ColorHelper.textPrimary,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(EditProfileController controller) {
    return Center(
      child: GestureDetector(
        onTap: () => controller.showImagePicker(),
        child: Stack(
          children: [
            Obx(
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
                      controller.selectedImageValue != null
                          ? Image.file(
                            controller.selectedImageValue!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildDefaultAvatar();
                            },
                          )
                          : _buildDefaultAvatar(),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 36.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: ColorHelper.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorHelper.background, width: 2.w),
                ),
                child: Icon(
                  Icons.camera_alt,
                  size: 18.sp,
                  color: ColorHelper.background,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Default avatar when no image is selected
  Widget _buildDefaultAvatar() {
    return Container(
      color: ColorHelper.mapBackground,
      child: Icon(Icons.person, size: 60.sp, color: ColorHelper.textSecondary),
    );
  }

  /// Edit form with text fields
  Widget _buildEditForm(EditProfileController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Full Name'),
        SpaceHelper.verticalSpace8,
        CommonComponents().commonTextField(
          controller: controller.nameController,
          labelText: 'Enter your full name',
          prefixIcon: Icons.person_outline,
          validator: controller.validateName,
        ),
        SpaceHelper.verticalSpace20,

        _buildFieldLabel('Phone Number'),
        SpaceHelper.verticalSpace8,
        CommonComponents().commonTextField(
          controller: controller.phoneController,
          labelText: 'Enter your phone number',
          prefixIcon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: controller.validatePhone,
        ),
        SpaceHelper.verticalSpace20,

        _buildFieldLabel('Email Address'),
        SpaceHelper.verticalSpace8,
        CommonComponents().commonTextField(
          controller: controller.emailController,
          labelText: 'Enter your email address',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: controller.validateEmail,
        ),
      ],
    );
  }

  /// Field label widget
  Widget _buildFieldLabel(String label) {
    return CommonComponents().commonText(
      fontSize: 14,
      textData: label,
      fontWeight: FontWeight.w500,
      color: ColorHelper.textPrimary,
    );
  }

  /// Save button
  Widget _buildSaveButton(EditProfileController controller) {
    return Obx(
      () => CommonComponents().commonButton(
        text: 'Save Changes',
        onPressed: controller.saveProfile,
        isLoading: controller.isSavingValue,
        disabled: controller.isSavingValue,
        color: ColorHelper.primary,
        fontColor: ColorHelper.background,
        height: 50.h,
        borderRadius: 12,
      ),
    );
  }
}
