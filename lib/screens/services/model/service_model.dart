import 'package:flutter/material.dart';

class ServiceModel {
  final String title;
  final String iconPath;
  final VoidCallback onTap;

  ServiceModel({
    required this.title,
    required this.iconPath,
    required this.onTap,
  });
}
