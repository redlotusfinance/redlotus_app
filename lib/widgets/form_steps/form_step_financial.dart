import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/form_provider.dart';

class FormStepFinancial extends StatelessWidget {
  const FormStepFinancial({super.key});

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);

    // Define the Cibil score options
    final List<String> cibilScores = [
      '750+',
      '720-749',
      '700-719',
      '650-700',
      'less than 650',
      '-1',
      '0',
    ];
    
    // Define existing loan types
    final List<String> existingLoanTypes = [
      'Personal Loan',
      'Home loan',
      'Loan Against Property',
      'Mortgage loan',
      'Business Loan',
      'Car Loan',
      'Two wheeler Loan',
      'Credit Card',
    ];
    
    // Define overdue loan types
    final List<String> overdueLoanTypes = [
      'Personal Loan',
      'Home loan',
      'Loan Against Property',
      'Mortgage loan',
      'Business Loan',
      'Car Loan',
      'Two wheeler Loan',
    ];
    
    final List<String> bouncingMonths = [
      'within 3 months',
      'before 3 months',
      'within 6 months',
      'before 6 months',
      'within 12 months',
    ];

    return Form(
      key: formProvider.financialFormKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Financial Details', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 24),
              // Add the Pan No text field here
              TextFormField(
                initialValue: formProvider.panNumber,
                decoration: const InputDecoration(labelText: 'Pan No'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your PAN number';
                  }
                  if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(value)) {
                    return 'Please enter a valid PAN number';
                  }
                  return null;
                },
                onSaved: (value) => formProvider.panNumber = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: formProvider.monthlyIncome?.toString(),
                decoration: const InputDecoration(labelText: 'Monthly Income'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Please enter your monthly income' : null,
                onSaved: (value) => formProvider.monthlyIncome = double.tryParse(value!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: formProvider.monthlyCommission?.toString(),
                decoration: const InputDecoration(labelText: 'Monthly Commission/Revenue (Optional)'),
                keyboardType: TextInputType.number,
                onSaved: (value) => formProvider.monthlyCommission = double.tryParse(value!),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: formProvider.cibilScore,
                decoration: const InputDecoration(labelText: 'Cibil Score'),
                items: cibilScores
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) => formProvider.cibilScore = value,
                onSaved: (value) => formProvider.cibilScore = value,
                validator: (value) => value == null ? 'Please select your Cibil score' : null,
              ),
              const SizedBox(height: 24),
              
              // --- Existing Loans Section ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(child: Text('Do you have any loan or credit card running?')),
                  Switch(
                    value: formProvider.hasExistingLoans,
                    onChanged: (value) {
                       formProvider.toggleExistingLoans(value);
                    },
                  ),
                ],
              ),
              if (formProvider.hasExistingLoans) ...[
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: formProvider.existingLoansList.length,
                  itemBuilder: (context, index) {
                    final loan = formProvider.existingLoansList[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Loan #${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => formProvider.removeExistingLoan(index),
                                ),
                              ],
                            ),
                            DropdownButtonFormField<String>(
                              initialValue: loan.loanType,
                              decoration: const InputDecoration(labelText: 'Loan Type'),
                              items: existingLoanTypes
                                  .map((label) => DropdownMenuItem(
                                        value: label,
                                        child: Text(label),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                formProvider.updateExistingLoanType(index, value);
                              },
                              onSaved: (value) => loan.loanType = value,
                              validator: (value) => value == null ? 'Required' : null,
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              initialValue: loan.bankName,
                              decoration: const InputDecoration(labelText: 'Bank Name'),
                              onChanged: (value) => loan.bankName = value,
                              onSaved: (value) => loan.bankName = value,
                              validator: (value) => value!.isEmpty ? 'Required' : null,
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              key: ValueKey('${loan.loanType}_amount_$index'), 
                              initialValue: loan.amount?.toString(),
                              decoration: InputDecoration(
                                labelText: loan.loanType == 'Credit Card' ? 'Outstanding Amount' : 'EMI Amount',
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) => loan.amount = double.tryParse(value),
                              onSaved: (value) => loan.amount = double.tryParse(value!),
                              validator: (value) => value!.isEmpty ? 'Required' : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                if (formProvider.existingLoansList.length < 10)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: OutlinedButton.icon(
                      onPressed: () => formProvider.addExistingLoan(),
                      icon: const Icon(Icons.add),
                      label: const Text('Add Another Loan'),
                    ),
                  ),
              ],

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Are you having any overdraft?'),
                  Switch(
                    value: formProvider.hasOverdraft,
                    onChanged: (value) {
                       formProvider.toggleOverdraft(value);
                    },
                  ),
                ],
              ),
              if (formProvider.hasOverdraft)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    initialValue: formProvider.overdraftAmount?.toString(),
                    decoration: const InputDecoration(labelText: 'Overdraft Amount'),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => formProvider.overdraftAmount = double.tryParse(value!),
                  ),
                ),
                
              const SizedBox(height: 32),
              
              // --- Bouncing Details Section ---
              Text('Bouncing Details', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Expanded(child: Text('Are you having any overdue in any loan?')),
                  Radio<bool>(
                    value: true,
                    groupValue: formProvider.hasOverdue,
                    onChanged: (value) => formProvider.toggleOverdue(value!),
                  ),
                  const Text('Yes'),
                  Radio<bool>(
                    value: false,
                    groupValue: formProvider.hasOverdue,
                    onChanged: (value) => formProvider.toggleOverdue(value!),
                  ),
                  const Text('No'),
                ],
              ),
              
              if (formProvider.hasOverdue) ...[
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: formProvider.overdueLoanType,
                  decoration: const InputDecoration(labelText: 'Loan Details of overdue'),
                  items: overdueLoanTypes
                      .map((label) => DropdownMenuItem(
                            value: label,
                            child: Text(label),
                          ))
                      .toList(),
                  onChanged: (value) => formProvider.overdueLoanType = value, 
                  onSaved: (value) => formProvider.overdueLoanType = value,
                  validator: (value) => value == null ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: formProvider.overdueAmount?.toString(),
                  decoration: const InputDecoration(labelText: 'Total Amount Overdue'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => formProvider.overdueAmount = double.tryParse(value!),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: formProvider.bouncingStatus,
                  decoration: const InputDecoration(labelText: 'Bouncing'),
                  items: ['Yes', 'No']
                      .map((label) => DropdownMenuItem(
                            value: label,
                            child: Text(label),
                          ))
                      .toList(),
                  onChanged: (value) => formProvider.updateBouncingStatus(value), // Use method to notify listeners
                  onSaved: (value) => formProvider.bouncingStatus = value,
                  validator: (value) => value == null ? 'Required' : null,
                ),
                if (formProvider.bouncingStatus == 'Yes') ...[
                   const SizedBox(height: 16),
                   DropdownButtonFormField<String>(
                    initialValue: formProvider.bouncingMonths,
                    decoration: const InputDecoration(labelText: 'Months'),
                    items: bouncingMonths
                        .map((label) => DropdownMenuItem(
                              value: label,
                              child: Text(label),
                            ))
                        .toList(),
                    onChanged: (value) => formProvider.bouncingMonths = value,
                    onSaved: (value) => formProvider.bouncingMonths = value,
                    validator: (value) => value == null ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: formProvider.bouncingDays?.toString(),
                    decoration: const InputDecoration(labelText: 'Bouncing EMI paid in no of days'),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => formProvider.bouncingDays = int.tryParse(value!),
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}
