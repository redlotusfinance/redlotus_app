import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/form_provider.dart';

class FormStepAddress extends StatelessWidget {
  const FormStepAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);

    return Form(
      key: formProvider.addressFormKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Address Details', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 24),
              Text('Current Address', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Residence Line 1'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter your address' : null,
                onSaved: (value) => formProvider.currentAddressLine1 = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Residence Line 2 (Optional)'),
                onSaved: (value) => formProvider.currentAddressLine2 = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'City/Town'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter your city' : null,
                onSaved: (value) => formProvider.currentCity = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'District'),
                 validator: (value) => value == null || value.isEmpty ? 'Please enter your district' : null,
                onSaved: (value) => formProvider.currentDistrict = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'State'),
                 validator: (value) => value == null || value.isEmpty ? 'Please enter your state' : null,
                onSaved: (value) => formProvider.currentState = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Pin Code'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Please enter your pin code' : null,
                onSaved: (value) => formProvider.currentPinCode = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Landmark (Optional)'),
                onSaved: (value) => formProvider.currentLandmark = value!,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Checkbox(
                    value: formProvider.isPermanentSameAsCurrent,
                    onChanged: (value) {
                      formProvider.togglePermanentAddress(value!);
                    },
                  ),
                  const Expanded(child: Text('Permanent Address is the same as Current Address')),
                ],
              ),
              if (!formProvider.isPermanentSameAsCurrent) ...[
                const SizedBox(height: 24),
                Text('Permanent Address', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                 TextFormField(
                  decoration: const InputDecoration(labelText: 'Residence Line 1'),
                  validator: (value) => !formProvider.isPermanentSameAsCurrent && (value == null || value.isEmpty) ? 'Please enter your address' : null,
                  onSaved: (value) => formProvider.permanentAddressLine1 = value!,
                ),
                // ... Add other permanent address fields with validation
              ]
            ],
          ),
        ),
      ),
    );
  }
}
