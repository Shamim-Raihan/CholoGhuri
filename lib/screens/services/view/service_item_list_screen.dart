import 'package:chologhuri/components/common_appbar.dart';
import 'package:chologhuri/components/common_components.dart';
import 'package:chologhuri/screens/services/controller/services_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../components/item_card.dart';
import '../../../helpers/color_helper.dart';
import '../../../helpers/space_helper.dart';
import '../../../routes/routes_path.dart';

class ServiceItemListScreen extends StatelessWidget {
  ServiceItemListScreen({super.key});

  final ServicesController controller = Get.find<ServicesController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: ColorHelper.background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SpaceHelper.verticalSpace24,
                Obx(
                  () => appbar(
                    onPrefixTap: () {},
                    onSuffixTap: () {},
                    title: controller.selectedService.value,
                    suffixIcon: Icons.filter_list_rounded,
                    prefixIcon: Icons.arrow_back_ios,
                  ),
                ),
                SpaceHelper.verticalSpace30,
                CommonComponents().commonTextField(
                  controller: controller.searchController.value,
                  labelText: 'Search ${controller.selectedService}',
                  prefixIcon: Icons.search,
                ),
                SpaceHelper.verticalSpace20,
                Expanded(
                  child: ListView.separated(
                    itemBuilder:
                        (context, index) => itemCard(
                          id: index.toString(),
                          onTap: () {
                            if (controller.haveRequest.value) {
                              _showServiceSelectionBottomSheet(context);
                            } else {
                              Get.toNamed(
                                RoutesPath.itemDetailsScreen,
                                arguments: index.toString(),
                              );
                            }
                          },
                        ),
                    separatorBuilder:
                        (context, index) => SpaceHelper.verticalSpace10,
                    itemCount: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showServiceSelectionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setState) => Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  decoration: BoxDecoration(
                    color: ColorHelper.background,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Handle bar
                      Container(
                        margin: EdgeInsets.only(top: 12.h),
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            children: [
                              SpaceHelper.verticalSpace20,

                              // Service options list
                              Expanded(
                                child: ListView.separated(
                                  itemCount: controller.serviceOptions.length,
                                  separatorBuilder:
                                      (context, index) =>
                                          SpaceHelper.verticalSpace10,
                                  itemBuilder: (context, index) {
                                    final option =
                                        controller.serviceOptions[index];
                                    return _buildServiceOption(option, (
                                      selectedOption,
                                    ) {
                                      controller.selectedIndex.value = index;
                                    }, index);
                                  },
                                ),
                              ),

                              SpaceHelper.verticalSpace20,

                              // Send Request button
                              SizedBox(
                                width: double.infinity,
                                height: 50.h,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF4A47A3),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                  ),
                                  child: Text(
                                    'Send Request',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),

                              SpaceHelper.verticalSpace20,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          ),
    );
  }

  Widget _buildServiceOption(
    ServiceOption option,
    Function(ServiceOption) onTap,
    int index,
  ) {
    return GestureDetector(
      onTap: () => onTap(option),
      child: Obx(
        () => Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: ColorHelper.mapBackground,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color:
                  index == controller.selectedIndex.value
                      ? const Color(0xFF4A47A3)
                      : Colors.grey.shade50,
              width: 1
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),

                child: Icon(
                  option.icon,
                  color: ColorHelper.primary,
                  size: 24.sp,
                ),
              ),
              SpaceHelper.horizontalSpace15,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SpaceHelper.verticalSpace4,
                    Text(
                      option.time,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                option.price,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF4A47A3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
