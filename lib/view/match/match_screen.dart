

import 'package:flutter/scheduler.dart';

import '../../base_project/package_widget.dart';

class DrawerTrackingDemo extends StatefulWidget {
  @override
  _DrawerTrackingDemoState createState() => _DrawerTrackingDemoState();
}

class _DrawerTrackingDemoState extends State<DrawerTrackingDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double drawerWidth = 250.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  void _toggleDrawer() {
    if (_controller.isDismissed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Drawer Tracking')),
      body: Stack(
        children: [
          Center(child: Text('Swipe or press the button to open drawer')),

          // Drawer sử dụng AnimatedBuilder để theo dõi vị trí
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              double translateX = drawerWidth * _controller.value;
              return Transform.translate(
                offset: Offset(-drawerWidth + translateX, 0),
                child: child,
              );
            },
            child: Container(
              width: drawerWidth,
              color: Colors.blue,
              child: Column(
                children: [
                  DrawerHeader(
                    child: Text(
                      'Drawer Header',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  ListTile(
                    title: Text('Item 1'),
                    onTap: () {
                      _controller.reverse();
                    },
                  ),
                ],
              ),
            ),
          ),

          // GestureDetector để kéo mở/đóng Drawer
          GestureDetector(
            onHorizontalDragUpdate: (details) {
              _controller.value += details.primaryDelta! / drawerWidth;
            },
            onHorizontalDragEnd: (details) {
              if (_controller.value > 0.5) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
          ),
        ],
      ),

      // Nút bấm mở Drawer
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleDrawer,
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _controller,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}



