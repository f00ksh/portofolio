import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio_web/constants/app_colors.dart';
import 'package:portfolio_web/models/tech_stack.dart';
import 'package:portfolio_web/utils/responsive_sizing.dart';
import 'package:portfolio_web/utils/responsive_utils.dart';

class BentoSkillsSection extends StatelessWidget {
  const BentoSkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.skillsGridBg,
        border: Border.fromBorderSide(
          BorderSide(color: Colors.black, width: 3),
        ),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: EdgeInsets.only(
              top: ResponsiveSize.vh(context, 8),
              bottom: ResponsiveSize.vh(context, 4),
            ),
            child: Text(
              "Technology & Skills",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ResponsiveSize.text(
                  context,
                  mobile: 36,
                  tablet: 64,
                  desktop: 80,
                ),
                fontWeight: FontWeight.w900,
                color: Colors.black,
                letterSpacing: 1.5,
                height: 1.2,
              ),
            ),
          ),

          // Skills Grid
          Expanded(
            child: Padding(
              padding: ResponsiveSize.padding(
                context,
                horizontal: isMobile ? 4 : 8,
                vertical: 4,
              ),
              child: isMobile
                  ? _buildMobileGrid(context)
                  : _buildDesktopGrid(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileGrid(BuildContext context) {
    // 2-column grid for mobile
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.0,
      ),
      itemCount: techStackList.length,
      itemBuilder: (context, index) {
        return _SkillCard(
          tech: techStackList[index],
          delay: index * 100,
        );
      },
    );
  }

  Widget _buildDesktopGrid(BuildContext context) {
    final isTablet = Responsive.isTablet(context) || Responsive.isTabletLarge(context);
    final columns = isTablet ? 4 : 5;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.0,
      ),
      itemCount: techStackList.length,
      itemBuilder: (context, index) {
        return _SkillCard(
          tech: techStackList[index],
          delay: index * 100,
        );
      },
    );
  }
}

class _SkillCard extends StatefulWidget {
  final TechStack tech;
  final int delay;

  const _SkillCard({
    required this.tech,
    required this.delay,
  });

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..translate(
            _isHovered ? -4.0 : 0.0,
            _isHovered ? -4.0 : 0.0,
          ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black, width: 3),
          boxShadow: [
            BoxShadow(
              offset: Offset(_isHovered ? 8 : 4, _isHovered ? 8 : 4),
              color: Colors.black,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SVG Icon
            SvgPicture.asset(
              widget.tech.svgPath,
              width: ResponsiveSize.vhSize(
                context,
                mobile: 40,
                tablet: 50,
                desktop: 60,
              ),
              height: ResponsiveSize.vhSize(
                context,
                mobile: 40,
                tablet: 50,
                desktop: 60,
              ),
            ),
            SizedBox(height: ResponsiveSize.space(context, 2)),
            // Tech Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                widget.tech.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: ResponsiveSize.text(
                    context,
                    mobile: 12,
                    tablet: 14,
                    desktop: 16,
                  ),
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      )
          .animate()
          .fadeIn(
            duration: 600.ms,
            delay: widget.delay.ms,
            curve: Curves.easeOut,
          )
          .slideY(
            begin: 0.3,
            end: 0,
            duration: 600.ms,
            delay: widget.delay.ms,
            curve: Curves.easeOutCubic,
          )
          .scale(
            begin: const Offset(0.8, 0.8),
            end: const Offset(1.0, 1.0),
            duration: 600.ms,
            delay: widget.delay.ms,
            curve: Curves.easeOutBack,
          ),
    );
  }
}
