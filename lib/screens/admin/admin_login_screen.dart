import 'package:flutter/material.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Hardcoded credentials for this version
      const String correctUsername = 'RedLotusAdmin';
      const String correctPassword = 'AdminRedLotus';

      if (_usernameController.text == correctUsername && _passwordController.text == correctPassword) {
        // On success, navigate to the dashboard, replacing the login screen
        Navigator.pushReplacementNamed(context, '/admin-dashboard');
      } else {
        // On failure, show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid username or password.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Login'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Card(
            elevation: 8,
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Admin Access',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) => value!.isEmpty ? 'Please enter a username' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true, // Hide password
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value) => value!.isEmpty ? 'Please enter a password' : null,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                      ),
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
