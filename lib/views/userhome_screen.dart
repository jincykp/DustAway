import 'package:dustaway/core/theme/colors.dart';
import 'package:dustaway/core/widgets/cards.dart';
import 'package:dustaway/views/service_listing_screen.dart';
import 'package:flutter/material.dart';

class UserhomeScreen extends StatelessWidget {
  const UserhomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 246, 246),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Column(children: [
                Center(
                  child: Image.asset(
                    'assets/images/👋.png',
                    width: 25,
                    height: 25,
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
                  child:
                      Image.asset('assets/images/perfectcleaningservice.png'),
                ),
                SizedBox(
                  height: 20,
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
                        hintStyle: TextStyle(
                            color: AppColors.textGreyColor, fontSize: 13),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.all(1),
                  padding: EdgeInsets.all(8),
                  width: screenWidth,
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      border: Border.all(color: AppColors.greyColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Available Services",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(height: 10),
                        buildAvatarRow(
                          [
                            "assets/images/cleaningitems.png",
                            "assets/images/wastedisposal.png",
                            "assets/images/plumping.png",
                            "assets/images/plumping.png"
                          ],
                          [
                            "Cleaning",
                            "Waste Disposal",
                            "Plumbing",
                            "Electrical"
                          ],
                        ),
                        SizedBox(height: 10),
                        buildAvatarRow(
                          [
                            "assets/images/cleaningitems.png",
                            "assets/images/wastedisposal.png",
                            "assets/images/plumping.png",
                            "assets/images/seemore.png"
                          ],
                          ["Cleaning", "Waste Disposal", "Plumbing", "See All"],
                          specialIndex: 3, // Last item different
                          specialTextColor: AppColors.specialTextColor,

                          // Change text color for the last item
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "Cleaning Services",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ServiceListingScreen()));
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(color: AppColors.specialTextColor),
                        )),
                    Icon(
                      Icons.chevron_right,
                      size: 25,
                      color: AppColors.baseColor,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                HorizontalCardList(),
              ]),
            ),
          ),
        ));
  }

  Widget buildAvatarRow(
    List<String> imagePaths,
    List<String> names, {
    int? specialIndex,
    Color? specialTextColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(imagePaths.length, (index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(imagePaths[index]),
            ),
            SizedBox(height: 5),
            Text(
              names[index],
              style: TextStyle(
                fontSize: 10,
                color:
                    (index == specialIndex) ? specialTextColor : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      }),
    );
  }
}
