import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart';

// This class holds the data and validation keys for our multi-step form.
class FormProvider with ChangeNotifier {
  // ... (all existing fields and keys) ...
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Step 1: Personal Information
  final GlobalKey<FormState> personalInfoFormKey = GlobalKey<FormState>();
  String customerName = '';
  DateTime? dateOfBirth;
  String? loanPurpose;
  String? profession;
  String email = '';
  String phoneNumber = '';
  String? gender;
  String? maritalStatus;

  // Step 2: Address Details
  final GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();
  String currentAddressLine1 = '';
  String currentAddressLine2 = '';
  String currentCity = '';
  String currentDistrict = '';
  String currentState = '';
  String currentPinCode = '';
  String currentLandmark = '';
  bool isPermanentSameAsCurrent = false;
  String permanentAddressLine1 = '';
  String permanentAddressLine2 = '';
  String permanentCity = '';
  String permanentDistrict = '';
  String permanentState = '';
  String permanentPinCode = '';
  String permanentLandmark = '';

  // Step 3: Financial Details
  final GlobalKey<FormState> financialFormKey = GlobalKey<FormState>();
  double? monthlyIncome;
  double? monthlyCommission;
  bool hasExistingLoans = false;
  double? personalLoanOutstanding;
  double? carLoanOutstanding;
  double? creditCardOutstanding;
  double? otherLoanOutstanding;
  bool hasOverdraft = false;
  double? overdraftAmount;

  // --- Update Methods ---

  void updateCustomerName(String value) {
    customerName = value;
    notifyListeners();
  }

  void updateDateOfBirth(DateTime value) {
    dateOfBirth = value;
    notifyListeners();
  }
  
  // ... Add update methods for all other fields ...

  void togglePermanentAddress(bool value) {
    isPermanentSameAsCurrent = value;
    notifyListeners();
  }
  
  void toggleExistingLoans(bool value) {
    hasExistingLoans = value;
    notifyListeners();
  }

  void toggleOverdraft(bool value) {
    hasOverdraft = value;
    notifyListeners();
  }


  // --- Form Submission ---

  Future<bool> submitForm() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    // Serialize the form data
    final Map<String, dynamic> formData = {
      'customerName': customerName,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'loanPurpose': loanPurpose,
      'profession': profession,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'maritalStatus': maritalStatus,
      // ... (add all other fields)
    };

    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/api/user/submit-form'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(formData),
      );

      if (response.statusCode == 201) {
        _isLoading = false;
        notifyListeners();
        return true; // Success
      } else {
        _errorMessage = 'Failed to submit form. Server error.';
        _isLoading = false;
        notifyListeners();
        return false; // Failure
      }
    } catch (e) {
      _errorMessage = 'Failed to submit form. Please check your connection.';
      _isLoading = false;
      notifyListeners();
      return false; // Failure
    }
  }
  
  // Method to validate a specific step
  bool validateStep(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      return true;
    }
    return false;
  }
}
