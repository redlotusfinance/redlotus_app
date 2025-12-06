class UserSubmission {
  final String? id;
  final String? customerName;
  final String? email;
  final String? phoneNumber;
  final String? loanPurpose;
  final double? monthlyIncome;
  final DateTime? submissionDate;
  // Add other fields as needed for the detail view

  UserSubmission({
    this.id,
    this.customerName,
    this.email,
    this.phoneNumber,
    this.loanPurpose,
    this.monthlyIncome,
    this.submissionDate,
  });

  factory UserSubmission.fromJson(Map<String, dynamic> json) {
    return UserSubmission(
      id: json['_id'],
      customerName: json['customerName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      loanPurpose: json['loanPurpose'],
      monthlyIncome: (json['monthlyIncome'] as num?)?.toDouble(),
      submissionDate: json['submissionDate'] != null ? DateTime.parse(json['submissionDate']) : null,
    );
  }
}
