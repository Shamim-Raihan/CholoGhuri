import 'package:chologhuri/routes/routes_path.dart' show RoutesPath;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../components/common_components.dart';
import '../../../components/item_card.dart';
import '../../../helpers/color_helper.dart';
import '../../../helpers/space_helper.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.background,
      floatingActionButton: _buildFloatingActionButtons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHotelImage(),
                    SpaceHelper.verticalSpace24,
                    _buildHotelInfo(),
                    SpaceHelper.verticalSpace24,
                    _buildNearbyHotels(),
                    SizedBox(height: 100.h,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: ColorHelper.mapBackground,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: ColorHelper.textPrimary,
                size: 20.w,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: CommonComponents().commonText(
                fontSize: 18,
                textData: 'Hotel Details',
                fontWeight: FontWeight.w600,
                color: ColorHelper.textPrimary,
              ),
            ),
          ),
          SizedBox(width: 40.w), // For symmetry
        ],
      ),
    );
  }

  Widget _buildHotelImage() {
    return Container(
      width: double.infinity,
      height: 250.h,
      // margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(20.r),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
          ), // Replace with actual image
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(20.r),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withOpacity(0.3)],
          ),
        ),
      ),
    );
  }

  Widget _buildHotelInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonComponents().commonText(
            fontSize: 20,
            textData: 'The Cox beach Resort',
            fontWeight: FontWeight.w500,
            color: ColorHelper.textPrimary,
          ),

          SpaceHelper.verticalSpace15,

          CommonComponents().commonText(
            fontSize: 14,
            textData:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.',
            fontWeight: FontWeight.w400,
            color: ColorHelper.textSecondary,
            maxLine: 4,
          ),

          SpaceHelper.verticalSpace24,

          _buildInfoCard(
            icon: Icons.attach_money,
            title: 'Start From BDT 2,671',
            iconColor: ColorHelper.primary,
            isFirst: true,
          ),
          Container(height: 1, color: ColorHelper.black.withValues(alpha: .2)),
          _buildInfoCard(
            icon: Icons.star,
            title: '4.9 (648)',
            iconColor: ColorHelper.primary,
          ),
          Container(height: 1, color: ColorHelper.black.withValues(alpha: .2)),
          _buildInfoCard(
            icon: Icons.phone,
            title: '+880 123 456 789\n+880 123 456 789',
            iconColor: ColorHelper.primary,
          ),
          Container(height: 1, color: ColorHelper.black.withValues(alpha: .2)),
          _buildInfoCard(
            icon: Icons.location_on,
            title: 'Cox Bazar, Chattagram',
            iconColor: ColorHelper.primary,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required Color iconColor,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: ColorHelper.mapBackground,
        borderRadius:
            isFirst == true && isLast == false
                ? BorderRadius.only(
                  topRight: Radius.circular(15.r),
                  topLeft: Radius.circular(15.r),
                )
                : isFirst == false && isLast == true
                ? BorderRadius.only(
                  bottomRight: Radius.circular(15.r),
                  bottomLeft: Radius.circular(15.r),
                )
                : BorderRadius.circular(0.r),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 40.w,
            height: 40.h,
            child: Icon(icon, color: iconColor, size: 20.w),
          ),

          SpaceHelper.horizontalSpace12,

          Expanded(
            child: CommonComponents().commonText(
              fontSize: 16,
              textData: title,
              fontWeight: FontWeight.w500,
              color: ColorHelper.textPrimary,
              maxLine: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNearbyHotels() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonComponents().commonText(
            fontSize: 20,
            textData: 'Nearby Hotels',
            fontWeight: FontWeight.w500,
            color: ColorHelper.textPrimary,
          ),

          SpaceHelper.verticalSpace15,

          SizedBox(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (context, index) => SpaceHelper.verticalSpace10,
              itemBuilder: (context, index) {
                return itemCard();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButtons() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: FloatingActionButton.extended(
              onPressed: () {
                // Handle book now action
                Get.snackbar(
                  'Book Now',
                  'Booking functionality will be implemented',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              backgroundColor: ColorHelper.secondaryLight,
              foregroundColor: ColorHelper.primary,
              // elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              label: CommonComponents().commonText(
                fontSize: 16,
                textData: 'Book Now',
                fontWeight: FontWeight.w600,
                color: ColorHelper.primary,
              ),
            ),
          ),

          SpaceHelper.horizontalSpace15,

          Expanded(
            child: FloatingActionButton.extended(
              onPressed: () {
                // Handle get direction action
                Get.snackbar(
                  'Get Direction',
                  'Navigation functionality will be implemented',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              backgroundColor: ColorHelper.primary,
              foregroundColor: Colors.white,
              // elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              label: CommonComponents().commonText(
                fontSize: 16,
                textData: 'Get Direction',
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }



}
