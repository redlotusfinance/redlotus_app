import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/form_provider.dart';

class FormStepAddress extends StatelessWidget {
  const FormStepAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);

    // Define items for Residence Type
    final List<String> residenceTypes = [
      'Rented',
      'Owned',
      'Owned by Father',
      'Owned by Brother',
      'Owned by Spouse',
    ];

    // Define items for Rent Duration
    final List<String> rentDurations = [
      'less than Year',
      'more than year',
      '2 Years',
      '3 Years',
    ];

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
              
              // --- Residence Type Dropdown ---
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Residence Type'),
                initialValue: formProvider.residenceType,
                items: residenceTypes
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) {
                  formProvider.updateResidenceType(value);
                },
                validator: (value) => value == null ? 'Please select a residence type' : null,
              ),
              const SizedBox(height: 16),

              // --- Conditional Rent Duration Dropdown ---
              if (formProvider.residenceType == 'Rented')
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Rent Duration'),
                    initialValue: formProvider.rentDuration, 
                    items: rentDurations
                        .map((label) => DropdownMenuItem(
                              value: label,
                              child: Text(label),
                            ))
                        .toList(),
                    onChanged: (value) {
                       formProvider.updateRentDuration(value);
                    },
                    validator: (value) => value == null ? 'Please select a duration' : null,
                  ),
                ),

              Text('Current Address', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: formProvider.currentAddressLine1,
                decoration: const InputDecoration(labelText: 'Residence Line 1'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter your address' : null,
                onSaved: (value) => formProvider.currentAddressLine1 = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: formProvider.currentAddressLine2,
                decoration: const InputDecoration(labelText: 'Residence Line 2 (Optional)'),
                onSaved: (value) => formProvider.currentAddressLine2 = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: formProvider.currentCity,
                decoration: const InputDecoration(labelText: 'City/Town'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter your city' : null,
                onSaved: (value) => formProvider.currentCity = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: formProvider.currentDistrict,
                decoration: const InputDecoration(labelText: 'District'),
                 validator: (value) => value == null || value.isEmpty ? 'Please enter your district' : null,
                onSaved: (value) => formProvider.currentDistrict = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: formProvider.currentState,
                decoration: const InputDecoration(labelText: 'State'),
                 validator: (value) => value == null || value.isEmpty ? 'Please enter your state' : null,
                onSaved: (value) => formProvider.currentState = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: formProvider.currentPinCode,
                decoration: const InputDecoration(labelText: 'Pin Code'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Please enter your pin code' : null,
                onSaved: (value) => formProvider.currentPinCode = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: formProvider.currentLandmark,
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
                  initialValue: formProvider.permanentAddressLine1,
                  decoration: const InputDecoration(labelText: 'Residence Line 1'),
                  validator: (value) => !formProvider.isPermanentSameAsCurrent && (value == null || value.isEmpty) ? 'Please enter your address' : null,
                  onSaved: (value) => formProvider.permanentAddressLine1 = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: formProvider.permanentAddressLine2,
                  decoration: const InputDecoration(labelText: 'Residence Line 2 (Optional)'),
                  onSaved: (value) => formProvider.permanentAddressLine2 = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: formProvider.permanentLandmark,
                  decoration: const InputDecoration(labelText: 'Landmark (Optional)'),
                  onSaved: (value) => formProvider.permanentLandmark = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: formProvider.permanentTaluka,
                  decoration: const InputDecoration(labelText: 'Taluka'),
                  onSaved: (value) => formProvider.permanentTaluka = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: formProvider.permanentCity,
                  decoration: const InputDecoration(labelText: 'City/town'),
                  validator: (value) => !formProvider.isPermanentSameAsCurrent && (value == null || value.isEmpty) ? 'Please enter permanent city' : null,
                  onSaved: (value) => formProvider.permanentCity = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: formProvider.permanentDistrict,
                  decoration: const InputDecoration(labelText: 'District'),
                  validator: (value) => !formProvider.isPermanentSameAsCurrent && (value == null || value.isEmpty) ? 'Please enter permanent district' : null,
                  onSaved: (value) => formProvider.permanentDistrict = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: formProvider.permanentState,
                  decoration: const InputDecoration(labelText: 'State'),
                  validator: (value) => !formProvider.isPermanentSameAsCurrent && (value == null || value.isEmpty) ? 'Please enter permanent state' : null,
                  onSaved: (value) => formProvider.permanentState = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: formProvider.permanentPinCode,
                  decoration: const InputDecoration(labelText: 'Pin Code'),
                  keyboardType: TextInputType.number,
                  validator: (value) => !formProvider.isPermanentSameAsCurrent && (value == null || value.isEmpty) ? 'Please enter permanent pin code' : null,
                  onSaved: (value) => formProvider.permanentPinCode = value!,
                ),
              ],

              const SizedBox(height: 32),
              
              // --- Office Address Section ---
              Text('Office Address', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: formProvider.officeLandmark,
                decoration: const InputDecoration(labelText: 'Landmark'),
                onSaved: (value) => formProvider.officeLandmark = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: formProvider.officeTaluka,
                decoration: const InputDecoration(labelText: 'Taluka'),
                onSaved: (value) => formProvider.officeTaluka = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: formProvider.officeCity,
                decoration: const InputDecoration(labelText: 'City/town'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter office city' : null,
                onSaved: (value) => formProvider.officeCity = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: formProvider.officeDistrict,
                decoration: const InputDecoration(labelText: 'District'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter office district' : null,
                onSaved: (value) => formProvider.officeDistrict = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: formProvider.officeState,
                decoration: const InputDecoration(labelText: 'State'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter office state' : null,
                onSaved: (value) => formProvider.officeState = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: formProvider.officePinCode,
                decoration: const InputDecoration(labelText: 'Pin Code'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Please enter office pin code' : null,
                onSaved: (value) => formProvider.officePinCode = value!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
