class UserSubmission {
  final String? id;
  
  // Personal
  final String? customerName;
  final DateTime? dateOfBirth;
  final String? spouseName;
  final String? fatherName;
  final String? motherName;
  final String? loanPurpose;
  final String? loanType;
  final String? profession;
  final String? companyName;
  final String? firmType;
  final String? selfEmployedDesignation;
  final String? email;
  final String? phoneNumber;
  final String? gender;
  final String? maritalStatus;

  // Address
  final String? residenceType;
  final String? rentDuration;
  final String? currentAddressLine1;
  final String? currentAddressLine2;
  final String? currentCity;
  final String? currentDistrict;
  final String? currentState;
  final String? currentPinCode;
  final String? currentLandmark;
  final bool? isPermanentSameAsCurrent;
  final String? permanentAddressLine1;
  final String? permanentAddressLine2;
  final String? permanentLandmark;
  final String? permanentTaluka;
  final String? permanentCity;
  final String? permanentDistrict;
  final String? permanentState;
  final String? permanentPinCode;
  final String? officeLandmark;
  final String? officeTaluka;
  final String? officeCity;
  final String? officeDistrict;
  final String? officeState;
  final String? officePinCode;

  // Financial
  final String? panNumber;
  final double? monthlyIncome;
  final double? monthlyCommission;
  final String? cibilScore;
  final bool? hasExistingLoans;
  final List<dynamic>? existingLoans; // Keeping dynamic for simplicity, can map to ExistingLoan model
  final bool? hasOverdraft;
  final double? overdraftAmount;
  
  // Bouncing
  final bool? hasOverdue;
  final String? overdueLoanType;
  final double? overdueAmount;
  final String? bouncingStatus;
  final String? bouncingMonths;
  final int? bouncingDays;

  final DateTime? submissionDate;

  UserSubmission({
    this.id,
    this.customerName,
    this.dateOfBirth,
    this.spouseName,
    this.fatherName,
    this.motherName,
    this.loanPurpose,
    this.loanType,
    this.profession,
    this.companyName,
    this.firmType,
    this.selfEmployedDesignation,
    this.email,
    this.phoneNumber,
    this.gender,
    this.maritalStatus,
    this.residenceType,
    this.rentDuration,
    this.currentAddressLine1,
    this.currentAddressLine2,
    this.currentCity,
    this.currentDistrict,
    this.currentState,
    this.currentPinCode,
    this.currentLandmark,
    this.isPermanentSameAsCurrent,
    this.permanentAddressLine1,
    this.permanentAddressLine2,
    this.permanentLandmark,
    this.permanentTaluka,
    this.permanentCity,
    this.permanentDistrict,
    this.permanentState,
    this.permanentPinCode,
    this.officeLandmark,
    this.officeTaluka,
    this.officeCity,
    this.officeDistrict,
    this.officeState,
    this.officePinCode,
    this.panNumber,
    this.monthlyIncome,
    this.monthlyCommission,
    this.cibilScore,
    this.hasExistingLoans,
    this.existingLoans,
    this.hasOverdraft,
    this.overdraftAmount,
    this.hasOverdue,
    this.overdueLoanType,
    this.overdueAmount,
    this.bouncingStatus,
    this.bouncingMonths,
    this.bouncingDays,
    this.submissionDate,
  });

  factory UserSubmission.fromJson(Map<String, dynamic> json) {
    return UserSubmission(
      id: json['_id'],
      customerName: json['customerName'],
      dateOfBirth: json['dateOfBirth'] != null ? DateTime.parse(json['dateOfBirth']) : null,
      spouseName: json['spouseName'],
      fatherName: json['fatherName'],
      motherName: json['motherName'],
      loanPurpose: json['loanPurpose'],
      loanType: json['loanType'],
      profession: json['profession'],
      companyName: json['companyName'],
      firmType: json['firmType'],
      selfEmployedDesignation: json['selfEmployedDesignation'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      gender: json['gender'],
      maritalStatus: json['maritalStatus'],
      residenceType: json['residenceType'],
      rentDuration: json['rentDuration'],
      currentAddressLine1: json['currentAddressLine1'],
      currentAddressLine2: json['currentAddressLine2'],
      currentCity: json['currentCity'],
      currentDistrict: json['currentDistrict'],
      currentState: json['currentState'],
      currentPinCode: json['currentPinCode'],
      currentLandmark: json['currentLandmark'],
      isPermanentSameAsCurrent: json['isPermanentSameAsCurrent'],
      permanentAddressLine1: json['permanentAddressLine1'],
      permanentAddressLine2: json['permanentAddressLine2'],
      permanentLandmark: json['permanentLandmark'],
      permanentTaluka: json['permanentTaluka'],
      permanentCity: json['permanentCity'],
      permanentDistrict: json['permanentDistrict'],
      permanentState: json['permanentState'],
      permanentPinCode: json['permanentPinCode'],
      officeLandmark: json['officeLandmark'],
      officeTaluka: json['officeTaluka'],
      officeCity: json['officeCity'],
      officeDistrict: json['officeDistrict'],
      officeState: json['officeState'],
      officePinCode: json['officePinCode'],
      panNumber: json['panNumber'],
      monthlyIncome: (json['monthlyIncome'] as num?)?.toDouble(),
      monthlyCommission: (json['monthlyCommission'] as num?)?.toDouble(),
      cibilScore: json['cibilScore'],
      hasExistingLoans: json['hasExistingLoans'],
      existingLoans: json['existingLoans'],
      hasOverdraft: json['hasOverdraft'],
      overdraftAmount: (json['overdraftAmount'] as num?)?.toDouble(),
      hasOverdue: json['hasOverdue'],
      overdueLoanType: json['overdueLoanType'],
      overdueAmount: (json['overdueAmount'] as num?)?.toDouble(),
      bouncingStatus: json['bouncingStatus'],
      bouncingMonths: json['bouncingMonths'],
      bouncingDays: (json['bouncingDays'] as num?)?.toInt(),
      submissionDate: json['submissionDate'] != null ? DateTime.parse(json['submissionDate']) : null,
    );
  }
}
