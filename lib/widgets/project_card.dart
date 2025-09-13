// import 'dart:math' as math;

// import 'package:flutter/material.dart';
// import 'package:porfolio/widgets/tag_chip.dart';

// class ProjectCard extends StatefulWidget {
//   final String imagePath;
//   final String title;
//   final String description;
//   final List<String> technologies;

//   const ProjectCard({
//     super.key,
//     required this.imagePath,
//     required this.title,
//     required this.description,
//     required this.technologies,
//   });

//   @override
//   State<ProjectCard> createState() => _ProjectCardState();
// }

// class _ProjectCardState extends State<ProjectCard>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   bool _isOpen = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _toggleBook() {
//     setState(() {
//       _isOpen = !_isOpen;
//       if (_isOpen) {
//         _controller.forward();
//       } else {
//         _controller.reverse();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;

//     return GestureDetector(
//       onTap: _toggleBook,
//       child: Container(
//         width: 350,
//         height: 450, // Give it a fixed height to contain the book
//         margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//         child: Stack(
//           children: [
//             // The inside of the book (visible when open)
//             Container(
//               width: 350,
//               height: 450,
//               decoration: BoxDecoration(
//                 color: isDark ? const Color(0xFF1A1A22) : Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: isDark
//                         ? Colors.black.withOpacity(0.5)
//                         : Colors.grey.withOpacity(0.2),
//                     spreadRadius: 2,
//                     blurRadius: 10,
//                     offset: const Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.title,
//                       style: theme.textTheme.headlineSmall?.copyWith(
//                         fontWeight: FontWeight.bold,
//                         color: theme.colorScheme.onSurface,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Expanded(
//                       child: Text(
//                         widget.description,
//                         style: theme.textTheme.bodyMedium?.copyWith(
//                           color: theme.colorScheme.onSurface.withOpacity(0.7),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Wrap(
//                       spacing: 8.0,
//                       runSpacing: 8.0,
//                       children: widget.technologies
//                           .map<Widget>((tech) => TagChip(text: tech))
//                           .toList(),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // The book cover that animates
//             AnimatedBuilder(
//               animation: _controller,
//               builder: (context, child) {
//                 return Transform(
//                   alignment: Alignment.centerLeft,
//                   transform: Matrix4.identity()
//                     ..setEntry(3, 2, 0.001) // Perspective
//                     ..rotateY(_controller.value * -math.pi / 2),
//                   child: child,
//                 );
//               },
//               child: Container(
//                 width: 350,
//                 height: 450,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.4),
//                       spreadRadius: 2,
//                       blurRadius: 15,
//                     ),
//                   ],
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(16),
//                   child: Image.asset(widget.imagePath, fit: BoxFit.cover),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
