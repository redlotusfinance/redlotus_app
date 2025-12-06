import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart';
import '../models/existing_loan_model.dart';

// This class holds the data and validation keys for our multi-step form.
class FormProvider with ChangeNotifier {
  // isLoading and errorMessage
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Step 1: Personal Information
  final GlobalKey<FormState> personalInfoFormKey = GlobalKey<FormState>();
  String customerName = '';
  DateTime? dateOfBirth;
  String? spouseName;
  String? fatherName;
  String? motherName;
  String? loanPurpose;
  String? loanType;
  String? profession;
  String? companyName;
  String? firmType;
  String? selfEmployedDesignation;
  String email = '';
  String phoneNumber = '';
  String? gender;
  String? maritalStatus;

  // Step 2: Address Details
  final GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();
  String? residenceType;
  String? rentDuration;
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
  String permanentLandmark = '';
  String permanentTaluka = '';
  String permanentCity = '';
  String permanentDistrict = '';
  String permanentState = '';
  String permanentPinCode = '';
  String officeLandmark = '';
  String officeTaluka = '';
  String officeCity = '';
  String officeDistrict = '';
  String officeState = '';
  String officePinCode = '';

  // Step 3: Financial Details
  final GlobalKey<FormState> financialFormKey = GlobalKey<FormState>();
  String? panNumber;
  double? monthlyIncome;
  double? monthlyCommission;
  String? cibilScore;
  
  bool hasExistingLoans = false;
  List<ExistingLoan> existingLoansList = []; 
  
  bool hasOverdraft = false;
  double? overdraftAmount;
  
  // Bouncing Details
  bool hasOverdue = false;
  String? overdueLoanType;
  double? overdueAmount;
  String? bouncingStatus; // Yes/No
  String? bouncingMonths;
  int? bouncingDays;

  // --- Update Methods ---

  void updateResidenceType(String? value) {
    if (residenceType != value) {
      rentDuration = null;
    }
    residenceType = value;
    notifyListeners();
  }

  void updateRentDuration(String? value) {
    rentDuration = value;
    notifyListeners();
  }

  void updateProfession(String? newProfession) {
    if (profession != newProfession) {
      companyName = null;
      firmType = null;
      selfEmployedDesignation = null;
    }
    profession = newProfession;
    notifyListeners();
  }

  void updateDateOfBirth(DateTime value) {
    dateOfBirth = value;
    notifyListeners();
  }
  
  void togglePermanentAddress(bool value) {
    isPermanentSameAsCurrent = value;
    notifyListeners();
  }
  
  void toggleExistingLoans(bool value) {
    hasExistingLoans = value;
    if (value && existingLoansList.isEmpty) {
        addExistingLoan(); 
    } else if (!value) {
        existingLoansList.clear();
    }
    notifyListeners();
  }

  void toggleOverdraft(bool value) {
    hasOverdraft = value;
    notifyListeners();
  }
  
  void toggleOverdue(bool value) {
    hasOverdue = value;
    if (!value) {
      overdueLoanType = null;
      overdueAmount = null;
      bouncingStatus = null;
      bouncingMonths = null;
      bouncingDays = null;
    }
    notifyListeners();
  }

  void updateBouncingStatus(String? value) {
    bouncingStatus = value;
    if (value != 'Yes') {
      bouncingMonths = null;
      bouncingDays = null;
    }
    notifyListeners();
  }
  
  // --- Existing Loans Management ---
  
  void addExistingLoan() {
    if (existingLoansList.length < 10) {
      existingLoansList.add(ExistingLoan());
      notifyListeners();
    }
  }

  void removeExistingLoan(int index) {
    existingLoansList.removeAt(index);
    if (existingLoansList.isEmpty) {
        hasExistingLoans = false; 
    }
    notifyListeners();
  }

  void updateExistingLoanType(int index, String? newType) {
    if (index >= 0 && index < existingLoansList.length) {
      existingLoansList[index].loanType = newType;
      notifyListeners();
    }
  }

  // --- Form Validation ---

  bool validateStep(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      return true;
    }
    return false;
  }

  // --- Form Submission ---

  Future<bool> submitForm() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    // Sanitize numeric values to ensure they are not null
    final sanitizedMonthlyIncome = monthlyIncome ?? 0;
    final sanitizedMonthlyCommission = monthlyCommission ?? 0;
    final sanitizedOverdraftAmount = overdraftAmount ?? 0;
    final sanitizedOverdueAmount = overdueAmount ?? 0;
    final sanitizedBouncingDays = bouncingDays ?? 0;

    final Map<String, dynamic> formData = {
      'customerName': customerName,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'spouseName': spouseName,
      'fatherName': fatherName,
      'motherName': motherName,
      'loanPurpose': loanPurpose,
      'loanType': loanType,
      'profession': profession,
      'companyName': companyName,
      'firmType': firmType,
      'selfEmployedDesignation': selfEmployedDesignation,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'maritalStatus': maritalStatus,
      
      'residenceType': residenceType,
      'rentDuration': rentDuration,
      'currentAddressLine1': currentAddressLine1,
      'currentAddressLine2': currentAddressLine2,
      'currentCity': currentCity,
      'currentDistrict': currentDistrict,
      'currentState': currentState,
      'currentPinCode': currentPinCode,
      'currentLandmark': currentLandmark,
      'isPermanentSameAsCurrent': isPermanentSameAsCurrent,
      'permanentAddressLine1': permanentAddressLine1,
      'permanentAddressLine2': permanentAddressLine2,
      'permanentLandmark': permanentLandmark,
      'permanentTaluka': permanentTaluka,
      'permanentCity': permanentCity,
      'permanentDistrict': permanentDistrict,
      'permanentState': permanentState,
      'permanentPinCode': permanentPinCode,
      'officeLandmark': officeLandmark,
      'officeTaluka': officeTaluka,
      'officeCity': officeCity,
      'officeDistrict': officeDistrict,
      'officeState': officeState,
      'officePinCode': officePinCode,

      'panNumber': panNumber,
      'monthlyIncome': sanitizedMonthlyIncome, // Use sanitized value
      'monthlyCommission': sanitizedMonthlyCommission, // Use sanitized value
      'cibilScore': cibilScore,
      'hasExistingLoans': hasExistingLoans,
      'existingLoans': existingLoansList.map((e) => e.toJson()).toList(), 
      'hasOverdraft': hasOverdraft,
      'overdraftAmount': sanitizedOverdraftAmount, // Use sanitized value
      
      'hasOverdue': hasOverdue,
      'overdueLoanType': overdueLoanType,
      'overdueAmount': sanitizedOverdueAmount, // Use sanitized value
      'bouncingStatus': bouncingStatus,
      'bouncingMonths': bouncingMonths,
      'bouncingDays': sanitizedBouncingDays, // Use sanitized value
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
        return true;
      } else {
        // Detailed error logging
        print('Backend Error: ${response.statusCode}');
        print('Response Body: ${response.body}');
        
        try {
           final errorData = json.decode(response.body);
           _errorMessage = errorData['message'] ?? 'Failed to submit form.';
           if (errorData['details'] != null) {
             _errorMessage = '$_errorMessage Details: ${errorData['details']}';
           }
        } catch (_) {
           _errorMessage = 'Failed to submit form. Server error: ${response.body}';
        }
        
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print('Network Exception: $e');
      _errorMessage = 'Failed to submit form. Connection error: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
