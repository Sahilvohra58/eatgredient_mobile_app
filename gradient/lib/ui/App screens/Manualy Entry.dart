import 'package:flutter/material.dart';

import 'Add Product Screen.dart';
// Screen Colors
const Color primaryGreen = Color(0xFF4CAF50);
const Color secondaryBackground = Colors.white;
const Color titleColor = Color(0xFF424242);
const Color textColor = Color(0xFF616161);
const double defaultPadding = 20.0;
const Color borderColor = Color(0xFFBDBDBD);

class ManuallyScreen extends StatelessWidget {
  const ManuallyScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: _buildBody( context),
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
              'assets/images/profile_avatar.png',
            ),
            backgroundColor: Colors.grey[200],
          ),
        ),
      ],
    );
  }

  Widget _buildBody( context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 8),
            child: Text(
              'Add Product',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 16),


          Text(
            'Upload Photo',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: titleColor,
            ),
          ),
          SizedBox(height: 5,),
          _buildPhotoUploadCard(),


          const SizedBox(height: 16),
          _buildFormSection(),

          const SizedBox(height: 30),


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
                        builder: (context) => const AddProductScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 4,
                  shadowColor: primaryGreen.withOpacity(0.4),
                ),
                child: const Text(
                  'Add Product',
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

  // function for the Photo Upload area
  Widget _buildPhotoUploadCard() {
    return Container(
      width: 365,
      height: 165,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // ⬅️ Reduced padding
      decoration: BoxDecoration(
        color: secondaryBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey,
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          const SizedBox(height: 12),
          Image.asset(
            'assets/images/upload.png',
            width: 40,
            height: 40,
            color: primaryGreen,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.cloud_upload_outlined,
              size: 40,
              color: primaryGreen,
            ),
          ),

          const SizedBox(height: 8),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Click to upload ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryGreen,
                  ),
                ),
                TextSpan(
                  text: 'or drag and drop',
                  style: TextStyle(
                    fontSize: 14,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 4),
          Text(
            'SVG, PNG, JPG or GIF (max. 800x400px)',
            style: TextStyle(
              fontSize: 12,
              color: textColor.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildFormSection() {

    final List<String> fieldLabels = [
      'Product Name', 'Brand', 'Category', 'Weight', 'Ingredients', 'Allergens',
      'Energy', 'Protein', 'Fat', 'Carbohydrates', 'Sugar', 'Sodium'
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        children: fieldLabels.map((label) => _buildInputField(label: label)).toList(),
      ),
    );
  }


  Widget _buildInputField({required String label}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter',
              hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
              contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              filled: true,
              fillColor: secondaryBackground,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.grey,),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.grey, width: 2),
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