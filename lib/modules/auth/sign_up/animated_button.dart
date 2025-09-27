import 'package:flutter/material.dart';

class AnimatedBounceButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool enabled;

  AnimatedBounceButton({
    required this.text,
    required this.onPressed,
    this.enabled = true,
  });

  @override
  _AnimatedBounceButtonState createState() => _AnimatedBounceButtonState();
}

class _AnimatedBounceButtonState extends State<AnimatedBounceButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
    _scale = Tween<double>(begin: 1.0, end: 1.1).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        if (widget.enabled) _controller.forward();
      },
      onTapUp: (_) {
        if (widget.enabled) {
          _controller.reverse();
          widget.onPressed();
        }
      },
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
          decoration: BoxDecoration(
            color: widget.enabled ? Colors.pinkAccent : Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            widget.text,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
