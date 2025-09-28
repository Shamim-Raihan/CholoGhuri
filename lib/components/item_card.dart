import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helpers/color_helper.dart';
import '../helpers/space_helper.dart';

Widget itemCard({required String id, required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 100,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ColorHelper.mapBackground,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          Hero(
            tag: 'hotel_image_$id',
            child: Container(
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
                      color: ColorHelper.black,
                    ),
                  ),
                ),

                // Price Container
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'START FROM ',
                          style: TextStyle(
                            color: ColorHelper.textSecondary.withValues(
                              alpha: .5,
                            ),
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
                        color: ColorHelper.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 6),
                      child: const Icon(
                        Icons.star,
                        color: ColorHelper.star,
                        size: 16,
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 4),
                      child: Text(
                        '(648)',
                        style: TextStyle(
                          color: ColorHelper.textSecondary.withValues(
                            alpha: .5,
                          ),
                          fontSize: 12,
                        ),
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
    ),
  );
}
