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
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Loan Purpose'),
                items: ['Personal', 'Home', 'Mortgage', 'Business']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) => formProvider.loanPurpose = value,
                onSaved: (value) => formProvider.loanPurpose = value,
                validator: (value) => value == null ? 'Please select a loan purpose' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Profession'),
                items: ['Salaried', 'Self-Employed', 'Business Owner', 'Other']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) => formProvider.profession = value,
                 onSaved: (value) => formProvider.profession = value,
                validator: (value) => value == null ? 'Please select a profession' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
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
               if (formProvider.gender == null)
                const Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text('Please select a gender', style: TextStyle(color: Colors.red, fontSize: 12)),
                ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Marital Status'),
                items: ['Single', 'Married', 'Divorced', 'Widowed']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) => formProvider.maritalStatus = value,
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
