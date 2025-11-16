import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'providers/form_provider.dart';
import 'providers/bank_provider.dart';
import 'screens/multi_step_form_screen.dart';
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
      child: const FinCareApp(),
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

class FinCareApp extends StatelessWidget {
  const FinCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the primary color seeds
    const Color primarySeedColor = Color(0xFF0A2540); // Trustworthy blue
    const Color accentSeedColor = Color(0xFF2ECC71); // Accent green

    // Define a common TextTheme using Google Fonts
    final TextTheme appTextTheme = TextTheme(
      displayLarge: GoogleFonts.oswald(fontSize: 57, fontWeight: FontWeight.bold),
      displayMedium: GoogleFonts.oswald(fontSize: 45, fontWeight: FontWeight.bold),
      displaySmall: GoogleFonts.oswald(fontSize: 36, fontWeight: FontWeight.bold),
      headlineLarge: GoogleFonts.oswald(fontSize: 32, fontWeight: FontWeight.w500),
      headlineMedium: GoogleFonts.oswald(fontSize: 28, fontWeight: FontWeight.w500),
      headlineSmall: GoogleFonts.oswald(fontSize: 24, fontWeight: FontWeight.w500),
      titleLarge: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.w500),
      titleMedium: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),
      titleSmall: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500),
      bodyLarge: GoogleFonts.roboto(fontSize: 16),
      bodyMedium: GoogleFonts.roboto(fontSize: 14),
      bodySmall: GoogleFonts.roboto(fontSize: 12),
      labelLarge: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.bold),
      labelMedium: GoogleFonts.roboto(fontSize: 12),
      labelSmall: GoogleFonts.roboto(fontSize: 11),
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
      textTheme: appTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: primarySeedColor,
        foregroundColor: Colors.white,
        titleTextStyle: GoogleFonts.oswald(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: accentSeedColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
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
      textTheme: appTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        titleTextStyle: GoogleFonts.oswald(fontSize: 24, fontWeight: FontWeight.bold),
      ),
       elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: accentSeedColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'FinCare',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeProvider.themeMode,
          home: const HomePage(),
          routes: {
            '/form': (context) => const MultiStepFormScreen(),
            '/admin': (context) => const AdminDashboardScreen(),
            '/success': (context) => const SubmissionSuccessScreen(),
          },
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
     final themeProvider = Provider.of<ThemeProvider>(context);
     return Scaffold(
      appBar: AppBar(
        title: const Text('FinCare'),
        actions: [
          IconButton(
            icon: const Icon(Icons.admin_panel_settings),
            onPressed: () {
              Navigator.pushNamed(context, '/admin');
            },
            tooltip: 'Admin Panel',
          ),
           IconButton(
            icon: Icon(themeProvider.themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // We will add the FinCare logo here later
            // Image.asset('assets/logo.png', width: 150), 
            const SizedBox(height: 40),
            Text(
              'Welcome to FinCare',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'Your partner in financial need.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/form');
              },
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
