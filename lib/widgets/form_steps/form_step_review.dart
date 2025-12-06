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
                'Spouse Name': formProvider.spouseName ?? 'N/A',
                'Father Name': formProvider.fatherName ?? 'N/A',
                'Mother Name': formProvider.motherName ?? 'N/A',
                'Loan Purpose': formProvider.loanPurpose ?? 'N/A',
                'Loan Type': formProvider.loanType ?? 'N/A',
                'Profession': formProvider.profession ?? 'N/A',
                if (formProvider.profession == 'Salaried') 'Company Name': formProvider.companyName ?? 'N/A',
                if (formProvider.profession == 'Self-Employed') 'Type of Firm': formProvider.firmType ?? 'N/A',
                if (formProvider.profession == 'Self-Employed') 'Designation': formProvider.selfEmployedDesignation ?? 'N/A',
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
                'Residence Type': formProvider.residenceType ?? 'N/A',
                if (formProvider.residenceType == 'Rented') 'Rent Duration': formProvider.rentDuration ?? 'N/A',
                'Current Address': '${formProvider.currentAddressLine1}, ${formProvider.currentAddressLine2}, ${formProvider.currentLandmark}, ${formProvider.currentCity}, ${formProvider.currentDistrict}, ${formProvider.currentState} - ${formProvider.currentPinCode}',
                'Permanent Address': formProvider.isPermanentSameAsCurrent
                    ? 'Same as Current Address'
                    : '${formProvider.permanentAddressLine1}, ${formProvider.permanentAddressLine2}, ${formProvider.permanentLandmark}, ${formProvider.permanentTaluka}, ${formProvider.permanentCity}, ${formProvider.permanentDistrict}, ${formProvider.permanentState} - ${formProvider.permanentPinCode}',
                'Office Address': '${formProvider.officeLandmark}, ${formProvider.officeTaluka}, ${formProvider.officeCity}, ${formProvider.officeDistrict}, ${formProvider.officeState} - ${formProvider.officePinCode}',
              },
              context,
              onEditAddress,
            ),
            const SizedBox(height: 16),
            _buildReviewSection(
              'Financial Details',
              {
                'Pan No': formProvider.panNumber ?? 'N/A',
                'Monthly Income': formProvider.monthlyIncome?.toString() ?? 'N/A',
                'Monthly Commission': formProvider.monthlyCommission?.toString() ?? 'N/A',
                'Cibil Score': formProvider.cibilScore ?? 'N/A',
                'Existing Loans': formProvider.hasExistingLoans ? 'Yes' : 'No',
                'Overdraft': formProvider.hasOverdraft ? 'Yes (Amount: ${formProvider.overdraftAmount})' : 'No',
                'Overdue': formProvider.hasOverdue ? 'Yes (Amount: ${formProvider.overdueAmount})' : 'No',
                if (formProvider.hasOverdue) 'Loan Details of Overdue': formProvider.overdueLoanType ?? 'N/A',
                'Bouncing': formProvider.bouncingStatus ?? 'No',
                if (formProvider.bouncingStatus == 'Yes') 'Bouncing Months': formProvider.bouncingMonths ?? 'N/A',
                if (formProvider.bouncingStatus == 'Yes') 'Bouncing Days': formProvider.bouncingDays?.toString() ?? 'N/A',
              },
              context,
              onEditFinancial,
            ),
            if (formProvider.hasExistingLoans && formProvider.existingLoansList.isNotEmpty) ...[
              const SizedBox(height: 16),
              Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Existing Loans List', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const Divider(),
                      ...formProvider.existingLoansList.asMap().entries.map((entry) {
                        int idx = entry.key + 1;
                        var loan = entry.value;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text('$idx. ${loan.loanType} from ${loan.bankName} (${loan.amount})'),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
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
