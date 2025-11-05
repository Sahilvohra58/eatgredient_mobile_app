import 'package:flutter/material.dart';
import 'package:gradient/ui/App%20screens/Home.dart';
import 'package:gradient/ui/App%20screens/Manualy%20Entry.dart';

// colors app
const Color primaryGreen = Color(0xFF4CAF50);
const Color secondaryBackground = Color(0xFFF0F4F0);
const Color titleColor = Color(0xFF424242);
const Color textColor = Color(0xFF616161);
const double defaultPadding = 20.0;

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 50,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {

        },
      ),
      title: const Text(
        'EatGrediant',
        style: TextStyle(
          color: titleColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            radius: 14,
            backgroundImage: AssetImage(
              'assets/images/pp.png',
            ),
            backgroundColor: Colors.grey[200],
          ),
        ),
      ],
    );
  }


  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Product Details',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Barcode: 3901234567890',
                  style: TextStyle(
                    fontSize: 14,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),

          _buildSectionCard(
            title: 'Product Overview',
            child: Column(
              children: [
                // Product Image
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Image.asset(
                    'assets/images/corn.png',
                    height: 299,
                    width: 319,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        alignment: Alignment.center,
                        color: Colors.white,
                        child: const Icon(Icons.image_not_supported, size: 50, color: primaryGreen),
                      );
                    },
                  ),
                ),
                const Divider(height: 25, thickness: 1, color: Color(0xFFE0E0E0)),
                // Product Details
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildDetailPair(
                        label: 'Product Name',
                        value: 'Nestle Corn Flakes',
                      ),
                    ),
                    Expanded(
                      child: _buildDetailPair(
                        label: 'Brand',
                        value: 'Nestle',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildDetailPair(
                        label: 'Category',
                        value: 'Breakfast Cereal',
                      ),
                    ),
                    Expanded(
                      child: _buildDetailPair(
                        label: 'Weight',
                        value: '475g',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          _buildSectionCard(
            title: 'Ingredients',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Corn (88%), Sugar, Malt Extract, Salt, Vitamins (B1, B2, B3, B6, B9, B12), Iron.',
                  style: TextStyle(fontSize: 14.5, color: textColor),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Allergens',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: titleColor,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'May contain traces of nuts or gluten.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff505050),

                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Nutrition Facts Section
          _buildSectionCard(
            title: 'Nutrition Facts (per 30g serving)',
            child: _buildNutritionGrid(),
          ),

          const SizedBox(height: 16),

          _buildSectionCard(
            title: 'Health Insights',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInsightBullet('Low fat'),
                _buildInsightBullet('High sugar content'),
                _buildInsightBullet('Fortified with vitamins and iron'),
              ],
            ),
          ),

          const SizedBox(height: 30),

      //button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19),
                  ),
                  elevation: 4,
                  shadowColor: primaryGreen.withOpacity(0.4),
                ),
                child: const Text(
                  'Add to Library',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: secondaryBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  // Helper to build the small label/value pairs in the Product Overview
  Widget _buildDetailPair({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14.5,
            fontWeight: FontWeight.w600,
            color: titleColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,

            color: textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildNutritionGrid() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNutritionFact('Energy', '182 kcal'),
            _buildNutritionFact('Protein', '2.5 g'),
            _buildNutritionFact('Fat', '0.4 g'),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNutritionFact('Carbohydrates', '25 g'),
            _buildNutritionFact('Sugars', '9 g'),
            _buildNutritionFact('Sodium', '0.3 g'),
          ],
        ),
      ],
    );
  }

  Widget _buildNutritionFact(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w600,
              color: titleColor,

            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '•',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              height: 1.0,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14.5,
                color: titleColor,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildBottomNavigationBar() {
    return Container(
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
              color: primaryGreen,
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
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.home, color: Colors.white, size: 20),
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

          Image.asset(
            'assets/images/box.png',
            width: 26,
            height: 26,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.archive_outlined, color: textColor, size: 26),
          ),


          Image.asset(
            'assets/images/profile.png',
            width: 26,
            height: 26,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.person_outline, color: textColor, size: 26),
          ),
        ],
      ),
    );
  }
}

