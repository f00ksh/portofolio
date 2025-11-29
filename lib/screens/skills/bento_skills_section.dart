import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        color: Color(0xffffcb46),
        border: Border.fromBorderSide(
          BorderSide(color: Colors.black, width: 3),
        ),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: EdgeInsets.only(
              top: ResponsiveSize.vh(context, 4),
              bottom: ResponsiveSize.vh(context, 2),
            ),
            child: Text(
              "Technology & Skills",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ResponsiveSize.text(
                  context,
                  mobile: 28,
                  tablet: 48,
                  desktop: 64,
                ),
                fontWeight: FontWeight.w900,
                color: Colors.black,
                letterSpacing: 1.5,
                height: 1.2,
              ),
            ),
          ),

          // Skills Grid - No Scroll
          Expanded(
            child: Padding(
              padding: ResponsiveSize.padding(
                context,
                horizontal: isMobile ? 16 : 32,
                vertical: 5,
              ),
              child: isMobile
                  ? _buildMobileGrid(context)
                  : _buildDesktopGrid(context),
            ),
          ),
          SizedBox(height: ResponsiveSize.vh(context, 2)),
        ],
      ),
    );
  }

  Widget _buildMobileGrid(BuildContext context) {
    final columns = 3;
    final rows = (techStackList.length / columns).ceil();

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth =
            (constraints.maxWidth - (12 * (columns - 1))) / columns;
        final itemHeight = (constraints.maxHeight - (12 * (rows - 1))) / rows;

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(
            techStackList.length,
            (index) => SizedBox(
              width: itemWidth,
              height: itemHeight,
              child: _SkillCard(tech: techStackList[index], delay: index * 100),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopGrid(BuildContext context) {
    final isTablet =
        Responsive.isTablet(context) || Responsive.isTabletLarge(context);
    final columns = isTablet ? 5 : 6;
    final rows = (techStackList.length / columns).ceil();

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth =
            (constraints.maxWidth - (16 * (columns - 1))) / columns;
        final itemHeight = (constraints.maxHeight - (16 * (rows - 1))) / rows;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: List.generate(
            techStackList.length,
            (index) => SizedBox(
              width: itemWidth,
              height: itemHeight,
              child: _SkillCard(tech: techStackList[index], delay: index * 100),
            ),
          ),
        );
      },
    );
  }
}

class _SkillCard extends StatefulWidget {
  final TechStack tech;
  final int delay;

  const _SkillCard({required this.tech, required this.delay});

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
      child:
          AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                transform: Matrix4.identity()
                  ..translate(_isHovered ? -4.0 : 0.0, _isHovered ? -4.0 : 0.0),
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
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Calculate icon size based on available space
                    final iconSize = constraints.maxHeight * 0.5;
                    final fontSize = constraints.maxHeight * 0.12;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SVG Icon
                        SvgPicture.asset(
                          widget.tech.svgPath,
                          width: iconSize.clamp(30, 60),
                          height: iconSize.clamp(30, 60),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.05),
                        // Tech Name
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            widget.tech.name,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: fontSize.clamp(10, 16),
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
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
