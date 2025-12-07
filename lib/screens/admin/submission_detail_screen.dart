import 'package:flutter/material.dart';
import '../../models/user_submission_model.dart';

class SubmissionDetailScreen extends StatelessWidget {
  final UserSubmission submission;

  const SubmissionDetailScreen({super.key, required this.submission});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(submission.customerName ?? 'Submission Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, 'Personal Information'),
            _buildDetailRow('Name', submission.customerName),
            _buildDetailRow('Date of Birth', submission.dateOfBirth?.toString().split(' ')[0]),
            _buildDetailRow('Spouse Name', submission.spouseName),
            _buildDetailRow('Father Name', submission.fatherName),
            _buildDetailRow('Mother Name', submission.motherName),
            _buildDetailRow('Loan Purpose', submission.loanPurpose),
            _buildDetailRow('Loan Type', submission.loanType),
            _buildDetailRow('Profession', submission.profession),
            if (submission.profession == 'Salaried') _buildDetailRow('Company Name', submission.companyName),
            if (submission.profession == 'Self-Employed') ...[
              _buildDetailRow('Firm Type', submission.firmType),
              _buildDetailRow('Designation', submission.selfEmployedDesignation),
            ],
            _buildDetailRow('Email', submission.email),
            _buildDetailRow('Phone', submission.phoneNumber),
            _buildDetailRow('Gender', submission.gender),
            _buildDetailRow('Marital Status', submission.maritalStatus),

            const SizedBox(height: 24),
            _buildSectionHeader(context, 'Address Details'),
            _buildDetailRow('Residence Type', submission.residenceType),
            if (submission.residenceType == 'Rented') _buildDetailRow('Rent Duration', submission.rentDuration),
            _buildDetailRow('Current Address', 
              '${submission.currentAddressLine1}, ${submission.currentAddressLine2 ?? ""}\n'
              '${submission.currentLandmark ?? ""}\n'
              '${submission.currentCity}, ${submission.currentDistrict}\n'
              '${submission.currentState} - ${submission.currentPinCode}'),
            const SizedBox(height: 8),
            const Text('Permanent Address:', style: TextStyle(fontWeight: FontWeight.bold)),
            if (submission.isPermanentSameAsCurrent == true)
              const Text('Same as Current Address')
            else
              Text('${submission.permanentAddressLine1}, ${submission.permanentAddressLine2 ?? ""}\n'
                   '${submission.permanentLandmark ?? ""}\n'
                   '${submission.permanentTaluka ?? ""}, ${submission.permanentCity ?? ""}\n'
                   '${submission.permanentDistrict}, ${submission.permanentState} - ${submission.permanentPinCode}'),
            const SizedBox(height: 8),
            const Text('Office Address:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('${submission.officeLandmark ?? ""}\n'
                 '${submission.officeTaluka ?? ""}, ${submission.officeCity ?? ""}\n'
                 '${submission.officeDistrict}, ${submission.officeState} - ${submission.officePinCode}'),

            const SizedBox(height: 24),
            _buildSectionHeader(context, 'Financial Details'),
            _buildDetailRow('PAN Number', submission.panNumber),
            _buildDetailRow('Monthly Income', submission.monthlyIncome?.toString()),
            _buildDetailRow('Monthly Commission', submission.monthlyCommission?.toString()),
            _buildDetailRow('CIBIL Score', submission.cibilScore),
            
            const SizedBox(height: 8),
            const Text('Existing Loans:', style: TextStyle(fontWeight: FontWeight.bold)),
            if (submission.hasExistingLoans == true && submission.existingLoans != null)
              ...submission.existingLoans!.map((loan) => 
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                  child: Text('• ${loan['loanType']} from ${loan['bankName']}: ${loan['amount']}'),
                )
              )
            else
              const Text('No existing loans'),

            _buildDetailRow('Overdraft', submission.hasOverdraft == true ? 'Yes (${submission.overdraftAmount})' : 'No'),
            
            const SizedBox(height: 16),
            const Text('Bouncing Details:', style: TextStyle(fontWeight: FontWeight.bold)),
            _buildDetailRow('Overdue', submission.hasOverdue == true ? 'Yes' : 'No'),
            if (submission.hasOverdue == true) ...[
              _buildDetailRow('Overdue Loan Type', submission.overdueLoanType),
              _buildDetailRow('Overdue Amount', submission.overdueAmount?.toString()),
              _buildDetailRow('Bouncing Status', submission.bouncingStatus),
              if (submission.bouncingStatus == 'Yes') ...[
                _buildDetailRow('Bouncing Months', submission.bouncingMonths),
                _buildDetailRow('Bouncing Days', submission.bouncingDays?.toString()),
              ]
            ],
            
            const SizedBox(height: 24),
            Text('Submitted on: ${submission.submissionDate}', style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text('$label:', style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.grey)),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
