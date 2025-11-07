import 'package:chologhuri/routes/routes.dart';
import 'package:chologhuri/core/localization/localization_service.dart';
import 'package:chologhuri/core/localization/app_translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize and register LocalizationService globally
  final loc = LocalizationService();
  await loc.init();
  Get.put<LocalizationService>(loc, permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // Use a single ScreenUtilInit and wire GetMaterialApp translations
    return ScreenUtilInit(
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
            // Wire translations and initial locale
            translations: AppTranslations(),
            locale: Locale(Get.find<LocalizationService>().currentLanguage),
            fallbackLocale: const Locale('en'),
            getPages: Routes.routes,
          ),
    );
  }
}
