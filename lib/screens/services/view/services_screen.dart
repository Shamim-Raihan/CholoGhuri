import 'package:chologhuri/screens/services/model/service_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../components/common_components.dart';
import '../../../helpers/color_helper.dart';
import '../../../helpers/space_helper.dart';
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
            SpaceHelper.verticalSpace24,
            _buildLocationHeader(controller),
            SpaceHelper.verticalSpace30,
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

          SpaceHelper.horizontalSpace12,

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

                SpaceHelper.verticalSpace3,

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

                    SpaceHelper.horizontalSpace8,

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
      child: GridView.builder(
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
      ),
    );
  }

  Widget _buildServiceCard(
    ServiceModel serviceItem,
    ServicesController controller,
  ) {
    return GestureDetector(
      onTap: () => controller.onServiceTap(serviceItem.title),
      child: Container(
        decoration: BoxDecoration(
          color: ColorHelper.mapBackground,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(serviceItem.iconPath),
                  fit: BoxFit.contain,
                ),
              ),
            ),

            SpaceHelper.verticalSpace8,

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: CommonComponents().commonText(
                fontSize: 12,
                textData: serviceItem.title,
                fontWeight: FontWeight.w400,
                color: ColorHelper.textPrimary,
                textAlign: TextAlign.center,
                maxLine: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
