import 'package:capstone_news_app/constants/app_colors.dart';
import 'package:capstone_news_app/constants/nav_images.dart';
import 'package:capstone_news_app/pages/home/homepage.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key, this.activeIcon, this.inactiveIcon});
  final Widget? activeIcon;
  final Widget? inactiveIcon;

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedIconTheme:
            const IconThemeData(color: AppColors.activeIndicatorColor),
        unselectedIconTheme: const IconThemeData(color: Colors.black),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: (_selectedIndex == 1)
                ? Image.asset(NavImages.search)
                : Image.asset(NavImages.searchInactive),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: (_selectedIndex == 2)
                ? Image.asset(NavImages.media)
                : Image.asset(NavImages.mediaInactive),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? Image.asset(NavImages.saved)
                : Image.asset(NavImages.savedInactive),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 4
                ? Image.asset(NavImages.profile)
                : Image.asset(NavImages.profileInactive),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return Homepage();
      case 1:
        return Center(child: Text('Search Page'));
      case 2:
        return Center(child: Text('Bookmarks'));
      case 3:
        return Center(child: Text('Notifications'));
      case 4:
        return Center(child: Text('Profile'));
      default:
        return Homepage();
    }
  }
}
