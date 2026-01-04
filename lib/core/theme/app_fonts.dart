import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Helper class để quản lý fonts của ứng dụng
class AppFonts {
  // Inter font - font chính cho text thông thường
  static TextStyle inter({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // BBH Bartle font - font cho heading hoặc special text
  // Note: Nếu BBH Bartle không có trong Google Fonts, 
  // có thể cần tải font file riêng hoặc dùng font tương tự như Bebas Neue
  static TextStyle bbhBartle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) {
    // Tạm thời dùng Bebas Neue, có thể thay thế bằng font file riêng nếu cần
    return GoogleFonts.bebasNeue(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}

