import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/form_provider.dart';
import 'bank_results_screen.dart';

class SubmissionSuccessScreen extends StatelessWidget {
  const SubmissionSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submission Successful'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 100),
              const SizedBox(height: 24),
              Text(
                'Thank You!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              const Text(
                'Your loan application has been submitted successfully. We will review your information and get back to you shortly.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // Get the form data from the provider
                  final formProvider = Provider.of<FormProvider>(context, listen: false);
                  
                  // Navigate to results screen with the data
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BankResultsScreen(
                        loanPurpose: formProvider.loanPurpose ?? 'Personal', 
                        monthlyIncome: formProvider.monthlyIncome ?? 0,
                        existingLoans: formProvider.existingLoansList,
                      ),
                    ),
                  );
                },
                child: const Text('See Matched Banks'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Navigate back to the home screen
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
