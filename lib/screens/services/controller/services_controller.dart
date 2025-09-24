import 'package:chologhuri/screens/services/model/service_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/routes_path.dart';

class ServicesController extends GetxController {
  // Reactive variables
  var searchController = TextEditingController().obs;
  final RxBool isLoading = false.obs;
  final RxString selectedLocation = 'Cox Bazar Highway Road'.obs;
  var selectedService = ''.obs;
  var haveRequest = true.obs;

  // Service items data
  final List<ServiceModel> serviceItems = [
    ServiceModel(
      title: 'Hotel',
      iconPath: 'assets/icons/Hotel.png',
      onTap: () => Get.snackbar('Hotel', 'Hotel service selected'),
    ),
    ServiceModel(
      title: 'Fuel Pump',
      iconPath: 'assets/icons/Gas.png',
      onTap: () => Get.snackbar('Fuel Pump', 'Fuel Pump service selected'),
    ),
    ServiceModel(
      title: 'Workshop',
      iconPath: 'assets/icons/Repair.png',
      onTap: () => Get.snackbar('Workshop', 'Workshop service selected'),
    ),
    ServiceModel(
      title: 'Raker Service',
      iconPath: 'assets/icons/Crane truck.png',
      onTap: () => Get.snackbar('Raker Service', 'Raker Service selected'),
    ),
    ServiceModel(
      title: 'Hospital',
      iconPath: 'assets/icons/Building.png',
      onTap: () => Get.snackbar('Hospital', 'Hospital service selected'),
    ),
    ServiceModel(
      title: 'Ambulance',
      iconPath: 'assets/icons/Alarm.png',
      onTap: () => Get.snackbar('Ambulance', 'Ambulance service selected'),
    ),
  ];

  // Getters
  bool get isLoadingValue => isLoading.value;
  String get selectedLocationValue => selectedLocation.value;

  // Methods
  void onLocationTap() {
    Get.snackbar('Location', 'Location selection feature coming soon');
  }

  void onServiceTap(String serviceName) {
    selectedService.value = serviceName;
    Get.toNamed(RoutesPath.servicesItemScreen);
  }

  var selectedIndex = 0.obs;

  // Service options data
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

// Service Option Model
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
