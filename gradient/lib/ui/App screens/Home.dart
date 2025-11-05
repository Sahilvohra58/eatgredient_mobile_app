import 'package:flutter/material.dart';
import 'package:gradient/ui/App%20screens/Manualy%20Entry.dart';
import 'package:gradient/ui/Library/Product%20Library.dart';


import 'Scan Product.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,


      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "EatGrediant",
                      style: TextStyle(
                        color: Color(0xFF4CAF50),
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage('assets/images/pp.png'),
                    ),
                  ],
                ),

                const SizedBox(height: 25),


                const Text(
                  "Discover what’s\ninside your food",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    height: 1.3,
                  ),
                ),

                const SizedBox(height: 8),


                const Text(
                  "Extracts product name and brand information from a food product image.",
                  style: TextStyle(
                    color: Color(0xff505050),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 30),

                // QR SCANNER SECTION
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [

                      Image.asset(
                        'assets/images/qr.png',
                        width: 350,
                        height: 340,
                        fit: BoxFit.contain,
                      ),


                      Image.asset(
                        'assets/images/qr_scanner.png',
                        width: 350,
                        height: 340,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.remove, color: Colors.grey, size: 27),
                    Expanded(
                      child: Slider(
                        value: 0,
                        onChanged: (value) {},
                        activeColor: const Color(0xFF4CAF50),
                        inactiveColor: Colors.grey[300],
                      ),
                    ),
                    const Icon(Icons.add, color: Colors.grey, size: 27),
                  ],
                ),

                const SizedBox(height: 20),

                // SCAN PRODUCT BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductDetailsScreen()
                        ),
                      );



                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "Scan Product",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // MANUAL ENTRY BUTTON (OUTLINE)
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {


                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ManuallyScreen()),
                      );


                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF4CAF50), width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "Manually Entry",
                      style: TextStyle(
                        color: Color(0xFF4CAF50),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),

      // BOTTOM NAVIGATION BAR
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/home.png',
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Home",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),


            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProductLibraryScreen()),
                );
              },
              child: Image.asset(
                'assets/images/box.png',
                width: 26,
                height: 26,
              ),
            ),


            // Profile Icon
            Image.asset(
              'assets/images/profile.png',
              width: 26,
              height: 26,
            ),
          ],
        ),
      ),
    );
  }
}
