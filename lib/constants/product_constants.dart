import 'package:flutter/material.dart';

class ProductColors {
  static const pageBackground = Color(0xFFE0E0E0);

  static const containerBackground = Colors.white;
  static const containerBorderColor = Colors.black;

  static const dividerPrimary = Colors.black;
  static const dividerSecondary = Colors.grey;

  // Dropdown styling
  static const dropdownText = Colors.deepPurple;
  static const dropdownUnderline = Colors.deepPurpleAccent;
}

class ProductSpacing {
  // Outer padding around the main container
  static const pagePadding = 50.0;

  // Container border
  static const containerBorderWidth = 2.0;

  // Header/row padding (list)
  static const rowPaddingHorizontal = 12.0;
  static const rowPaddingVertical = 10.0;

  // Divider sizes
  static const dividerHeight = 5.0;
  static const dividerThicknessPrimary = 2.0;
  static const dividerThicknessSecondary = 1.0;

  // Detail view section divider
  static const sectionDividerHeight = 10.0;
  static const sectionDividerThickness = 0.5;

  // Bottom area padding (create button)
  static const bottomAreaPadding = 10.0;

  // Vertical gaps in detail view
  static const gapLarge = 20.0;
  static const gapMedium = 10.0;
}

class ProductTextSize {
  static const detailTitle = 24.0;
}

class ProductSearchFieldSize {
  static const width = 200.0;
  static const height = 40.0;

  static const iconSize = 20.0;
  static const contentPaddingVertical = 10.0;
}

class ProductDropdownStyle {
  static const elevation = 16;
  static const underlineHeight = 2.0;
}

class ProductDatePicker {
  static const firstYear = 2020;
  static const lastYear = 2030;
  static const displayFormat = 'yyyy-MM-dd';
}

class ProductText {
  static const actionSeparator = '|';
}
