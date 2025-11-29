import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio_web/constants/app_colors.dart';

class ExperienceTable extends StatefulWidget {
  final List<ExperienceItem> experiences;

  const ExperienceTable({super.key, required this.experiences});

  @override
  State<ExperienceTable> createState() => _ExperienceTableState();
}

class _ExperienceTableState extends State<ExperienceTable> {
  Set<int> expandedItems = <int>{};

  void _toggleExpansion(int index) {
    setState(() {
      if (expandedItems.contains(index)) {
        expandedItems.remove(index);
      } else {
        expandedItems.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Table content
        Expanded(
          child: ListView.builder(
            itemCount: widget.experiences.length,
            itemBuilder: (context, index) {
              final experience = widget.experiences[index];
              final isExpanded = expandedItems.contains(index);

              return ExperienceCard(
                experience: experience,
                isExpanded: isExpanded,
                onToggle: () => _toggleExpansion(index),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ExperienceCard extends StatelessWidget {
  final ExperienceItem experience;
  final bool isExpanded;
  final VoidCallback onToggle;

  const ExperienceCard({
    super.key,
    required this.experience,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExperienceHeader(
          experience: experience,
          onToggle: onToggle,
          isExpanded: isExpanded,
        ),
        ExperienceExpandableContent(
          experience: experience,
          isExpanded: isExpanded,
        ),
      ],
    );
  }
}

class ExperienceHeader extends StatelessWidget {
  final ExperienceItem experience;
  final VoidCallback onToggle;
  final bool isExpanded;

  const ExperienceHeader({
    super.key,
    required this.experience,
    required this.onToggle,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            // Period
            Expanded(
              flex: 2,
              child: Text(
                experience.period,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Company
            Expanded(
              flex: 2,
              child: Text(
                experience.company,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // Position
            Expanded(
              flex: 3,
              child: Text(
                experience.position,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            // Location
            Expanded(
              flex: 2,
              child: Text(
                experience.location,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            // Plus/X icon button
            ToggleButton(onToggle: onToggle, isExpanded: isExpanded),
          ],
        ),
      ),
    );
  }
}

class ToggleButton extends StatelessWidget {
  final VoidCallback onToggle;
  final bool isExpanded;

  const ToggleButton({
    super.key,
    required this.onToggle,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: AnimatedRotation(
        turns: isExpanded ? 0.125 : 0,
        duration: const Duration(milliseconds: 200),
        child: SvgPicture.asset(
          'assets/svg/plus.svg',
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
        ),
      ),
    );
  }
}

class ExperienceExpandableContent extends StatelessWidget {
  final ExperienceItem experience;
  final bool isExpanded;

  const ExperienceExpandableContent({
    super.key,
    required this.experience,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      height: isExpanded ? 200 : 0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.experienceDetailsBg,
        border: Border.all(color: Colors.black, width: 2),
      ),
      curve: Curves.easeInOut,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: experience.details.asMap().entries.map((entry) {
            String detail = entry.value;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      detail,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ExperienceItem {
  final String period;
  final String company;
  final String position;
  final String location;
  final List<String> details;

  const ExperienceItem({
    required this.period,
    required this.company,
    required this.position,
    required this.location,
    required this.details,
  });
}
