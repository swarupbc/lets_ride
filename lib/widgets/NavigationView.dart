// import 'package:flutter/material.dart';
// import 'package:bottom_navy_bar/bottom_navy_bar.dart';
// import 'package:lets_ride/screens/HomeScreen.dart';

// class NavigationView extends StatefulWidget {
//   static String id = '/NavigationScreen';

//   @override
//   _NavigationViewState createState() => _NavigationViewState();
// }

// class _NavigationViewState extends State<NavigationView> {
//   int _currentIndex = 0;
//   PageController _pageController;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SizedBox.expand(
//         child: PageView(
//           allowImplicitScrolling: false,
//           onPageChanged: (index) {
//             setState(() => _currentIndex = index);
//           },
//           children: <Widget>[
//             HomeScreen(),
//             Container(
//               color: Colors.red,
//             ),
//             Container(
//               color: Colors.green,
//             ),
//             Container(
//               color: Colors.blue,
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavyBar(
//         selectedIndex: _currentIndex,
//         onItemSelected: (index) {
//           setState(() => _currentIndex = index);
//           _pageController.jumpToPage(index);
//         },
//         items: <BottomNavyBarItem>[
//           BottomNavyBarItem(
//             title: Text('Book'),
//             activeColor: Colors.purpleAccent[100],
//             inactiveColor: Colors.lightGreen[500],
//             icon: Icon(
//               Icons.location_on_outlined,
//             ),
//           ),
//           BottomNavyBarItem(
//             title: Text('Food'),
//             activeColor: Colors.purpleAccent[100],
//             inactiveColor: Colors.lightGreen[500],
//             icon: Icon(Icons.restaurant),
//           ),
//           BottomNavyBarItem(
//             title: Text('Settings'),
//             activeColor: Colors.purpleAccent[100],
//             inactiveColor: Colors.lightGreen[500],
//             icon: Icon(Icons.settings),
//           ),
//           BottomNavyBarItem(
//             title: Text('Profile'),
//             activeColor: Colors.purpleAccent[100],
//             inactiveColor: Colors.lightGreen[500],
//             icon: Icon(Icons.person),
//           ),
//         ],
//       ),
//     );
//   }
// }
