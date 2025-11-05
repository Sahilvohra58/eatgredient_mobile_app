import 'package:flutter/material.dart';

import '../profile/Profile Screen.dart';

//colors
const Color primaryGreen = Color(0xFF4CAF50);
const Color lightGreenBackground = Color(0xFFE9F5E9);
const Color titleColor = Color(0xFF424242);
const Color textColor = Color(0xFF616161);
const double defaultPadding = 20.0;

class ProductLibraryScreen extends StatelessWidget {
  const ProductLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  //  App Bar Implementation
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 50,
      leading: const SizedBox.shrink(),
      title: const Text(
        'EatGrediant',
        style: TextStyle(
          color: primaryGreen,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            radius: 14,
            backgroundImage: AssetImage('assets/images/pp.png'),
            backgroundColor: Colors.grey,
          ),
        ),
      ],
    );
  }

  // Body Implementation
  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 8),
            child: Text(
              'My Product Library',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: defaultPadding, right: defaultPadding, bottom: 16),
            child: Text(
              'All the products you\'ve scanned and analyzed in one place.',
              style: TextStyle(
                fontSize: 14,
                color: textColor.withOpacity(0.8),
              ),
            ),
          ),

          // Search Bar
          _buildSearchBar(),
          const SizedBox(height: 16),

          // Buttons
          _buildActionButtons(),
          const SizedBox(height: 24),

          // Product Cards
          _buildProductCard(title: 'Product 1', date: 'Oct 20, 2025'),
          _buildProductCard(title: 'Product 2', date: 'Oct 20, 2025'),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
            border: InputBorder.none,
            icon: Icon(Icons.search, color: textColor.withOpacity(0.7)),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Scan New Product',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: primaryGreen, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                foregroundColor: primaryGreen,
              ),
              onPressed: () {

              },
              child: const Text(
                'Add New Product Manually',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: primaryGreen,
                ),
              ),
            ),
          )

        ],
      ),
    );
  }

  Widget _buildProductCard({required String title, required String date}) {
    return Padding(
      padding: const EdgeInsets.only(left: defaultPadding, right: defaultPadding, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: lightGreenBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Container(
                  width: 329,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/corn.png',
                      height: 329,
                      width: 329,

                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_outlined, size: 80, color: textColor),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildDetailsGrid(date: date),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsGrid({required String date}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDetailItem(label: 'Product Name', value: 'Nestlé Corn Flakes'),
            _buildDetailItem(label: 'Brand', value: 'Nestlé'),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDetailItem(label: 'Category', value: 'Breakfast Cereal'),
            _buildDetailItem(label: 'Weight', value: '475g'),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDetailItem(label: 'Date Added', value: date),
            _buildDetailItem(
              label: 'Action',
              valueWidget: IconButton(
                icon: const Icon(Icons.more_vert, color: textColor),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailItem({required String label, String? value, Widget? valueWidget}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: titleColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          valueWidget ??
              Text(
                value ?? '',
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black26,

                  fontWeight: FontWeight.w500,
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(context) {
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
          Image.asset(
            'assets/images/home.png',
            width: 26,
            height: 26,
            color: textColor,
            errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.home_outlined, color: textColor, size: 26),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            decoration: BoxDecoration(
              color: primaryGreen,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/box.png',
                  width: 20,
                  height: 20,
                  color: Colors.white,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.archive, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Product Library",
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
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            child: Image.asset(
              'assets/images/profile.png',
              width: 26,
              height: 26,
              color: textColor,
            ),
          ),

        ],
      ),
    );
  }
}
