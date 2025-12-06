import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'providers/form_provider.dart';
import 'providers/bank_provider.dart';
import 'screens/home_screen.dart';
import 'screens/multi_step_form_screen.dart';
import 'screens/admin/admin_login_screen.dart'; // Import the new login screen
import 'screens/admin/admin_dashboard_screen.dart';
import 'screens/submission_success_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => FormProvider()),
        ChangeNotifierProvider(create: (context) => BankProvider()),
      ],
      child: const RedFinApp(),
    ),
  );
}

// Manages the application's theme state.
class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class RedFinApp extends StatelessWidget {
  const RedFinApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the primary color seeds
    const Color primarySeedColor = Color(0xFF0A2540); // Trustworthy blue
    const Color accentSeedColor = Color(0xFF2ECC71); // Accent green

    // Define a common TextTheme using Google Fonts
    final TextTheme appTextTheme = TextTheme(
      displayLarge: GoogleFonts.oswald(fontSize: 57, fontWeight: FontWeight.bold),
      // ... (rest of the text theme)
    );

    // Light Theme Configuration
    final ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primarySeedColor,
        primary: primarySeedColor,
        secondary: accentSeedColor,
        background: const Color(0xFFF8F9FA), // Clean white
        surface: Colors.white,
        brightness: Brightness.light,
      ),
      // ... (rest of the light theme)
    );

    // Dark Theme Configuration
    final ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primarySeedColor,
        primary: primarySeedColor,
        secondary: accentSeedColor,
        background: const Color(0xFF121212),
        surface: const Color(0xFF1E1E1E),
        brightness: Brightness.dark,
      ),
      // ... (rest of the dark theme)
    );

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'RedFin',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeProvider.themeMode,
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
          routes: {
            '/form': (context) => const MultiStepFormScreen(),
            '/admin': (context) => const AdminLoginScreen(), // '/admin' now points to the login screen
            '/admin-dashboard': (context) => const AdminDashboardScreen(), // New route for the dashboard
            '/success': (context) => const SubmissionSuccessScreen(),
          },
        );
      },
    );
  }
}
