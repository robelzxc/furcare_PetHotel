import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:final_capstone_furcare/Pages/Staff_Page/Main/customer_profile.dart';
import 'package:final_capstone_furcare/Pages/Staff_Page/Main/queue.dart';
import 'package:flutter/material.dart';

class StaffPage extends StatefulWidget {
  const StaffPage({Key? key}) : super(key: key);

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  int _currentIndex = 0;

  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: [
            QueuePage(),
            CustomerProfile(),
            StaffPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              icon: Icon(Icons.drive_folder_upload_outlined),
              title: Text('Queue')),
          BottomNavyBarItem(
              icon: Icon(Icons.manage_accounts),
              title: Text('Customer Details')),
          BottomNavyBarItem(
              icon: Icon(Icons.account_circle_rounded),
              title: Text('Profile')),
        ],
        onItemSelected: (index) {
          setState(() {
            _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}
