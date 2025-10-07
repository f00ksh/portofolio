import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_web/constants/app_text_styles.dart';
import 'package:portfolio_web/providers/scrolling_providers.dart';
import 'package:portfolio_web/utils/responsive_utils.dart';
import 'package:portfolio_web/utils/responsive_sizing.dart';

class PortfolioNavigation extends ConsumerStatefulWidget {
  const PortfolioNavigation({super.key, required this.scrollParams});

  final ({int sectionCount, double screenHeight}) scrollParams;

  @override
  ConsumerState<PortfolioNavigation> createState() => _PortfolioNavigationState();
}

class _PortfolioNavigationState extends ConsumerState<PortfolioNavigation> {
  bool _isMobileMenuOpen = false;

  static const List<String> _navItems = [
    'Home',
    'About',
    'Skills',
    'Award',
    'Projects',
    'Contact',
  ];

  @override
  Widget build(BuildContext context) {
    final currentSection = ref.watch(
      scrollControllerNotifierProvider(
        widget.scrollParams,
      ).select((s) => s.currentSection),
    );
    final isVisible = ref.watch(
      scrollControllerNotifierProvider(
        widget.scrollParams,
      ).select((s) => s.isNavigationVisible),
    );

    final isMobile = Responsive.isMobile(context);

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Container(
          height: isMobile ? 70 : 100,
          alignment: Alignment.center,
          padding: ResponsiveSize.padding(context, horizontal: 4),
          child: isMobile
              ? _buildMobileNav(context, currentSection, isVisible)
              : _buildDesktopNav(context, currentSection, isVisible),
        ),
      ),
    );
  }

  /// Desktop & Tablet navigation - horizontal
  Widget _buildDesktopNav(BuildContext context, int currentSection, bool isVisible) {
    final isTablet = Responsive.isTablet(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 6 : 8,
        vertical: isTablet ? 6 : 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < _navItems.length; i++)
            _buildNavItem(
              _navItems[i],
              i,
              currentSection,
              context,
              isCompact: isTablet,
            ),
          if (!isTablet)
            Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Portfolio 🔒',
                style: AppTextStyles.caption(context).copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    )
        .animate(target: isVisible ? 1 : 0)
        .fadeIn(duration: 300.ms, curve: Curves.easeOutCubic)
        .slideY(
          begin: -0.5,
          end: 0,
          duration: 400.ms,
          curve: Curves.easeOutBack,
        )
        .scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1.0, 1.0),
          duration: 350.ms,
          curve: Curves.easeOutCubic,
        );
  }

  /// Mobile navigation - hamburger menu
  Widget _buildMobileNav(BuildContext context, int currentSection, bool isVisible) {
    return Stack(
      children: [
        // Hamburger button
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isMobileMenuOpen = !_isMobileMenuOpen;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                _isMobileMenuOpen ? Icons.close : Icons.menu,
                size: 28,
                color: Colors.black,
              ),
            ),
          )
              .animate(target: isVisible ? 1 : 0)
              .fadeIn(duration: 300.ms)
              .slideY(begin: -0.5, end: 0, duration: 400.ms),
        ),

        // Mobile menu drawer
        if (_isMobileMenuOpen)
          Positioned(
            top: 60,
            right: 0,
            child: Container(
              width: 200,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < _navItems.length; i++)
                    _buildMobileMenuItem(
                      _navItems[i],
                      i,
                      currentSection,
                      context,
                    ),
                ],
              ),
            )
                .animate()
                .fadeIn(duration: 200.ms)
                .slideY(begin: -0.3, end: 0, duration: 300.ms, curve: Curves.easeOut)
                .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),
          ),
      ],
    );
  }

  Widget _buildNavItem(
    String title,
    int index,
    int currentSection,
    BuildContext context, {
    bool isCompact = false,
  }) {
    final isActive = currentSection == index;
    final bgColor = isActive ? Colors.orange : Colors.transparent;

    return GestureDetector(
      onTap: () {
        ref
            .read(scrollControllerNotifierProvider(widget.scrollParams).notifier)
            .scrollToSection(index, context);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(horizontal: isCompact ? 2 : 4),
        padding: EdgeInsets.symmetric(
          horizontal: isCompact ? 10 : 14,
          vertical: isCompact ? 6 : 8,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: AppTextStyles.navItem(context).copyWith(
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      )
          .animate(target: isActive ? 1 : 0)
          .scale(
            begin: const Offset(1.0, 1.0),
            end: const Offset(1.05, 1.05),
            duration: 200.ms,
            curve: Curves.easeOutCubic,
          ),
    );
  }

  Widget _buildMobileMenuItem(
    String title,
    int index,
    int currentSection,
    BuildContext context,
  ) {
    final isActive = currentSection == index;

    return GestureDetector(
      onTap: () {
        ref
            .read(scrollControllerNotifierProvider(widget.scrollParams).notifier)
            .scrollToSection(index, context);
        setState(() {
          _isMobileMenuOpen = false;
        });
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? Colors.orange : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: AppTextStyles.navItem(context).copyWith(
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
