import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../main.dart'; // Corrected import path

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Scaffold(
      // Add the AppBar here
      appBar: AppBar(
        title: Text(
          'RedFin',
          style: GoogleFonts.oswald(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(
              Icons.admin_panel_settings,
              color: Colors.grey[700],
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/admin');
            },
            tooltip: 'Admin Panel',
          ),
          IconButton(
            icon: Icon(
              themeProvider.themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
              color: Colors.grey[700],
            ),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: 'Toggle Theme',
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Stack(
        children: [
          _buildBackground(),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 64.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildHeroSection(context),
                    const SizedBox(height: 80),
                    _buildHowItWorksSection(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade50, Colors.grey.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'Find Your Perfect Loan in Minutes',
          textAlign: TextAlign.center,
          style: GoogleFonts.oswald(
            fontSize: 52,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0A2540),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'RedFin helps you compare and find the best loan offers from top banks, tailored to your financial profile.',
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
            fontSize: 18,
            color: Colors.black54,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 48),
        _buildGetStartedButton(context),
      ],
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [Colors.green.shade400, Colors.green.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, '/form'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(
          'Get Started',
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildHowItWorksSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'How It Works',
          style: GoogleFonts.oswald(
            fontSize: 36,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF0A2540),
          ),
        ),
        const SizedBox(height: 48),
        Wrap(
          spacing: 40,
          runSpacing: 40,
          alignment: WrapAlignment.center,
          children: [
            _buildStepCard(
              context,
              icon: Icons.person_search,
              title: '1. Tell Us About Yourself',
              description: 'Complete our simple and secure form with your personal and financial details.',
            ),
            _buildStepCard(
              context,
              icon: Icons.compare_arrows,
              title: '2. See Your Matches',
              description: 'We analyze your profile to match you with the best loan options from our partner banks.',
            ),
            _buildStepCard(
              context,
              icon: Icons.approval,
              title: '3. Get Approved',
              description: 'Choose the best offer and proceed to get your loan approved quickly and easily.',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStepCard(BuildContext context, {required IconData icon, required String title, required String description}) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 48, color: Colors.green.shade500),
          const SizedBox(height: 24),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0A2540),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: Colors.black54,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
