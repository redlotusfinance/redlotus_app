import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/user_submission_model.dart';

class SubmissionDetailScreen extends StatelessWidget {
  final UserSubmission submission;

  const SubmissionDetailScreen({super.key, required this.submission});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          submission.customerName ?? 'Submission Details',
          style: GoogleFonts.oswald(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionCard(
              context,
              'Personal Information',
              Icons.person_outline,
              [
                _buildDetailRow('Name', submission.customerName),
                _buildDetailRow('Date of Birth', submission.dateOfBirth?.toString().split(' ')[0]),
                _buildDetailRow('Spouse Name', submission.spouseName),
                _buildDetailRow('Father Name', submission.fatherName),
                _buildDetailRow('Mother Name', submission.motherName),
                _buildDetailRow('Loan Purpose', submission.loanPurpose),
                _buildDetailRow('Loan Type', submission.loanType),
                _buildDetailRow('Profession', submission.profession),
                if (submission.profession == 'Salaried') 
                  _buildDetailRow('Company Name', submission.companyName),
                if (submission.profession == 'Self-Employed') ...[
                  _buildDetailRow('Firm Type', submission.firmType),
                  _buildDetailRow('Designation', submission.selfEmployedDesignation),
                ],
                _buildDetailRow('Email', submission.email),
                _buildDetailRow('Phone', submission.phoneNumber),
                _buildDetailRow('Gender', submission.gender),
                _buildDetailRow('Marital Status', submission.maritalStatus),
              ],
            ),
            const SizedBox(height: 16),
            _buildSectionCard(
              context,
              'Address Details',
              Icons.location_on_outlined,
              [
                _buildDetailRow('Residence Type', submission.residenceType),
                if (submission.residenceType == 'Rented') 
                  _buildDetailRow('Rent Duration', submission.rentDuration),
                
                const SizedBox(height: 12),
                _buildAddressBlock('Current Address', 
                  '${submission.currentAddressLine1}, ${submission.currentAddressLine2 ?? ""}',
                  submission.currentLandmark ?? "",
                  '${submission.currentCity}, ${submission.currentDistrict}',
                  '${submission.currentState} - ${submission.currentPinCode}'
                ),
                
                const SizedBox(height: 12),
                if (submission.isPermanentSameAsCurrent == true)
                  _buildDetailRow('Permanent Address', 'Same as Current Address')
                else
                  _buildAddressBlock('Permanent Address',
                    '${submission.permanentAddressLine1}, ${submission.permanentAddressLine2 ?? ""}',
                    submission.permanentLandmark ?? "",
                    '${submission.permanentTaluka ?? ""}, ${submission.permanentCity ?? ""}',
                    '${submission.permanentDistrict}, ${submission.permanentState} - ${submission.permanentPinCode}'
                  ),
                
                const SizedBox(height: 12),
                _buildAddressBlock('Office Address',
                  submission.officeLandmark ?? "",
                  '${submission.officeTaluka ?? ""}, ${submission.officeCity ?? ""}',
                  '${submission.officeDistrict}, ${submission.officeState} - ${submission.officePinCode}',
                  ''
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSectionCard(
              context,
              'Financial Details',
              Icons.attach_money,
              [
                _buildDetailRow('PAN Number', submission.panNumber),
                _buildDetailRow('Monthly Income', submission.monthlyIncome?.toString()),
                _buildDetailRow('Monthly Commission', submission.monthlyCommission?.toString()),
                _buildDetailRow('CIBIL Score', submission.cibilScore),
                
                const Divider(height: 32),
                const Text('Existing Loans', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                if (submission.hasExistingLoans == true && submission.existingLoans != null && submission.existingLoans!.isNotEmpty)
                  ...submission.existingLoans!.map((loan) => 
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(child: Text('${loan['loanType']}', style: const TextStyle(fontWeight: FontWeight.w600))),
                          Text('${loan['bankName']}', style: TextStyle(color: Colors.grey.shade700)),
                          const SizedBox(width: 12),
                          Text('${loan['amount']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  )
                else
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text('No existing loans reported', style: TextStyle(color: Colors.grey)),
                  ),

                const SizedBox(height: 16),
                _buildDetailRow('Overdraft', submission.hasOverdraft == true ? 'Yes (${submission.overdraftAmount})' : 'No'),
                
                const Divider(height: 32),
                const Text('Bouncing Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
              ],
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'Submitted on: ${submission.submissionDate}',
                style: GoogleFonts.roboto(color: Colors.grey, fontStyle: FontStyle.italic),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(BuildContext context, String title, IconData icon, List<Widget> children) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).primaryColor, size: 24),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: GoogleFonts.oswald(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    if (value == null || value.isEmpty || value == 'null') return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressBlock(String label, String line1, String line2, String line3, String line4) {
    final address = [line1, line2, line3, line4].where((s) => s.trim().isNotEmpty && s != 'null').join('\n');
    if (address.replaceAll(RegExp(r'[\s\n,]+'), '').isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black54)),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Text(address, style: const TextStyle(height: 1.4)),
          ),
        ],
      ),
    );
  }
}
