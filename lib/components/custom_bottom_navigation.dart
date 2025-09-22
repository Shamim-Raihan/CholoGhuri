import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helpers/color_helper.dart';
import 'common_components.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0x005d5a6e).withValues(alpha: 0.15),
            offset: const Offset(0, -1),
            blurRadius: 5,
            spreadRadius: 0,
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 64.h,
          padding: EdgeInsets.symmetric(horizontal: 34.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(
                index: 0,
                iconPath: 'assets/icons/',
                iconActive: 'active_home.png',
                iconInactive: 'inactive_home.png',
                label: 'Home',
              ),
              _buildNavItem(
                index: 1,
                iconPath: 'assets/icons/',
                iconActive: 'active_services.png',
                iconInactive: 'inactive_services.png',
                label: 'Services',
              ),
              _buildNavItem(
                index: 2,
                iconPath: 'assets/icons/',
                iconActive: 'active_activity.png',
                iconInactive: 'inactive_activity.png',
                label: 'Activity',
              ),
              _buildNavItem(
                index: 3,
                iconPath: 'assets/icons/',
                iconActive: 'active_account.png',
                iconInactive: 'inactive_account.png',
                label: 'Account',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String iconPath,
    required String iconActive,
    required String iconInactive,
    required String label,
  }) {
    final bool isActive = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: SizedBox(
        width: 48.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 42.w,
              height: 24.h,
              decoration: BoxDecoration(
                color:
                    isActive ? ColorHelper.secondaryLight : Colors.transparent,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Image.asset(
                  iconPath + (isActive ? iconActive : iconInactive),
                  width: isActive ? 20.w : 18.w,
                  height: isActive ? 20.h : 18.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            CommonComponents().commonText(
              fontSize: 10,
              textData: label,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              color: isActive ? ColorHelper.primary : ColorHelper.textSecondary,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
