import 'package:chologhuri/screens/services/model/service_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chologhuri/core/localization/localization_service.dart';
import 'package:chologhuri/core/config/api_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../../components/common_components.dart';
import '../../../helpers/color_helper.dart';
import '../controller/services_controller.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ServicesController());

    return Scaffold(
      backgroundColor: ColorHelper.background,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 24.h),
            _buildLocationHeader(controller),
            SizedBox(height: 30.h),
            Expanded(child: _buildServicesGrid(controller)),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationHeader(ServicesController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Icon(Icons.location_on, color: ColorHelper.primary, size: 24.w),

          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonComponents().commonText(
                  fontSize: 14,
                  textData: 'Your Location',
                  fontWeight: FontWeight.w400,
                  color: ColorHelper.textSecondary,
                ),

                SizedBox(height: 3.h),

                Row(
                  children: [
                    Obx(
                      () => Expanded(
                        child: CommonComponents().commonText(
                          fontSize: 16,
                          textData: controller.selectedLocationValue,
                          fontWeight: FontWeight.w500,
                          color: ColorHelper.textPrimary,
                        ),
                      ),
                    ),

                    SizedBox(width: 8.w),

                    GestureDetector(
                      onTap: controller.onLocationTap,
                      child: Transform.rotate(
                        angle: -1.5708,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: ColorHelper.textPrimary,
                          size: 16.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesGrid(ServicesController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Obx(() {
        if (controller.isLoading.value) {
          // shimmer grid
          return GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 14.w,
              mainAxisSpacing: 14.h,
              childAspectRatio: 1.0,
            ),
            itemCount: 6,
            itemBuilder:
                (context, index) => Shimmer.fromColors(
                  baseColor: ColorHelper.filterChipInactive,
                  highlightColor: ColorHelper.mapBackground,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorHelper.filterChipInactive,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                ),
          );
        }

        return GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 14.w,
            mainAxisSpacing: 14.h,
            childAspectRatio: 1.0,
          ),
          itemCount: controller.serviceItems.length,
          itemBuilder: (context, index) {
            final serviceItem = controller.serviceItems[index];
            return _buildServiceCard(serviceItem, controller);
          },
        );
      }),
    );
  }

  Widget _buildServiceCard(
    ServiceItem serviceItem,
    ServicesController controller,
  ) {
    return GestureDetector(
      onTap: () => controller.onServiceTap(serviceItem),
      child: Container(
        decoration: BoxDecoration(
          color: ColorHelper.mapBackground,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 48.w,
              height: 48.h,
              child: Builder(
                builder: (context) {
                  if (serviceItem.icon.startsWith('http')) {
                    return CachedNetworkImage(
                      imageUrl: serviceItem.icon,
                      fit: BoxFit.contain,
                      placeholder:
                          (_, __) => Image.asset(
                            'assets/icons/Repair.png',
                            fit: BoxFit.contain,
                          ),
                      errorWidget:
                          (_, __, ___) => Image.asset(
                            'assets/icons/Repair.png',
                            fit: BoxFit.contain,
                          ),
                    );
                  }

                  if (serviceItem.icon.startsWith('assets/')) {
                    return Image.asset(
                      serviceItem.icon,
                      fit: BoxFit.contain,
                      errorBuilder:
                          (_, __, ___) => Image.asset(
                            'assets/icons/Repair.png',
                            fit: BoxFit.contain,
                          ),
                    );
                  }

                  final candidate =
                      serviceItem.icon.startsWith('/')
                          ? '${ApiConfig.baseUrl}${serviceItem.icon}'
                          : '${ApiConfig.baseUrl}/${serviceItem.icon}';

                  return CachedNetworkImage(
                    imageUrl: candidate,
                    fit: BoxFit.contain,
                    placeholder:
                        (_, __) => Image.asset(
                          'assets/icons/Repair.png',
                          fit: BoxFit.contain,
                        ),
                    errorWidget:
                        (_, __, ___) => Image.asset(
                          'assets/icons/Repair.png',
                          fit: BoxFit.contain,
                        ),
                  );
                },
              ),
            ),

            SizedBox(height: 8.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Obx(() {
                final lang =
                    Get.find<LocalizationService>().currentLanguageObs.value;
                return CommonComponents().commonText(
                  fontSize: 12,
                  textData: serviceItem.localizedName(lang),
                  fontWeight: FontWeight.w400,
                  color: ColorHelper.textPrimary,
                  textAlign: TextAlign.center,
                  maxLine: 2,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
