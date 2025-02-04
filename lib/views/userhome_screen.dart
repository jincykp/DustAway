import 'package:dustaway/core/theme/colors.dart';
import 'package:flutter/material.dart';

class UserhomeScreen extends StatelessWidget {
  const UserhomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/images/👋.png',
                width: 30,
                height: 30,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '406, Skyline Park Dale, MM Road...',
                    style: TextStyle(color: AppColors.textGreyColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Image.asset('assets/images/Path 857.png'),
                SizedBox(
                  width: 10,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset(
                    'assets/images/Icon Cart.png',
                    width: 40,
                    height: 40,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
              width: screenWidth,
              height: 200,
              child: Image.asset('assets/images/perfectcleaningservice.png'),
            ),
            Material(
              elevation: 3,
              child: TextField(
                decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.baseColor),
                          child: Icon(
                            Icons.search,
                            color: AppColors.whiteColor,
                            size: 25,
                          ),
                          //color: AppColors.baseColor,
                          width: 40,
                          height: 40),
                    ),
                    fillColor: AppColors.whiteColor,
                    filled: true,
                    hintText: "Search for a service",
                    hintStyle:
                        TextStyle(color: AppColors.textGreyColor, fontSize: 13),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none)),
              ),
            ),
            Container(
              width: screenWidth,
              height: 300,
              decoration: BoxDecoration(color: Colors.amber),
            )
          ],
        ),
      )),
    );
  }

  Widget buildAvatarRow(List<String> imagePaths, List<String> names) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(imagePaths.length, (index) {
        return Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(imagePaths[index]),
            ),
            SizedBox(height: 5),
            Text(
              names[index],
              style: TextStyle(fontSize: 14),
            ),
          ],
        );
      }),
    );
  }
}
