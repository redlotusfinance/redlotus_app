import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/form_provider.dart';

class FormStepPersonal extends StatefulWidget {
  const FormStepPersonal({super.key});

  @override
  State<FormStepPersonal> createState() => _FormStepPersonalState();
}

class _FormStepPersonalState extends State<FormStepPersonal> {
  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);

    // Define the list of professions
    final List<String> professions = [
      'Govt Employee', // Added at the top
      'Salaried',
      'Self-Employed',
      'Professional',
      'Lic Agent',
      'Freelancer',
      'Doctor',
      'CA/CS/CMS',
      'D-Pharma/B-Pharma',
      'Medical',
      'SME',
    ];
    
    // Define the new list of loan purposes
    final List<String> loanPurposes = [
      'Business Loan',
      'Working Capital Loan',
      'Machinery Loan',
      'Construction Loan',
      'Solar Loan',
      'Marriege',
      'New Business Set-up',
      'Loan consolidation',
      'Credit card Payment',
      'Land Purchase',
      'Home Construction',
      'Land buy+Construction',
      'Business Expension',
      'Two wheeler',
      'New Car',
      'Old Car Finance',
      'SME Loan',
    ];
    
    // Define the new list of loan types
    final List<String> loanTypes = [
      'Personal Loan',
      'Home loan',
      'Loan Against Property',
      'Mortgage loan',
      'Business Loan',
      'Car Loan',
      'Two wheeler Loan',
    ];

    // Define items for the 'Type of Firm' dropdown
    final List<String> firmTypes = [
      'Propritor',
      'SME',
      'OPC',
      'LLP',
      'PVT LTD',
      'LTD',
    ];
    
    // Define items for the 'Designation' dropdown
     final List<String> selfEmployedDesignations = [
      'Propritor',
      'Director',
      'Non Participating Director',
    ];

    return Form(
      key: formProvider.personalInfoFormKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Personal Information', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 24),

              TextFormField(
                initialValue: formProvider.customerName,
                decoration: const InputDecoration(labelText: 'Customer Name'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter your name' : null,
                onSaved: (value) => formProvider.customerName = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Date of Birth'),
                readOnly: true,
                controller: TextEditingController(
                  text: formProvider.dateOfBirth == null
                      ? ''
                      : "${formProvider.dateOfBirth!.toLocal()}".split(' ')[0],
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    formProvider.updateDateOfBirth(pickedDate);
                  }
                },
                 validator: (value) => formProvider.dateOfBirth == null ? 'Please select your date of birth' : null,
              ),
              const SizedBox(height: 16),

              // --- New Fields ---
              TextFormField(
                initialValue: formProvider.spouseName,
                decoration: const InputDecoration(labelText: 'Spouse Name'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter spouse\'s name' : null,
                onSaved: (value) => formProvider.spouseName = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: formProvider.fatherName,
                decoration: const InputDecoration(labelText: 'Father Name'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter father\'s name' : null,
                onSaved: (value) => formProvider.fatherName = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: formProvider.motherName,
                decoration: const InputDecoration(labelText: 'Mother Name (Optional)'),
                onSaved: (value) => formProvider.motherName = value,
              ),
              const SizedBox(height: 16),
              
              DropdownButtonFormField<String>(
                value: formProvider.loanPurpose,
                decoration: const InputDecoration(labelText: 'Loan Purpose'),
                items: loanPurposes
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => formProvider.loanPurpose = value),
                onSaved: (value) => formProvider.loanPurpose = value,
                validator: (value) => value == null ? 'Please select a loan purpose' : null,
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: formProvider.loanType,
                decoration: const InputDecoration(labelText: 'Loan Type'),
                items: loanTypes
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => formProvider.loanType = value),
                onSaved: (value) => formProvider.loanType = value,
                validator: (value) => value == null ? 'Please select a loan type' : null,
              ),
              
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Profession'),
                value: formProvider.profession,
                items: professions
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) {
                  formProvider.updateProfession(value);
                },
                validator: (value) => value == null ? 'Please select a profession' : null,
              ),

              // --- Conditional Fields ---
              if (formProvider.profession == 'Salaried')
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    initialValue: formProvider.companyName,
                    decoration: const InputDecoration(labelText: 'Company Name'),
                    onSaved: (value) => formProvider.companyName = value,
                    validator: (value) => value!.isEmpty ? 'Please enter your company name' : null,
                  ),
                ),

              if (formProvider.profession == 'Self-Employed') ...[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Type of Firm'),
                    value: formProvider.firmType,
                    items: firmTypes
                        .map((label) => DropdownMenuItem(
                              value: label,
                              child: Text(label),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => formProvider.firmType = value),
                    onSaved: (value) => formProvider.firmType = value,
                    validator: (value) => value == null ? 'Please select a firm type' : null,
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Designation'),
                    value: formProvider.selfEmployedDesignation,
                    items: selfEmployedDesignations
                        .map((label) => DropdownMenuItem(
                              value: label,
                              child: Text(label),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => formProvider.selfEmployedDesignation = value),
                    onSaved: (value) => formProvider.selfEmployedDesignation = value,
                    validator: (value) => value == null ? 'Please select a designation' : null,
                  ),
                ),
              ],
              
              const SizedBox(height: 16),

              TextFormField(
                initialValue: formProvider.email,
                decoration: const InputDecoration(labelText: 'Email ID'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter your email';
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) return 'Please enter a valid email';
                  return null;
                },
                 onSaved: (value) => formProvider.email = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: formProvider.phoneNumber,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.isEmpty ? 'Please enter your phone number' : null,
                 onSaved: (value) => formProvider.phoneNumber = value!,
              ),
              const SizedBox(height: 24),
              Text('Gender', style: Theme.of(context).textTheme.titleMedium),
              Row(
                children: ['Male', 'Female', 'Other'].map((gender) {
                  return Row(
                    children: [
                      Radio<String>(
                        value: gender,
                        groupValue: formProvider.gender,
                        onChanged: (value) {
                          setState(() {
                             formProvider.gender = value;
                          });
                        },
                      ),
                      Text(gender),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: formProvider.maritalStatus,
                decoration: const InputDecoration(labelText: 'Marital Status'),
                items: ['Single', 'Married', 'Divorced', 'Widowed']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => formProvider.maritalStatus = value),
                onSaved: (value) => formProvider.maritalStatus = value,
                validator: (value) => value == null ? 'Please select a marital status' : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
