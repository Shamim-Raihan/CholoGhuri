// ...existing imports...
import 'package:chologhuri/screens/services/model/service_item.dart';
import 'package:chologhuri/screens/services/service_list_service.dart';
import 'package:chologhuri/core/config/api_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/routes_path.dart';

class ServicesController extends GetxController {
  var searchController = TextEditingController().obs;
  final RxBool isLoading = false.obs;
  final RxString selectedLocation = 'Cox Bazar Highway Road'.obs;
  var selectedService = ''.obs;
  var haveRequest = true.obs;
  final RxList<ServiceItem> serviceItems = <ServiceItem>[].obs;
  // auth storage is no longer used here; service fetch resolves token internally

  bool get isLoadingValue => isLoading.value;
  String get selectedLocationValue => selectedLocation.value;

  void onLocationTap() {
    Get.snackbar('Location', 'Location selection feature coming soon');
  }

  @override
  void onInit() async {
    super.onInit();
    await _loadServiceItems();
  }

  Future<void> _loadServiceItems() async {
    isLoading.value = true;
    final service = ServiceListService();
    final slug = ApiConfig.setToken;
    final list = await service.fetchServices(slug);
    serviceItems.assignAll(list);
    isLoading.value = false;
  }

  void onServiceTap(ServiceItem item) {
    selectedService.value = item.localizedName('en');
    Get.toNamed(RoutesPath.servicesItemScreen);
  }

  var selectedIndex = 0.obs;

  final List<ServiceOption> serviceOptions = [
    ServiceOption(
      icon: Icons.motorcycle,
      title: 'Bike Tow',
      time: '15 min away',
      price: 'BDT 350',
    ),
    ServiceOption(
      icon: Icons.directions_car,
      title: 'Light Vehicle Tow',
      time: '27 min away',
      price: 'BDT 1,200',
    ),
    ServiceOption(
      icon: Icons.local_shipping,
      title: 'Heavy Vehicle Tow',
      time: '10 min away',
      price: 'BDT 3,400',
    ),
    ServiceOption(
      icon: Icons.local_shipping,
      title: 'Heavy Vehicle Tow',
      time: '10 min away',
      price: 'BDT 3,400',
    ),
    ServiceOption(
      icon: Icons.local_shipping,
      title: 'Heavy Vehicle Tow',
      time: '10 min away',
      price: 'BDT 3,400',
    ),
    ServiceOption(
      icon: Icons.local_shipping,
      title: 'Heavy Vehicle Tow',
      time: '10 min away',
      price: 'BDT 3,400',
    ),
    ServiceOption(
      icon: Icons.local_shipping,
      title: 'Heavy Vehicle Tow',
      time: '10 min away',
      price: 'BDT 3,400',
    ),
    ServiceOption(
      icon: Icons.local_shipping,
      title: 'Heavy Vehicle Tow',
      time: '10 min away',
      price: 'BDT 3,400',
    ),
  ];
}

class ServiceOption {
  final IconData icon;
  final String title;
  final String time;
  final String price;

  ServiceOption({
    required this.icon,
    required this.title,
    required this.time,
    required this.price,
  });
}
