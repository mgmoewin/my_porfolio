import 'package:flutter/material.dart';

class TypingText extends StatefulWidget {
  final List<String> texts;
  const TypingText({super.key, required this.texts});

  @override
  _TypingTextState createState() => _TypingTextState();
}

class _TypingTextState extends State<TypingText> with TickerProviderStateMixin {
  late AnimationController _textController;
  late Animation<int> _textAnimation;
  late AnimationController _cursorController;
  int _currentIndex = 0;
  bool _isTyping = true;

  @override
  void initState() {
    super.initState();

    // The cursor animation will loop continuously
    _cursorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    // Initial setup for the text animation
    _setupAnimation();
  }

  void _setupAnimation() {
    final String currentText = widget.texts[_currentIndex];
    final int textLength = currentText.length;

    if (_isTyping) {
      // Typing animation (forward)
      _textController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: textLength * 120), // Adjust speed
      )..forward();
      _textAnimation = IntTween(
        begin: 0,
        end: textLength,
      ).animate(_textController);
    } else {
      // Backspacing animation (reverse)
      _textController = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: textLength * 50,
        ), // Backspacing is faster
      )..forward();
      _textAnimation = IntTween(
        begin: textLength,
        end: 0,
      ).animate(_textController);
    }

    _textController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_isTyping) {
          // Pause after typing
          Future.delayed(const Duration(milliseconds: 2000), () {
            if (mounted) {
              setState(() {
                _isTyping = false;
              });
              _textController.dispose();
              _setupAnimation();
            }
          });
        } else {
          // Pause after backspacing, then start typing next text
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              setState(() {
                _currentIndex = (_currentIndex + 1) % widget.texts.length;
                _isTyping = true;
              });
              _textController.dispose();
              _setupAnimation();
            }
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _cursorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 300, // Minimum width of the box
        maxWidth: double.infinity, // Allows the box to expand
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFff8a00), Color(0xFFe2229a)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        child: AnimatedBuilder(
          animation: _textAnimation,
          builder: (context, child) {
            final String currentText = widget.texts[_currentIndex];
            String displayedText = currentText.substring(
              0,
              _textAnimation.value,
            );

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize:
                    MainAxisSize.min, // This makes the Row wrap its content
                children: [
                  Text(
                    displayedText,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.clip,
                    softWrap: false,
                  ),
                  // Show cursor only when the animation is active
                  FadeTransition(
                    opacity: Tween<double>(
                      begin: 0.0,
                      end: 1.0,
                    ).animate(_cursorController),
                    child: const Text(
                      '|', // Removed space to prevent extra width
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
