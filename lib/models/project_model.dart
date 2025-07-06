import 'package:flutter/material.dart';

class ProjectModel {
  final String title;
  final String tech;
  final IconData icon;
  final VoidCallback? onTap;

  const ProjectModel({
    required this.title,
    required this.tech,
    required this.icon,
    this.onTap,
  });
}
