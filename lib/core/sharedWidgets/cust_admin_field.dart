import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget custom_admin_field(TextEditingController controller,
    String label, {
      int maxLines = 1,
      String? Function(String?)? validator,
    }) {
  return TextFormField(
    controller: controller,
    maxLines: maxLines,
    validator: validator,
    style: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        fontSize: 14,
        color: Colors.black54,
      ),
      filled: true,
      fillColor: Colors.grey.shade50,

      /// ----- Borders -----
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
          width: 1.2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.blue.shade600,
          width: 1.6,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.3,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),

      /// ----- Padding -----
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
    ),
  );
}
