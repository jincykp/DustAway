import 'package:dustaway/core/theme/colors.dart';
import 'package:dustaway/views/userhome_screen.dart';
import 'package:flutter/material.dart';

class BottomScreen extends StatefulWidget {
  const BottomScreen({super.key});

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const UserhomeScreen(),
    const Scaffold(body: Center(child: Text('Bookings'))),
    const Scaffold(body: Center(child: Text('Account'))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: (index) => setState(() => _selectedIndex = index),
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.grey,
                backgroundColor: Colors.white,
                elevation: 0,
                selectedFontSize: 0, // Added
                unselectedFontSize: 0, // Added
                showSelectedLabels: false, // Added
                showUnselectedLabels: false, // Added
                items: [
                  _buildNavItem(Icons.home_outlined, Icons.home, 'Home', 0),
                  _buildNavItem(
                      Icons.book_outlined, Icons.calendar_month, 'Booking', 1),
                  _buildNavItem(
                      Icons.person_outlined, Icons.person, 'Account', 2),
                ],
              )),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      IconData icon, IconData activeIcon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return BottomNavigationBarItem(
      icon: SizedBox(
        // Added SizedBox wrapper
        width: MediaQuery.of(context).size.width / 3 -
            20, // Divide screen width by number of items
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 4, vertical: 12), // Reduced horizontal padding
          margin: const EdgeInsets.only(top: 2),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.baseColor.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? activeIcon : icon,
                color: isSelected ? AppColors.baseColor : Colors.grey,
                size: 24,
              ),
              const SizedBox(width: 4), // Reduced spacing
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.grey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13, // Slightly reduced font size
                ),
              ),
            ],
          ),
        ),
      ),
      label: '',
    );
  }
}
