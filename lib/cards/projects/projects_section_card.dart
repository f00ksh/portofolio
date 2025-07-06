import 'package:flutter/material.dart';

class ProjectsSectionCard extends StatelessWidget {
  const ProjectsSectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,

      color: Colors.black,

      child: Column(
        children: [
          Spacer(),
          const Text(
            'Featured Projects',
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}


//////////////////
///