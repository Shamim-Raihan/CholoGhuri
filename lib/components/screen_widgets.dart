import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helpers/color_helper.dart';
import '../helpers/space_helper.dart';
import '../screens/home/view/home_screen.dart';
import 'common_components.dart';

// Home Screen Widget
class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}

// Services Screen Widget
class ServicesWidget extends StatelessWidget {
  const ServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SpaceHelper.verticalSpace30,
          CommonComponents().commonText(
            fontSize: 24,
            textData: 'Services',
            fontWeight: FontWeight.w600,
            color: ColorHelper.textPrimary,
          ),
          SpaceHelper.verticalSpace8,
          CommonComponents().commonText(
            fontSize: 16,
            textData: 'Explore our available services',
            fontWeight: FontWeight.w400,
            color: ColorHelper.textSecondary,
          ),
          SpaceHelper.verticalSpace40,
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.grid_view_rounded,
                    size: 80.sp,
                    color: ColorHelper.primary,
                  ),
                  SpaceHelper.verticalSpace20,
                  CommonComponents().commonText(
                    fontSize: 18,
                    textData: 'Services Screen',
                    fontWeight: FontWeight.w600,
                    color: ColorHelper.textPrimary,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Activity Screen Widget
class ActivityWidget extends StatelessWidget {
  const ActivityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SpaceHelper.verticalSpace30,
          CommonComponents().commonText(
            fontSize: 24,
            textData: 'Activity',
            fontWeight: FontWeight.w600,
            color: ColorHelper.textPrimary,
          ),
          SpaceHelper.verticalSpace8,
          CommonComponents().commonText(
            fontSize: 16,
            textData: 'Track your activities and progress',
            fontWeight: FontWeight.w400,
            color: ColorHelper.textSecondary,
          ),
          SpaceHelper.verticalSpace40,
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long_rounded,
                    size: 80.sp,
                    color: ColorHelper.primary,
                  ),
                  SpaceHelper.verticalSpace20,
                  CommonComponents().commonText(
                    fontSize: 18,
                    textData: 'Activity Screen',
                    fontWeight: FontWeight.w600,
                    color: ColorHelper.textPrimary,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Account Screen Widget
class AccountWidget extends StatelessWidget {
  const AccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SpaceHelper.verticalSpace30,
          CommonComponents().commonText(
            fontSize: 24,
            textData: 'Account',
            fontWeight: FontWeight.w600,
            color: ColorHelper.textPrimary,
          ),
          SpaceHelper.verticalSpace8,
          CommonComponents().commonText(
            fontSize: 16,
            textData: 'Manage your profile and settings',
            fontWeight: FontWeight.w400,
            color: ColorHelper.textSecondary,
          ),
          SpaceHelper.verticalSpace40,
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_rounded,
                    size: 80.sp,
                    color: ColorHelper.primary,
                  ),
                  SpaceHelper.verticalSpace20,
                  CommonComponents().commonText(
                    fontSize: 18,
                    textData: 'Account Screen',
                    fontWeight: FontWeight.w600,
                    color: ColorHelper.textPrimary,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
