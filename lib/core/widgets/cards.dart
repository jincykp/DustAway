import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class HorizontalCardList extends StatelessWidget {
  final List<Map<String, String>> data = [
    {
      'image': 'assets/images/homecleaning.png',
      'title': 'Home Cleaning',
    },
    {
      'image': 'assets/images/carpet.png',
      'title': 'Carpet Cleaning',
    },
    {
      'image': 'assets/images/floorcleaning.png',
      'title': 'Sofa Cleaning',
    },
    {
      'image': 'assets/images/homecleaning.png',
      'title': 'See More',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.amber,
      height: 250, // Adjusted height to accommodate card and title
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                // Card with image
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    width: 150, // Fixed width for the card
                    height: 180, // Fixed height for the card
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage(data[index]['image']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Title below the card
                SizedBox(height: 8),
                Text(
                  data[index]['title']!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
