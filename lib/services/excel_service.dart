import 'package:excel/excel.dart';
import '../models/user_submission_model.dart';

class ExcelService {
  List<int>? generateExcel(List<UserSubmission> submissions) {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    // Add Header Row
    List<String> headers = [
      'Customer Name',
      'Phone',
      'Email',
      'Date of Birth',
      'Spouse Name',
      'Father Name',
      'Mother Name',
      'Loan Purpose',
      'Loan Type',
      'Profession',
      'Company Name',
      'Firm Type',
      'Designation',
      'Gender',
      'Marital Status',
      'Monthly Income',
      'Monthly Commission',
      'PAN Number',
      'CIBIL Score',
      'Current Address',
      'Permanent Address',
      'Office Address',
      'Existing Loans',
      'Overdraft',
      'Overdue Status',
      'Overdue Loan Type',
      'Overdue Amount',
      'Bouncing Status',
      'Bouncing Months',
      'Bouncing Days',
      'Submission Date',
    ];
    sheetObject.appendRow(headers.map((e) => TextCellValue(e)).toList());

    // Add Data Rows
    for (var submission in submissions) {
      List<CellValue> row = [
        TextCellValue(submission.customerName ?? ''),
        TextCellValue(submission.phoneNumber ?? ''),
        TextCellValue(submission.email ?? ''),
        TextCellValue(submission.dateOfBirth?.toString().split(' ')[0] ?? ''),
        TextCellValue(submission.spouseName ?? ''),
        TextCellValue(submission.fatherName ?? ''),
        TextCellValue(submission.motherName ?? ''),
        TextCellValue(submission.loanPurpose ?? ''),
        TextCellValue(submission.loanType ?? ''),
        TextCellValue(submission.profession ?? ''),
        TextCellValue(submission.companyName ?? ''),
        TextCellValue(submission.firmType ?? ''),
        TextCellValue(submission.selfEmployedDesignation ?? ''),
        TextCellValue(submission.gender ?? ''),
        TextCellValue(submission.maritalStatus ?? ''),
        DoubleCellValue(submission.monthlyIncome ?? 0),
        DoubleCellValue(submission.monthlyCommission ?? 0),
        TextCellValue(submission.panNumber ?? ''),
        TextCellValue(submission.cibilScore ?? ''),
        // Format addresses nicely
        TextCellValue('${submission.currentAddressLine1}, ${submission.currentCity}, ${submission.currentState}'),
        TextCellValue(submission.isPermanentSameAsCurrent == true 
            ? 'Same as Current' 
            : '${submission.permanentAddressLine1}, ${submission.permanentCity}, ${submission.permanentState}'),
        TextCellValue('${submission.officeCity}, ${submission.officeState}'),
        
        // Existing Loans Summary
        TextCellValue(submission.hasExistingLoans == true 
            ? (submission.existingLoans?.map((l) => "${l['loanType']}: ${l['amount']}").join('; ') ?? '')
            : 'No'),
            
        TextCellValue(submission.hasOverdraft == true ? 'Yes (${submission.overdraftAmount})' : 'No'),
        
        // Bouncing/Overdue
        TextCellValue(submission.hasOverdue == true ? 'Yes' : 'No'),
        TextCellValue(submission.overdueLoanType ?? ''),
        DoubleCellValue(submission.overdueAmount ?? 0),
        TextCellValue(submission.bouncingStatus ?? ''),
        TextCellValue(submission.bouncingMonths ?? ''),
        IntCellValue(submission.bouncingDays ?? 0),
        
        TextCellValue(submission.submissionDate?.toString().split('.')[0] ?? ''),
      ];
      sheetObject.appendRow(row);
    }

    return excel.save();
  }
}
