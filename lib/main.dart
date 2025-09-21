import 'package:chologhuri/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder:
          (context, child) => ScreenUtilInit(
            designSize: const Size(360, 800),
            minTextAdapt: true,
            splitScreenMode: true,
            builder:
                (context, child) => GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Cholor Guri',
                  theme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
                    useMaterial3: true,
                  ),
                  getPages: Routes.routes,
                ),
          ),
    );
  }
}
