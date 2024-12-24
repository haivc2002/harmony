

import '../../base_project/package_widget.dart';

class CustomTabMultiDrawer extends StatefulWidget {
  @override
  State<CustomTabMultiDrawer> createState() => _CustomTabMultiDrawerState();
}

class _CustomTabMultiDrawerState extends State<CustomTabMultiDrawer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void toggleDrawer() {
    if (isDrawerOpen) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    isDrawerOpen = !isDrawerOpen;
  }

  @override
  Widget build(BuildContext context) {
    double drawerWidth = MediaQuery.of(context).size.width * 0.7;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Drawer"),
      ),
      body: Stack(
        children: [
          // Nội dung chính
          const Center(
            child: Text('Main Content'),
          ),

          // Drawer
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              double slide = drawerWidth * _controller.value;
              return Transform.translate(
                offset: Offset(slide, 0),
                child: child,
              );
            },
            child: Row(
              children: [
                SizedBox(
                  width: drawerWidth,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border(
                        right: BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                    ),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        SizedBox(height: 100),
                        ListTile(
                          title: Text('Profile'),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text('Settings'),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text('Logout'),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),

                // Vùng bấm ra ngoài để đóng drawer
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (isDrawerOpen) {
                        toggleDrawer();
                      }
                    },
                    child: Container(
                      color: Colors.black.withOpacity(
                        0.5 * _controller.value,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Nút mở drawer
          Positioned(
            top: 20,
            left: 20,
            child: FloatingActionButton(
              onPressed: toggleDrawer,
              child: Icon(isDrawerOpen ? Icons.close : Icons.menu),
            ),
          ),

          // Hiển thị vị trí drawer
          Positioned(
            top: 100,
            left: 20,
            child: Text(
              'Drawer Position: ${(drawerWidth * _controller.value).toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
