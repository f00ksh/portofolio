import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio_web/constants/app_text_styles.dart';
import 'package:portfolio_web/screens/contact/custom_paint.dart';
import 'package:portfolio_web/screens/contact/forms.dart';
import 'package:portfolio_web/screens/contact/send_button.dart';
import 'package:portfolio_web/utils/responsive_utils.dart';
import 'package:portfolio_web/utils/responsive_sizing.dart';

class ContactSectionCard extends ConsumerWidget {
  const ContactSectionCard({super.key});

  List<Widget> _buildSocialIcons({required bool isMobile}) {
    final iconSize = isMobile ? 18.0 : 20.0;
    final socialLinks = [
      (FontAwesomeIcons.facebook, () {}),
      (FontAwesomeIcons.twitter, () {}),
      (FontAwesomeIcons.linkedin, () {}),
      (FontAwesomeIcons.github, () {}),
    ];

    return socialLinks.map((link) {
      return IconButton(
        icon: FaIcon(link.$1, color: Colors.black, size: iconSize),
        onPressed: link.$2,
        padding: EdgeInsets.all(isMobile ? 4 : 8),
        constraints: BoxConstraints(
          minWidth: isMobile ? 32 : 48,
          minHeight: isMobile ? 32 : 48,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSent = ref.watch(sendStateNotifierProvider);
    final isMobile = Responsive.isMobile(context);

    return Container(
      color: const Color(0xffffcb46),
      height: screenHeight,
      width: screenWidth,
      child: Column(
        children: [
          SizedBox(height: ResponsiveSize.vh(context, 8)),
          Padding(
            padding: ResponsiveSize.padding(context, horizontal: 4),
            child: Text(
              "LET'S TALK!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ResponsiveSize.text(
                  context,
                  mobile: 48,
                  tablet: 96,
                  desktop: 120,
                ),
                fontWeight: FontWeight.w900,
                color: Colors.black,
                letterSpacing: 1,
                height: 0.9,
              ),
            ),
          ),
          SizedBox(height: ResponsiveSize.vh(context, 3)),
          if (!isSent)
            SizedBox(
              height: (screenHeight * 0.7).clamp(400.0, 700.0),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Lottie.asset(
                    'assets/animations/greenplane.json',
                    frameRate: FrameRate.max,
                  ),
                  // Envelope at the bottom
                  if (!isMobile)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomPaint(
                        size: Size(screenWidth * .65, screenHeight * 0.25),
                        painter: EnvelopePainter(),
                      ),
                    ),
                  // The white form card
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: isMobile ? screenWidth * 0.9 : screenWidth * 0.65,
                      height: screenHeight * 0.65,
                      padding: !isMobile
                          ? const EdgeInsets.symmetric(horizontal: 24)
                          : const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: isMobile
                            ? const EdgeInsets.all(20)
                            : EdgeInsets.all(screenWidth * 0.04),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Name & Email Row
                            !isMobile
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          label: 'Name',
                                          hint: 'Your name',
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.05,
                                      ),
                                      Expanded(
                                        child: CustomTextField(
                                          label: 'Email Address',
                                          hint: 'you@example.com',
                                          keyboardType:
                                              TextInputType.emailAddress,
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      CustomTextField(
                                        label: 'Name',
                                        hint: 'Your name',
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                            0.025,
                                      ),
                                      CustomTextField(
                                        label: 'Email Address',
                                        hint: 'you@example.com',
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.025,
                            ),

                            // Message box
                            Expanded(
                              child: CustomMessageField(hint: "What's up?"),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.025,
                            ),

                            // Send button
                            CustomSendButtonAnimated(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (!isMobile)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomPaint(
                        size: Size(screenWidth * .65, screenHeight * 0.16),
                        painter: CustomShapePainter(),
                      ),
                    ),
                  // lottie animation on top
                  Lottie.asset(
                    'assets/animations/pinkpaperplane.json',
                    frameRate: FrameRate.max,
                  ),
                ],
              ),
            )
          else
            Lottie.asset(
              repeat: false,
              'assets/animations/messagesent.json',
              frameRate: FrameRate.max,
            ),
          Container(
            width: double.infinity,
            height: isMobile ? 80 : 60,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 24,
              vertical: isMobile ? 8 : 0,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.black, width: 2)),
            ),
            child: isMobile
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '© 2025 Mohamed Fouda',
                        style: AppTextStyles.caption(context).copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildSocialIcons(isMobile: true),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '© 2025 Mohamed Fouda',
                        style: AppTextStyles.bodyText(context).copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: _buildSocialIcons(isMobile: false),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
