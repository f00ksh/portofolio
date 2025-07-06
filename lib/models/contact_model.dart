import 'package:flutter/material.dart';

class ContactModel {
  final String label;
  final IconData icon;
  final String value;
  final VoidCallback? onTap;

  const ContactModel({
    required this.label,
    required this.icon,
    required this.value,
    this.onTap,
  });
}
