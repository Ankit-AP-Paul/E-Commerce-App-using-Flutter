import 'package:flutter/material.dart';

class SwipeUpContainer extends StatefulWidget {
  const SwipeUpContainer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SwipeUpContainerState createState() => _SwipeUpContainerState();
}

class _SwipeUpContainerState extends State<SwipeUpContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.6),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
      if (_isFullScreen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _toggleHalfScreen() {
    setState(() {
      _isFullScreen = false;
      _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        // Detect swipe-up gesture
        if (!_isFullScreen && details.delta.dy < -6) {
          _toggleFullScreen();
        }
        // Detect swipe-down gesture
        if (_isFullScreen && details.delta.dy > 6) {
          _toggleHalfScreen();
        }
      },
      onVerticalDragDown: (_) {},
      child: SizedBox(
        height: _isFullScreen ? MediaQuery.of(context).size.height : null,
        child: SlideTransition(
          position: _offsetAnimation,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: const [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Popular Products',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
