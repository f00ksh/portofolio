import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio_web/cards/contact/custom_paint.dart';
import 'package:portfolio_web/cards/contact/forms.dart';
import 'package:portfolio_web/cards/contact/send_button.dart';

class ContactSectionCard extends ConsumerWidget {
  const ContactSectionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSent = ref.watch(sendStateNotifierProvider);
    return Container(
      color: Color(0xffffcb46),
      height: screenHeight,
      width: screenWidth,
      child: Column(
        children: [
          const Spacer(flex: 5),
          const Text(
            "LET'S TALK!",
            style: TextStyle(
              fontSize: 150,
              fontWeight: FontWeight.w900,
              color: Colors.black,
              letterSpacing: 1,
              height: .6,
            ),
          ),
          const Spacer(flex: 1),
          if (!isSent)
            SizedBox(
              height: screenHeight * 0.75,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Lottie.asset(
                    'assets/animations/greenplane.json',
                    frameRate: FrameRate.max,
                  ),
                  // Envelope at the bottom
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
                      width: screenWidth * .65,
                      height: screenHeight * 0.65,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: const BorderSide(color: Colors.black, width: 2),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.05,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
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
                              Row(
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
                                      keyboardType: TextInputType.emailAddress,
                                    ),
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
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
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
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.black, width: 2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '© 2025 Mohamed Fouda',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 16),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.facebook,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        // Add your Facebook link here
                      },
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.twitter,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        // Add your Twitter link here
                      },
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.linkedin,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        // Add your LinkedIn link here
                      },
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.github,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        // Add your GitHub link here
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
