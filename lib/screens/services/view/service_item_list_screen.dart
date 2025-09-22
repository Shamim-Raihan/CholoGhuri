import 'package:chologhuri/components/common_appbar.dart';
import 'package:chologhuri/components/common_components.dart';
import 'package:chologhuri/screens/services/controller/services_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../helpers/color_helper.dart';
import '../../../helpers/space_helper.dart';

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
                    itemBuilder: (context, index) => itemCard(),
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

  Widget itemCard() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ColorHelper.mapBackground,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SpaceHelper.horizontalSpace10,
          // Hotel Details Container
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Hotel Name Container
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    'The Cox beach Resort',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),

                // Price Container
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'START FROM ',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: 'BDT 2,671',
                          style: TextStyle(
                            color: ColorHelper.lightBlue,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Row(
                  children: [
                    const Text(
                      '3.8',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 6),
                      child: const Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 16,
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 4),
                      child: const Text(
                        '(648)',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Right Padding Container
          Container(width: 16),
        ],
      ),
    );
  }
}
