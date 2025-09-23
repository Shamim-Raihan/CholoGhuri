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
}
