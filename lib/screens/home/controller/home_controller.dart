import 'package:get/get.dart';

class HomeController extends GetxController {
  // Filter state
  final RxInt selectedFilterIndex = 0.obs;
  final RxList<String> filterOptions =
      <String>[
        'All',
        'Hotel',
        'Fuel Pump',
        'Workshop',
        'Raker Service',
        'Hospital',
        'Ambulance',
      ].obs;

  // Location state
  final RxString currentLocation = 'Cox Bazar Highway Road'.obs;
  final RxString locationTitle = 'Your Location'.obs;

  // Map state
  final RxList<MapMarker> mapMarkers = <MapMarker>[].obs;
  final RxBool isLoadingLocation = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeMapMarkers();
  }

  // Filter methods
  void selectFilter(int index) {
    selectedFilterIndex.value = index;
    _filterMarkers();
  }

  String get selectedFilter => filterOptions[selectedFilterIndex.value];

  void onLocationTap() {
    Get.snackbar(
      'Location',
      'Location selection will be implemented here',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void onMyLocationTap() {
    isLoadingLocation.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isLoadingLocation.value = false;
      Get.snackbar(
        'Location',
        'Current location updated',
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

  String _getFilterType(String filter) {
    switch (filter.toLowerCase()) {
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

// Model class for map markers
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
