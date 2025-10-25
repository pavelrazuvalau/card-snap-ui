/// 🔶 Cupertino Card Strategy
///
/// Creates iOS-style cards.
/// Similar to iOS Card component.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'card_strategy_interface.dart';

/// 🔶 Cupertino Card Strategy
///
/// Creates iOS-style cards.
class CupertinoCardStrategy implements CardStrategy {
  @override
  Widget createCard({
    required Widget child,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Color? color,
    double? elevation,
    ShapeBorder? shape,
  }) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color ?? CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
