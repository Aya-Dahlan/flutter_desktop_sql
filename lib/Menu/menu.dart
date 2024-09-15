import 'package:flutter/material.dart';
import 'package:flutter_desktop_sql/Components/colors.dart';
import 'package:flutter_desktop_sql/Menu/menu_items.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final controller = MenuItems();
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          background(
            Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                  height: 150,
                ),
                Expanded(
                  flex: 3,
                  child: ListView.builder(
                    itemCount: controller.items.length,
                    itemBuilder: (context, index) {
                      bool selectedItem = currentIndex == index;
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: selectedItem
                                ? primaryColor.withOpacity(0.05)
                                : Colors.transparent),
                        child: ListTile(
                          title: Text(controller.items[index].title),
                          leading: Icon(controller.items[index].icon),
                          onTap: () {
                            setState(() {
                              currentIndex = index;
                              _pageController.jumpToPage(index);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ListTile(
                        leading: Icon(Icons.logout),
                        title: Text("LOGOUT"),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemCount: controller.items.length,
              itemBuilder: (context, index) {
                return controller.items[index].page;
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget background(Widget child) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    width: 200,
    height: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.8),
          blurRadius: 1,
          spreadRadius: 0,
        ),
      ],
    ),
    child: child,
  );
}
