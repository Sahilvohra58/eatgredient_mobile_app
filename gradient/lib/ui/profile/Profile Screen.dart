import 'package:flutter/material.dart';

// colors
const Color primaryGreen = Color(0xFF4CAF50); //
const Color lightGreenBackground = Color(0xFFE9F5E9);
const Color titleColor = Color(0xFF424242);
const Color textColor = Color(0xFF616161);
const double defaultPadding = 20.0;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

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
            backgroundImage: AssetImage(
              'assets/images/pp.png',
            ),
            backgroundColor: Colors.grey[200],
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Title
          const Text(
            'My Profile',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 25),

          _buildMainProfileAvatar(),
          const SizedBox(height: 13),

          _buildSectionHeader('Personal Info'),
          _buildInputField(label: 'Name', hint: 'John Doe'),
          _buildInputField(label: 'Email', hint: 'johndoe3@gmail.com'),
          const SizedBox(height: 5),

          _buildSectionHeader('Security'),
          _buildInputField(label: 'Current Password', hint: 'Enter Password', isPassword: true),
          _buildInputField(label: 'New Password', hint: 'Enter Password', isPassword: true),
          _buildInputField(label: 'Confirm Password', hint: 'Enter Password', isPassword: true),
          const SizedBox(height: 13),

          _buildSaveChangesButton(),
          const SizedBox(height: 17),
        ],
      ),
    );
  }


  Widget _buildMainProfileAvatar() {
    return Center(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/prifilepic.png',
              width: 98,
              height: 98,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 98,
                height: 98,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 16),
              ),
            ),
          ),

          const SizedBox(height: 8),
          const Text(
            'Update',
            style: TextStyle(
              color: primaryGreen,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  //section headers
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildInputField({required String label, required String hint, bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            obscureText: isPassword,
            style: const TextStyle(color: textColor, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: textColor.withOpacity(0.5), fontWeight: FontWeight.w400),
              contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: primaryGreen, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveChangesButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () {

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
          'Save Changes',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
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

          Image.asset(
            'assets/images/home.png',
            width: 26,
            height: 26,
            color: textColor.withOpacity(0.7),
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.home_outlined, color: textColor, size: 26),
          ),


          Image.asset(
            'assets/images/box.png',
            width: 26,
            height: 26,
            color: textColor.withOpacity(0.7),
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.archive_outlined, color: textColor, size: 26),
          ),


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
                  'assets/images/profile.png',
                  width: 20,
                  height: 20,
                  color: Colors.white,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
