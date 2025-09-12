import 'package:flutter/material.dart';
import 'package:porfolio/widgets/project_book.dart';
import 'package:porfolio/widgets/section_description.dart';
import 'package:porfolio/widgets/section_header.dart';
import 'package:porfolio/widgets/section_title_gradient.dart';

class ProjectSection extends StatelessWidget {
  const ProjectSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with your actual project data
    final projects = [
      {
        'imagePath': 'assets/images/dart.png', // Replace with your image
        'title': 'Portfolio Website',
        'description':
            'A personal portfolio to showcase my skills and projects, built with Flutter Web.',
        'technologies': ['Flutter', 'Dart', 'Responsive UI'],
      },
      {
        'imagePath': 'assets/images/flutter.png', // Replace with your image
        'title': 'E-commerce App',
        'description':
            'A mobile application for an online store with Firebase integration.',
        'technologies': ['Flutter', 'Firebase', 'BLoC'],
      },
      {
        'imagePath': 'assets/images/project3.png', // Replace with your image
        'title': 'Task Manager',
        'description': 'A simple and elegant task management application.',
        'technologies': ['Flutter', 'Provider', 'SQLite'],
      },
      // Add more projects here
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: Column(
        children: [
          const SectionHeader(text: 'My Work', icon: Icons.work_outline),
          const SizedBox(height: 30),
          const SectionTitleGradient(title: 'Featured Projects'),
          const SizedBox(height: 10),
          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              gradient: LinearGradient(
                colors: [Colors.purple.shade500, Colors.blue.shade500],
              ),
            ),
          ),
          const SizedBox(height: 30),
          const SectionDescription(
            text: 'Here are a few projects I\'ve worked on recently.',
          ),
          const SizedBox(height: 50),
          ProjectBook(projects: projects),
        ],
      ),
    );
  }
}
