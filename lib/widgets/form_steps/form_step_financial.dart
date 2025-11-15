import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/form_provider.dart';

class FormStepFinancial extends StatelessWidget {
  const FormStepFinancial({super.key});

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);

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
              TextFormField(
                decoration: const InputDecoration(labelText: 'Monthly Income'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Please enter your monthly income' : null,
                onSaved: (value) => formProvider.monthlyIncome = double.tryParse(value!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Monthly Commission/Revenue (Optional)'),
                keyboardType: TextInputType.number,
                onSaved: (value) => formProvider.monthlyCommission = double.tryParse(value!),
              ),
              const SizedBox(height: 24),
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
              if (formProvider.hasExistingLoans)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Personal Loan Outstanding'),
                        keyboardType: TextInputType.number,
                        onSaved: (value) => formProvider.personalLoanOutstanding = double.tryParse(value!),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Car Loan Outstanding'),
                        keyboardType: TextInputType.number,
                        onSaved: (value) => formProvider.carLoanOutstanding = double.tryParse(value!),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Credit Card Outstanding'),
                        keyboardType: TextInputType.number,
                        onSaved: (value) => formProvider.creditCardOutstanding = double.tryParse(value!),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Other Loan Outstanding'),
                        keyboardType: TextInputType.number,
                        onSaved: (value) => formProvider.otherLoanOutstanding = double.tryParse(value!),
                      ),
                    ],
                  ),
                ),
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
                    decoration: const InputDecoration(labelText: 'Overdraft Amount'),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => formProvider.overdraftAmount = double.tryParse(value!),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
