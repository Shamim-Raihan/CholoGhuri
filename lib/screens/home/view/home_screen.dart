import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../components/common_components.dart';
import '../../../helpers/color_helper.dart';
import '../../../helpers/space_helper.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: ColorHelper.background,
      body: SafeArea(
        child: Column(
          children: [
            SpaceHelper.verticalSpace20,
            _buildLocationHeader(controller),
            SpaceHelper.verticalSpace20,
            _buildFilterChips(controller),
            SpaceHelper.verticalSpace15,
            Expanded(child: _buildMapContainer(controller)),
          ],
        ),
      ),
    );
  }

  // Location header with icon, title, address and dropdown
  Widget _buildLocationHeader(HomeController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          SizedBox(
            width: 24.w,
            height: 24.h,
            child: Icon(
              Icons.location_on,
              color: ColorHelper.primary,
              size: 24.sp,
            ),
          ),
          SpaceHelper.horizontalSpace12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonComponents().commonText(
                  fontSize: 14,
                  textData: controller.locationTitle.value,
                  fontWeight: FontWeight.w400,
                  color: ColorHelper.textSecondary,
                ),
                Obx(
                  () => GestureDetector(
                    onTap: controller.onLocationTap,
                    child: Row(
                      children: [
                        Expanded(
                          child: CommonComponents().commonText(
                            fontSize: 16,
                            textData: controller.currentLocation.value,
                            fontWeight: FontWeight.w500,
                            color: ColorHelper.textPrimary,
                          ),
                        ),
                        SpaceHelper.horizontalSpace8,
                        Transform.rotate(
                          angle:
                              1.5708, // 90 degrees in radians (pointing down)
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 16.sp,
                            color: ColorHelper.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Horizontal scrollable filter chips
  Widget _buildFilterChips(HomeController controller) {
    return SizedBox(
      height: 34.h,
      child: Obx(
        () => ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          itemCount: controller.filterOptions.length,
          itemBuilder: (context, index) {
            final isSelected = controller.selectedFilterIndex.value == index;
            return Padding(
              padding: EdgeInsets.only(right: 4.w),
              child: GestureDetector(
                onTap: () => controller.selectFilter(index),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? ColorHelper.primary
                            : ColorHelper.filterChipInactive,
                    borderRadius: BorderRadius.circular(45.r),
                  ),
                  child: Center(
                    child: CommonComponents().commonText(
                      fontSize: 14,
                      textData: controller.filterOptions[index],
                      fontWeight: FontWeight.w400,
                      color:
                          isSelected
                              ? ColorHelper.background
                              : ColorHelper.textSecondary,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Map container with markers and controls
  Widget _buildMapContainer(HomeController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Stack(
        children: [
          // Map background container
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorHelper.mapBackground,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Stack(
                children: [
                  // Map background (placeholder for actual map)
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: ColorHelper.mapBackground,
                    child: Center(
                      child: CommonComponents().commonText(
                        fontSize: 16,
                        textData: 'Map will be integrated here',
                        fontWeight: FontWeight.w400,
                        color: ColorHelper.textSecondary,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  // Map markers
                  _buildMapMarkers(controller),
                  // User location indicator (center of map)
                  _buildUserLocationIndicator(),
                ],
              ),
            ),
          ),
          // My location button
          Positioned(
            bottom: 9.h,
            right: 8.w,
            child: _buildMyLocationButton(controller),
          ),
        ],
      ),
    );
  }

  // Map markers scattered across the map
  Widget _buildMapMarkers(HomeController controller) {
    return Stack(
      children: [
        // Sample marker positions based on Figma design
        _buildMarkerAt(164.w, 62.h, controller), // Center top
        _buildMarkerAt(44.w, 128.h, controller), // Left
        _buildMarkerAt(244.w, 364.h, controller), // Right bottom
        _buildMarkerAt(60.w, 280.h, controller), // Left bottom
        _buildMarkerAt(297.w, 186.h, controller), // Right
        _buildMarkerAt(197.w, 285.h, controller), // Center bottom
        _buildMarkerAt(124.w, 359.h, controller), // Center bottom
        _buildMarkerAt(184.w, 152.h, controller), // Center
      ],
    );
  }

  Widget _buildMarkerAt(double left, double top, HomeController controller) {
    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onTap: () {
          // Sample marker data
          final marker = MapMarker(
            id: 'marker_$left$top',
            latitude: 21.4272,
            longitude: 92.0058,
            type: 'poi',
            title: 'Point of Interest',
          );
          controller.onMarkerTap(marker);
        },
        child: SizedBox(
          width: 24.w,
          height: 24.h,
          child: Icon(
            Icons.location_on,
            color: ColorHelper.primary,
            size: 24.sp,
          ),
        ),
      ),
    );
  }

  // User location indicator (circle in center)
  Widget _buildUserLocationIndicator() {
    return Positioned(
      left: 92.w,
      top: 201.h,
      child: Container(
        width: 52.w,
        height: 52.h,
        decoration: BoxDecoration(
          color: ColorHelper.primary.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(36.r),
          border: Border.all(color: ColorHelper.primary, width: 1),
        ),
        child: Center(
          child: Container(
            width: 12.w,
            height: 12.h,
            decoration: BoxDecoration(
              color: ColorHelper.primary,
              borderRadius: BorderRadius.circular(37.r),
              border: Border.all(color: ColorHelper.background, width: 1),
            ),
          ),
        ),
      ),
    );
  }

  // My location button
  Widget _buildMyLocationButton(HomeController controller) {
    return Obx(
      () => GestureDetector(
        onTap: controller.onMyLocationTap,
        child: Container(
          width: 32.w,
          height: 32.h,
          decoration: BoxDecoration(
            color: ColorHelper.background,
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 25),
                blurRadius: 4,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Center(
            child:
                controller.isLoadingLocation.value
                    ? SizedBox(
                      width: 16.w,
                      height: 16.h,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: ColorHelper.textSecondary,
                      ),
                    )
                    : Icon(
                      Icons.my_location,
                      size: 20.sp,
                      color: ColorHelper.textSecondary,
                    ),
          ),
        ),
      ),
    );
  }
}
