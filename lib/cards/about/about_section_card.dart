import 'package:flutter/material.dart';
import 'package:portfolio_web/cards/about/animated_text.dart';
import 'package:portfolio_web/cards/about/data.dart';
import 'package:portfolio_web/cards/about/experince_table.dart';
import 'package:portfolio_web/cards/about/rive_animation.dart';

class ExperienceScreen extends StatelessWidget {
  const ExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight,

      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 3),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Top spacing
            SizedBox(height: 25),

            // Moving EXPERIENCE text header
            const AnimatedText(
              text: 'EXPERIENCE',
              fontSize: 120,
              fontWeight: FontWeight.w900,
              color: Colors.black,
              letterSpacing: 1.2,
              duration: Duration(seconds: 30),
              strokeWidth: 0.5,
            ),

            // Main content section
            SizedBox(
              height: screenHeight * 0.4, // Fixed height for main content
              child: Wrap(
                children: [
                  // Profile animation
                  const RubensRiveAnimation(),
                  const SizedBox(width: 20),

                  // Description bubble
                  Container(
                    padding: const EdgeInsets.all(50),
                    height: screenHeight * 0.3,
                    width: screenHeight * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black, width: 2),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(4, 4),
                          blurRadius: 0,
                          color: Colors.black.withValues(alpha: 0.8),
                        ),
                      ],
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '16 years of experience in design, between agencies, startups and big corporations.',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'I don\'t just push pixels: design strategy, vision and forward-thinking are some of my most appreciated skills.',
                          style: TextStyle(fontSize: 14, height: 1.4),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'I have experience on a variety of digital products, with awards winning titles in my portfolio. I lead remote design teams, distributed across different time zones, using an approach made of mentoring, coaching and leading by example.',
                          style: TextStyle(fontSize: 14, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Divider
            Container(width: double.infinity, height: 2, color: Colors.black),

            // Experience table section
            Expanded(child: ExperienceTable(experiences: experiences)),
          ],
        ),
      ),
    );
  }
}
