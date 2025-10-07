import 'package:flutter/material.dart';
import 'package:portfolio_web/constants/app_text_styles.dart';

class ProjectsSectionCard extends StatelessWidget {
  const ProjectsSectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.black,
      child: Column(
        children: [
          const Spacer(),
          Text(
            'Featured Projects',
            textAlign: TextAlign.center,
            style: AppTextStyles.sectionTitle(context).copyWith(
              color: Colors.white,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}