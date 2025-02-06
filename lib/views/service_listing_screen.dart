import 'package:dustaway/core/theme/colors.dart';
import 'package:dustaway/views/maidService_screen.dart';
import 'package:flutter/material.dart';

class ServiceListingScreen extends StatelessWidget {
  const ServiceListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 246, 246),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Card(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.chevron_left),
                      ),
                    ),
                    SizedBox(width: 15),
                    Text(
                      "Cleaning Services",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // 🚀 Custom-Styled TabBar
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                      255, 156, 240, 159), // Background color of TabBar
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize
                        .tab, // Ensures full tab width is covered
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 80, 233, 80), // Dark green (left)
                          Color.fromARGB(255, 2, 49, 3), // Faded green (right)
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    labelColor: AppColors.whiteColor, // Selected text color
                    unselectedLabelColor: Colors.black, // Unselected text color
                    tabs: [
                      Tab(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(
                            fit: BoxFit
                                .scaleDown, // Ensures text fits inside the tab
                            child: Text(
                              "Deep Cleaning",
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(
                            fit: BoxFit
                                .scaleDown, // Ensures text fits inside the tab
                            child: Text(
                              "Maid Services",
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(
                            fit: BoxFit
                                .scaleDown, // Ensures text fits inside the tab
                            child: Text(
                              "Car Cleaning",
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 🚀 Expanded TabBarView
              Expanded(
                child: TabBarView(
                  children: [
                    Center(
                        child: Text("Home Cleaning Services",
                            style: TextStyle(fontSize: 18))),
                    MaidserviceScreen(),
                    Center(
                        child: Text("Car Cleaning Services",
                            style: TextStyle(fontSize: 18))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
