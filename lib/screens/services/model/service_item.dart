import 'package:chologhuri/core/config/api_config.dart';

class ServiceItem {
  final int id;
  final String nameBn;
  final String nameEn;
  final String icon;
  final String order;
  final String status;

  ServiceItem({
    required this.id,
    required this.nameBn,
    required this.nameEn,
    required this.icon,
    required this.order,
    required this.status,
  });

  factory ServiceItem.fromJson(Map<String, dynamic> json) {
    final rawIcon = (json['icon'] ?? '') as String;
    // Normalize icon paths coming from API:
    // - If it's an absolute URL (http/https) leave as-is.
    // - If it's an asset path (starts with 'assets/'), leave as-is.
    // - If it starts with '/', prefix ApiConfig.baseUrl (e.g. '/storage/...').
    // - If it's a bare filename or relative path (e.g. 'icon-1.png' or 'service/icon-1.png'), prefix with baseUrl + '/'.
    String icon;
    if (rawIcon.startsWith('http')) {
      icon = rawIcon;
    } else if (rawIcon.startsWith('assets/')) {
      icon = rawIcon;
    } else if (rawIcon.startsWith('/')) {
      // e.g. '/storage/app/public/service-icon/icon-4.png'
      icon = '${ApiConfig.baseUrl}$rawIcon';
    } else if (rawIcon.isEmpty) {
      icon = '';
    } else if (rawIcon.contains('storage')) {
      // covers 'storage/app/public/...'(without leading slash) or other variants
      final path = rawIcon.startsWith('/') ? rawIcon : '/$rawIcon';
      icon = '${ApiConfig.baseUrl}$path';
    } else if (!rawIcon.contains('/')) {
      // bare filename like 'icon-1.png' -> map to storage path used by backend
      icon = '${ApiConfig.baseUrl}/storage/app/public/service-icon/$rawIcon';
    } else {
      // any other relative path, prefix with baseUrl
      icon = '${ApiConfig.baseUrl}/$rawIcon';
    }
    return ServiceItem(
      id: json['id'] as int,
      nameBn: (json['name'] ?? '') as String,
      nameEn: (json['name_en'] ?? '') as String,
      icon: icon,
      order: (json['order'] ?? '') as String,
      status: (json['status'] ?? '') as String,
    );
  }

  String localizedName(String langCode) {
    if (langCode == 'bn') return nameBn;
    return nameEn.isNotEmpty ? nameEn : nameBn;
  }
}
