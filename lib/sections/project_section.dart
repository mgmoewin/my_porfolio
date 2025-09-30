import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:porfolio/widgets/project_book.dart';
import 'package:porfolio/widgets/responsive_builder.dart';
import 'package:porfolio/widgets/section_description.dart';
import 'package:porfolio/widgets/section_header.dart';
import 'package:porfolio/widgets/section_title_gradient.dart';

class ProjectSection extends StatefulWidget {
  const ProjectSection({super.key});

  @override
  State<ProjectSection> createState() => _ProjectSectionState();
}

class _ProjectSectionState extends State<ProjectSection> {
  Future<List<Map<String, dynamic>>>? _projectsFuture;

  @override
  void initState() {
    super.initState();
    _projectsFuture = _loadProjectsData();
  }

  Future<List<Map<String, dynamic>>> _loadProjectsData() async {
    final String jsonString = await rootBundle.loadString(
      'assets/data/feature_list.json',
    );
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.cast<Map<String, dynamic>>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: Column(
        children: [
          const SectionHeader(text: 'My Work', icon: Icons.work_outline),
          const SizedBox(height: 30),
          const SectionTitleGradient(title: 'Featured Projects'), //
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
          ResponsiveBuilder(
            builder: (context, screenSize) {
              return FutureBuilder<List<Map<String, dynamic>>>(
                future: _projectsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return ProjectBook(projects: snapshot.data!);
                  } else {
                    return const Center(child: Text('No projects found.'));
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
