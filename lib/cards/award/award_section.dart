import 'package:flutter/material.dart';
import 'package:portfolio_web/cards/award/workmarquee.dart';

class AwardsSectionCard extends StatelessWidget {
  const AwardsSectionCard({super.key});

  static const _awardsData = <AwardGroup>[
    AwardGroup(
      year: '2022',
      awards: [
        Award('CSSDA Website Of The Day', 'This website'),
        Award('Awwwards Honorable Mention', 'This website'),
        Award('CSSDA UI + UX + Innovation Awards', 'This website'),
      ],
    ),
    AwardGroup(
      year: '2017',
      awards: [
        Award(
          'Emmy Award for "Outstanding Interactive"',
          'Storybots apps and web',
        ),
        Award('Webby Award honoree', 'storybots.com'),
        Award('Teachers\' Choice Award', 'Storybots Classroom'),
        Award('Parents\' Choice Award', 'Storybots Classroom'),
      ],
    ),
    AwardGroup(
      year: '2015',
      awards: [
        Award('Parents\' Choice Award', 'Ely Flying Explorer app'),
        Award('ECGBL: first prize', 'Ely Flying Explorer app'),
      ],
    ),
    AwardGroup(
      year: '2014',
      awards: [Award('Unicredit Appathon: First Prize', 'Hatly app')],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            color: const Color(0xFFd661ff),
            padding: const EdgeInsets.symmetric(horizontal: 120.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const _Header(),
                const SizedBox(height: 40),
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _awardsData.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 30),
                    itemBuilder: (context, index) {
                      final group = _awardsData[index];
                      return AwardCard(group: group);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        WorkMarquee(),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFFFFD700), Color(0xFFFFB900)],
            ),
          ),
          child: const Icon(Icons.emoji_events, color: Colors.white, size: 40),
        ),
        const SizedBox(width: 30),
        const Text(
          'AWARDS',
          style: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            letterSpacing: 4,
          ),
        ),
      ],
    );
  }
}

class AwardCard extends StatelessWidget {
  final AwardGroup group;
  const AwardCard({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _YearBadge(year: group.year),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              children: group.awards.map((award) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          award.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          award.project,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _YearBadge extends StatelessWidget {
  final String year;
  const _YearBadge({required this.year});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xFF00E5FF), Color(0xFF00B8D4)],
        ),
      ),
      child: Center(
        child: Text(
          year,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class AwardGroup {
  final String year;
  final List<Award> awards;

  const AwardGroup({required this.year, required this.awards});
}

class Award {
  final String name;
  final String project;

  const Award(this.name, this.project);
}
