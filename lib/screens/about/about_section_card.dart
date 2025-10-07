import 'package:flutter/material.dart';
import 'package:portfolio_web/constants/app_text_styles.dart';
import 'package:portfolio_web/screens/about/animated_text.dart';
import 'package:portfolio_web/screens/about/data.dart';
import 'package:portfolio_web/screens/about/experince_table.dart';
import 'package:portfolio_web/screens/about/rive_animation.dart';
import 'package:portfolio_web/theme/responsive_theme.dart';
import 'package:portfolio_web/utils/responsive_sizing.dart';
import 'package:portfolio_web/utils/responsive_utils.dart';

class ExperienceScreen extends StatelessWidget {
  const ExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 3),
        color: Colors.white,
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: ResponsiveSize.padding(context, top: 6, horizontal: 4),
            child: AnimatedText(
              text: 'EXPERIENCE',
              fontSize: ResponsiveSize.text(
                context,
                mobile: 40,
                tablet: 72,
                desktop: 100,
              ),
              fontWeight: FontWeight.w900,
              color: Colors.black,
              letterSpacing: 1.2,
              duration: const Duration(seconds: 30),
              strokeWidth: 0.5,
            ),
          ),

          // Main content
          Padding(
            padding: ResponsiveSize.padding(context, all: 5),
            child: _buildMainContent(context),
          ),

          // Divider
          Container(
            width: double.infinity,
            height: 2,
            color: Colors.black,
            margin: ResponsiveSize.margin(context, top: 5),
          ),

          // Experience table
          Expanded(
            child: Container(
              width: double.infinity,
              color: const Color(0xFF57ef97),
              child: Padding(
                padding: ResponsiveTheme.getResponsiveHorizontalPadding(
                  context,
                  scale: Responsive.isDesktop(context) ? 1.5 : 1.0,
                ),
                child: ExperienceTable(experiences: experiences),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet =
        Responsive.isTablet(context) || Responsive.isTabletLarge(context);

    if (isMobile) {
      return _buildMobileLayout(context);
    } else if (isTablet) {
      return _buildTabletLayout(context);
    } else {
      return _buildDesktopLayout(context);
    }
  }

  Widget _buildMobileLayout(BuildContext context) {
    // Use height-aware sizing
    final animSize = ResponsiveSize.vhSize(context, mobile: 120, tablet: 150, desktop: 180);

    return Column(
      children: [
        // Profile animation - height-responsive
        SizedBox(
          width: animSize,
          height: animSize,
          child: const RubensRiveAnimation(),
        ),

        SizedBox(height: ResponsiveSize.space(context, 3)),

        // Description
        _buildDescriptionCard(context, padding: 15, borderRadius: 15),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    // Scale animation with viewport height
    final animSize = ResponsiveSize.vhSize(context, mobile: 200, tablet: 250, desktop: 300);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Profile animation - height-responsive
        SizedBox(
          width: animSize,
          height: animSize,
          child: const RubensRiveAnimation(),
        ),

        SizedBox(width: ResponsiveSize.space(context, 4)),

        // Description
        Expanded(
          child: _buildDescriptionCard(context, padding: 20, borderRadius: 16),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    // Scale animation with viewport height
    final animSize = ResponsiveSize.vhSize(context, mobile: 300, tablet: 350, desktop: 400);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveSize.width(context, desktopFactor: 0.12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile animation - height-responsive
          SizedBox(
            width: animSize,
            height: animSize,
            child: const RubensRiveAnimation(),
          ),

          SizedBox(width: ResponsiveSize.space(context, 5)),

          // Description
          Expanded(
            child: _buildDescriptionCard(
              context,
              padding: 28,
              borderRadius: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionCard(
    BuildContext context, {
    required double padding,
    required double borderRadius,
  }) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: [
          BoxShadow(
            offset: const Offset(4, 4),
            color: Colors.black.withValues(alpha: 0.8),
          ),
        ],
      ),
      child: Text.rich(
        TextSpan(
          style: AppTextStyles.bodyText(
            context,
          ).copyWith(height: 1.5, color: Colors.black87),
          children: [
            TextSpan(
              text:
                  '2 years of experience in mobile application development, I create engaging and high-quality apps with a focus on smooth user experiences.\n\n',
              style: AppTextStyles.bodyTextBold(context),
            ),
            TextSpan(
              text:
                  'My work blends technical precision with creative flair, from building robust app features to designing beautiful animations that bring interfaces to life.\n\n',
              style: AppTextStyles.bodyText(context),
            ),
            TextSpan(
              text:
                  "I've developed diverse projects across mobile and web platforms, always prioritizing thoughtful UI/UX design to ensure every interaction feels natural and polished.",
              style: AppTextStyles.bodyText(context),
            ),
          ],
        ),
      ),
    );
  }
}
