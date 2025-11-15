import 'package:flutter/material.dart';
import '../models/bank_model.dart';

class BankCard extends StatelessWidget {
  final Bank bank;

  const BankCard({super.key, required this.bank});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(bank.logoUrl, width: 100, height: 50),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(bank.name, style: Theme.of(context).textTheme.headlineSmall),
                      Text(bank.tagline, style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoColumn('Approval Rate', '${bank.approvalRate}%'),
                _buildInfoColumn('Interest Rate', '${bank.interestRate['min']}% - ${bank.interestRate['max']}%'),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Key Features:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...bank.keyFeatures.map((feature) => Text('• $feature')),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // TODO: Implement eligibility check
                  },
                  child: const Text('Check Eligibility'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Redirect to application URL
                  },
                  child: const Text('Apply Now'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }
}
