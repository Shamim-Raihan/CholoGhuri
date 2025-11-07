// auth token resolved within ServiceListService now
import 'package:chologhuri/screens/services/model/service_item.dart';
import 'package:chologhuri/screens/services/service_list_service.dart';
import 'package:chologhuri/core/localization/localization_service.dart';
import 'package:chologhuri/core/config/api_config.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxInt selectedFilterIndex = 0.obs;
  final RxList<ServiceItem> filterOptions = <ServiceItem>[].obs;

  final LocalizationService localizationService =
      Get.find<LocalizationService>();

  final RxString currentLocation = 'Cox Bazar Highway Road'.obs;
  final RxString locationTitle = 'location'.tr.obs;

  final RxList<MapMarker> mapMarkers = <MapMarker>[].obs;
  final RxBool isLoadingLocation = false.obs;

  final RxBool isLoadingServices = false.obs;

  @override
  void onInit() async {
    super.onInit();
    _initializeMapMarkers();
    // auth info no longer required here; service resolves token internally

    await localizationService.init();
    await _loadServiceList();
  }

  Future<void> _loadServiceList() async {
    isLoadingServices.value = true;
    final service = ServiceListService();
    final slug = ApiConfig.setToken;

    final list = await service.fetchServices(slug);
    if (list.isNotEmpty) {
      final allItem = ServiceItem(
        id: 0,
        nameBn: 'সব',
        nameEn: 'All',
        icon: '',
        order: '0',
        status: '1',
      );
      filterOptions.assignAll([allItem, ...list]);
    }
    isLoadingServices.value = false;
  }

  void selectFilter(int index) {
    selectedFilterIndex.value = index;
    _filterMarkers();
  }

  ServiceItem get selectedFilter =>
      filterOptions.isNotEmpty
          ? filterOptions[selectedFilterIndex.value]
          : ServiceItem(
            id: 0,
            nameBn: 'সব',
            nameEn: 'All',
            icon: '',
            order: '0',
            status: '1',
          );

  String localizedFilterLabel(ServiceItem item) =>
      item.localizedName(localizationService.currentLanguage);

  void onLocationTap() {
    Get.snackbar(
      'location'.tr,
      'location_selection_will_be_implemented'.tr,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> changeLanguage(String langCode) async {
    await localizationService.changeLanguage(langCode);
  }

  void onMyLocationTap() {
    isLoadingLocation.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isLoadingLocation.value = false;
      Get.snackbar(
        'location'.tr,
        'current_location_updated'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    });
  }

  void _initializeMapMarkers() {
    mapMarkers.addAll([
      MapMarker(
        id: '1',
        latitude: 21.4272,
        longitude: 92.0058,
        type: 'hotel',
        title: 'Hotel Sea Palace',
      ),
      MapMarker(
        id: '2',
        latitude: 21.4290,
        longitude: 92.0070,
        type: 'fuel_pump',
        title: 'Fuel Station',
      ),
      MapMarker(
        id: '3',
        latitude: 21.4250,
        longitude: 92.0045,
        type: 'workshop',
        title: 'Auto Workshop',
      ),
      MapMarker(
        id: '4',
        latitude: 21.4280,
        longitude: 92.0080,
        type: 'hospital',
        title: 'Cox Bazar Hospital',
      ),
      MapMarker(
        id: '5',
        latitude: 21.4260,
        longitude: 92.0065,
        type: 'raker_service',
        title: 'Raker Service Center',
      ),
    ]);
  }

  void _filterMarkers() {
    final selectedType = _getFilterType(selectedFilter);
    if (selectedType == 'all') {
    } else {}
  }

  String _getFilterType(ServiceItem item) {
    final name = item.nameEn.toLowerCase();
    switch (name) {
      case 'hotel':
        return 'hotel';
      case 'fuel pump':
        return 'fuel_pump';
      case 'workshop':
        return 'workshop';
      case 'raker service':
        return 'raker_service';
      case 'hospital':
        return 'hospital';
      case 'ambulance':
        return 'ambulance';
      case 'all':
        return 'all';
      default:
        return 'all';
    }
  }

  void onMarkerTap(MapMarker marker) {
    Get.snackbar(
      marker.title,
      'Marker details will be shown here',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

class MapMarker {
  final String id;
  final double latitude;
  final double longitude;
  final String type;
  final String title;

  MapMarker({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.type,
    required this.title,
  });
}
