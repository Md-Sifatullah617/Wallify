import 'package:flutter/material.dart';
import 'package:wallify/pexels.dart';
import 'package:wallify/unsplash.dart';

class Wallpaper extends StatefulWidget {
  const Wallpaper({super.key});

  @override
  State<Wallpaper> createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  int selectedItem = 0;
  final List<Widget> widgetsOption = [const Pexels(), const Unsplash()];

  void onItemTapped(index) {
    setState(() {
      selectedItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
            widgetsOption.elementAt(selectedItem),
          Positioned(
            bottom: 25,
            right: MediaQuery.of(context).size.width / 4,
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width / 2,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 92, 92, 92), blurRadius: 10)
                  ]),
              child: BottomNavigationBar(
                  selectedItemColor: Colors.black,
                  selectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 19),
                  unselectedItemColor: Colors.blueGrey,
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  items: const [
                    BottomNavigationBarItem(
                        icon: SizedBox.shrink(), label: "Pexels"),
                    BottomNavigationBarItem(
                        icon: SizedBox.shrink(), label: "Unsplash")
                  ],
                  currentIndex: selectedItem,
                  onTap: onItemTapped,                  
                  ),
            ),
          )

          //   InkWell(
          //     onTap: () {
          //       loadMore();
          //     },
          //     child: Container(
          //       height: 60,
          //       width: double.infinity,
          //       color: Colors.black,
          //       child: const Center(
          //           child: Text(
          //         "Load More",
          //         style: TextStyle(fontSize: 20, color: Colors.white),
          //       )),
          //     ),
          //   )
        ],
      ),
    );
  }
}
