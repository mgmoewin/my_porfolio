import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:porfolio/widgets/tag_chip.dart';

class ProjectBook extends StatefulWidget {
  final List<Map<String, dynamic>> projects;

  const ProjectBook({super.key, required this.projects});

  @override
  State<ProjectBook> createState() => _ProjectBookState();
}

class _ProjectBookState extends State<ProjectBook>
    with TickerProviderStateMixin {
  late AnimationController _pageTurnController;
  late AnimationController _pageTurnBackController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageTurnController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _pageTurnBackController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _pageTurnController.dispose();
    _pageTurnBackController.dispose();
    super.dispose();
  }

  void _turnPage() {
    if (_currentPage < widget.projects.length - 1) {
      _pageTurnController.forward(from: 0.0).then((_) {
        setState(() {
          _currentPage++;
        });
        _pageTurnController.reset();
      });
    }
  }

  void _turnPageBack() {
    if (_currentPage > 0) {
      _pageTurnBackController.forward(from: 0.0).then((_) {
        setState(() {
          _currentPage--;
        });
        _pageTurnBackController.reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final currentProject = widget.projects[_currentPage];

    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()..setEntry(3, 2, 0.001), // Perspective
      child: SizedBox(
        width: 800, // A bit wider to accommodate the spine
        height: 500,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // The static open book background (Left Page)
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 400,
                height: 500,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF0D1117) : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                  border: Border(
                    right: BorderSide(color: Colors.grey.shade700, width: 2),
                  ),
                ),
                child: GestureDetector(
                  onTap: _currentPage > 0 ? _turnPageBack : null,
                  child: _ProjectDetailsPage(project: currentProject),
                ),
              ),
            ),
            // The static open book background (Right Page)
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 400,
                height: 500,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1A1A22) : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: GestureDetector(
                  onTap: _turnPage,
                  child: _ProjectVisualsPage(project: currentProject),
                ),
              ),
            ),
            // The animated turning page (for turning forward)
            AnimatedBuilder(
              animation: _pageTurnController,
              builder: (context, child) {
                if (_pageTurnController.value == 0) {
                  return const SizedBox.shrink();
                }
                final angle = (_pageTurnController.value) * -math.pi;
                return Align(
                  alignment: Alignment.centerRight,
                  child: Transform(
                    alignment: Alignment.centerLeft, // Pivot from the spine
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001) // Perspective
                      ..rotateY(-angle),
                    child: SizedBox(
                      width: 400,
                      height: 500,
                      child: _pageTurnController.value < 0.5
                          // Front of the turning page (current project's right side)
                          ? _ProjectVisualsPage(project: currentProject)
                          // Back of the turning page (next project's left side, but flipped)
                          : Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()..rotateY(math.pi),
                              child: _ProjectDetailsPage(
                                project: widget.projects[_currentPage + 1],
                              ),
                            ),
                    ),
                  ),
                );
              },
            ),
            // The animated turning page (for turning backward)
            AnimatedBuilder(
              animation: _pageTurnBackController,
              builder: (context, child) {
                if (_pageTurnBackController.value == 0) {
                  return const SizedBox.shrink();
                }
                final angle = (_pageTurnBackController.value) * math.pi;
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Transform(
                    alignment: Alignment.centerRight, // Pivot from the spine
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001) // Perspective
                      ..rotateY(-angle),
                    child: SizedBox(
                      width: 400,
                      height: 500,
                      child: _pageTurnBackController.value < 0.5
                          // Front of the turning page (current project's left side)
                          ? _ProjectDetailsPage(
                              project: currentProject
                            )
                          // Back of the turning page (previous project's right side, but flipped)
                          : Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()..rotateY(math.pi),
                              child: _ProjectVisualsPage(
                                project: widget.projects[_currentPage - 1],
                              ),
                            ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectDetailsPage extends StatelessWidget {
  final Map<String, dynamic> project;

  const _ProjectDetailsPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            project['title'],
            style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Text(
              project['description'],
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Add Live Demo URL logic
                },
                icon: const Icon(Icons.open_in_new),
                label: const Text('Live Demo'),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () {
                  // TODO: Add Source Code URL logic
                },
                icon: const Icon(Icons.code),
                label: const Text('Source Code'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProjectVisualsPage extends StatelessWidget {
  final Map<String, dynamic> project;
  const _ProjectVisualsPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              project['imagePath'] as String,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Technologies Used',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: (project['technologies'] as List<String>)
                .map((tech) => TagChip(text: tech))
                .toList(),
          ),
        ],
      ),
    );
  }
}
