import 'package:flutter/material.dart';
import 'package:softtouch/services/themes/theme_service.dart';

class AdvancedNavBar extends StatefulWidget {
  final int currentIndex;
  final List<AdvancedNavBarItem> items;
  final ValueChanged<int> onTap;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final double height;
  final double iconSize;
  final double animationDuration;

  const AdvancedNavBar({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.height = 70,
    this.iconSize = 24,
    this.animationDuration = 300,
  });

  @override
  State<AdvancedNavBar> createState() => _AdvancedNavBarState();
}

class _AdvancedNavBarState extends State<AdvancedNavBar> {
  @override
  Widget build(BuildContext context) {
    final theme = LamsatThemeService.currentColorScheme.primaryColor;
    final selectedColor = widget.selectedColor ?? LamsatThemeService.currentColorScheme.primaryColor;
    final unselectedColor = widget.unselectedColor ?? LamsatThemeService.currentColorScheme.primaryColor[100];
    final backgroundColor = widget.backgroundColor ?? LamsatThemeService.currentColorScheme.primaryColor;

    return Container(
      height: widget.height + MediaQuery.of(context).padding.bottom,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Row(
          children: widget.items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isSelected = index == widget.currentIndex;

            return Expanded(
              child: GestureDetector(
                onTap: () => widget.onTap(index),
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon with animation
                      AnimatedContainer(
                        duration: Duration(milliseconds: widget.animationDuration ~/ 2),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: isSelected ? selectedColor.withOpacity(0.1) : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Icon(
                              isSelected ? item.activeIcon ?? item.icon : item.icon,
                              size: widget.iconSize,
                              color: isSelected ? selectedColor : unselectedColor,
                            ),
                            if (item.badgeCount != null && item.badgeCount! > 0)
                              Positioned(
                                right: -4,
                                top: -4,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 16,
                                    minHeight: 16,
                                  ),
                                  child: Text(
                                    item.badgeCount.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Label with animation
                      AnimatedDefaultTextStyle(
                        duration: Duration(milliseconds: widget.animationDuration ~/ 2),
                        style: TextStyle(
                          fontSize: isSelected ? 12 : 11,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? selectedColor : unselectedColor,
                        ),
                        child: Text(
                          item.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class AdvancedNavBarItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;
  final int? badgeCount;

  AdvancedNavBarItem({
    required this.icon,
    required this.label,
    this.activeIcon,
    this.badgeCount,
  });
}