import 'package:creonit/common/app_colors.dart';
import 'package:flutter/material.dart';

class Style {
  static const TextStyle text1 = TextStyle(
      color: AppColors.primaryBlack, fontSize: 16, fontWeight: FontWeight.w600);
  static const TextStyle text1Red = TextStyle(
      color: AppColors.red, fontSize: 16, fontWeight: FontWeight.w600);
  static const TextStyle text2 = TextStyle(
      color: AppColors.primaryBlack, fontSize: 12, fontWeight: FontWeight.w400);
  static TextStyle textPrice(bool sale) => TextStyle(
      color: sale ? AppColors.red : AppColors.primaryBlack,
      fontSize: 16,
      fontWeight: FontWeight.bold);
  static const TextStyle textPriceCrossed = TextStyle(
      color: AppColors.grayColor,
      decoration: TextDecoration.lineThrough,
      fontSize: 16,
      fontWeight: FontWeight.normal);
  static const TextStyle textProductCompany = TextStyle(
      color: AppColors.grayColor, fontSize: 10, fontWeight: FontWeight.w400);
  static const TextStyle textProductTitle = TextStyle(
      color: AppColors.primaryBlack, fontSize: 12, fontWeight: FontWeight.w400);
  static const TextStyle textProductFinished = TextStyle(
      color: AppColors.red, fontSize: 10, fontWeight: FontWeight.w600);
  static const TextStyle textBottomNavBarUnselected =
      TextStyle(color: AppColors.grayColorTransparent, fontSize: 10);
  static const TextStyle textBottomNavBarSelected =
      TextStyle(color: AppColors.primaryBlack, fontSize: 10);
}
