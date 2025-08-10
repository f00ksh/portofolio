import 'package:flutter/material.dart';
import 'package:portfolio_web/screens/about/animated_text.dart';
import 'package:portfolio_web/screens/about/data.dart';
import 'package:portfolio_web/screens/about/experince_table.dart';
import 'package:portfolio_web/screens/about/rive_animation.dart';

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
          const Padding(
            padding: EdgeInsets.only(top: 25),
            child: AnimatedText(
              text: 'EXPERIENCE',
              fontSize: 120,
              fontWeight: FontWeight.w900,
              color: Colors.black,
              letterSpacing: 1.2,
              duration: Duration(seconds: 30),
              strokeWidth: 0.5,
            ),
          ),

          // Main content
          Padding(
            padding: const EdgeInsets.all(20),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWideScreen = constraints.maxWidth > 900;
                final isMidScreen =
                    constraints.maxWidth > 600 && constraints.maxWidth <= 900;
                final horizontalPadding = isWideScreen
                    ? (constraints.maxWidth *
                          0.15) // 20% padding on each side = 60% content width
                    : 0.0; // No padding on mobile and mid screens

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: (isWideScreen || isMidScreen)
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Profile animation - smaller on mid screen
                            SizedBox(
                              width: isMidScreen ? 300 : null,
                              height: isMidScreen ? 300 : null,
                              child: const RubensRiveAnimation(),
                            ),

                            SizedBox(width: isMidScreen ? 15 : 20),

                            // Description
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(isMidScreen ? 18 : 25),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    isMidScreen ? 15 : 20,
                                  ),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(
                                        isMidScreen ? 3 : 4,
                                        isMidScreen ? 3 : 4,
                                      ),
                                      color: Colors.black.withValues(
                                        alpha: 0.8,
                                      ),
                                    ),
                                  ],
                                ),
                                child: Text.rich(
                                  TextSpan(
                                    style: TextStyle(
                                      fontSize: isMidScreen ? 12 : 16,
                                      height: 1.4,
                                      color: Colors.black87,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            '2 years of experience in mobile application development, I create engaging and high-quality apps with a focus on  smooth user experiences .\n\n',
                                        style: TextStyle(
                                          fontSize: isMidScreen ? 14 : 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const TextSpan(
                                        text:
                                            'My work blends technical precision with creative flair, from building robust app features to designing beautiful animations that bring interfaces to life.\n\n',
                                      ),
                                      const TextSpan(
                                        text:
                                            'I’ve developed diverse projects across mobile and web platforms, always prioritizing thoughtful UI/UX design to ensure every interaction feels natural and polished.',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            // Profile animation - smaller on mobile
                            SizedBox(
                              width: 150,
                              height: 150,
                              child: const RubensRiveAnimation(),
                            ),

                            const SizedBox(height: 15),

                            // Description - smaller padding and text on mobile
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(3, 3),
                                    color: Colors.black.withValues(alpha: 0.8),
                                  ),
                                ],
                              ),
                              child: const Text.rich(
                                TextSpan(
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 1.3,
                                    color: Colors.black87,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          '2 years of experience in mobile application development, I create engaging and high-quality apps with a focus on  smooth user experiences .\n\n',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'My work blends technical precision with creative flair, from building robust app features to designing beautiful animations that bring interfaces to life.\n\n',
                                    ),
                                    TextSpan(
                                      text:
                                          'I’ve developed diverse projects across mobile and web platforms, always prioritizing thoughtful UI/UX design to ensure every interaction feels natural and polished.',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                );
              },
            ),
          ),

          // Divider
          Container(
            width: double.infinity,
            height: 2,
            color: Colors.black,
            margin: const EdgeInsets.only(top: 20),
          ),

          // Experience table
          Expanded(
            child: Container(
              width: double.infinity,
              color: const Color(0xFF57ef97),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWideScreen = constraints.maxWidth > 900;
                  final isMidScreen =
                      constraints.maxWidth > 600 && constraints.maxWidth <= 900;
                  double horizontalPadding = 0.0;

                  if (isWideScreen) {
                    horizontalPadding =
                        constraints.maxWidth * 0.15; // 20% padding
                  } else if (isMidScreen) {
                    horizontalPadding =
                        constraints.maxWidth *
                        0.1; // 10% padding for mid screens
                  }

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: 0,
                    ),
                    child: ExperienceTable(experiences: experiences),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
