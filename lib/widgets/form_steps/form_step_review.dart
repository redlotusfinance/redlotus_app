import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/form_provider.dart';

class FormStepReview extends StatelessWidget {
  final VoidCallback onEditPersonal;
  final VoidCallback onEditAddress;
  final VoidCallback onEditFinancial;

  const FormStepReview({
    super.key,
    required this.onEditPersonal,
    required this.onEditAddress,
    required this.onEditFinancial,
  });

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context, listen: false);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Review Your Information', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 24),
            _buildReviewSection(
              'Personal Information',
              {
                'Name': formProvider.customerName,
                'Date of Birth': "${formProvider.dateOfBirth?.toLocal()}".split(' ')[0],
                'Loan Purpose': formProvider.loanPurpose ?? 'N/A',
                'Profession': formProvider.profession ?? 'N/A',
                'Email': formProvider.email,
                'Phone': formProvider.phoneNumber,
                'Gender': formProvider.gender ?? 'N/A',
                'Marital Status': formProvider.maritalStatus ?? 'N/A',
              },
              context,
              onEditPersonal,
            ),
            const SizedBox(height: 16),
            _buildReviewSection(
              'Address Details',
              {
                'Current Address': '${formProvider.currentAddressLine1}, ${formProvider.currentCity}',
                // Add more address fields...
              },
              context,
              onEditAddress,
            ),
            const SizedBox(height: 16),
            _buildReviewSection(
              'Financial Details',
              {
                'Monthly Income': '\$${formProvider.monthlyIncome?.toStringAsFixed(2) ?? '0.00'}',
                // Add more financial fields...
              },
              context,
              onEditFinancial,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewSection(String title, Map<String, String> data, BuildContext context, VoidCallback onEdit) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: onEdit,
                ),
              ],
            ),
            const Divider(),
            ...data.entries.map((entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text('${entry.key}:', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(entry.value),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
