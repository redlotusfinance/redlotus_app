class Bank {
  final String name;
  final String logoUrl;
  final List<String> supportedLoanTypes;
  final int minIncome;
  final int maxLoanAmount;
  final Map<String, double> interestRate;
  final int approvalRate;
  final List<String> keyFeatures;
  final String applicationUrl;
  final String tagline;

  Bank({
    required this.name,
    required this.logoUrl,
    required this.supportedLoanTypes,
    required this.minIncome,
    required this.maxLoanAmount,
    required this.interestRate,
    required this.approvalRate,
    required this.keyFeatures,
    required this.applicationUrl,
    required this.tagline,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      name: json['name'],
      logoUrl: json['logoUrl'],
      supportedLoanTypes: List<String>.from(json['supportedLoanTypes']),
      minIncome: json['minIncome'],
      maxLoanAmount: json['maxLoanAmount'],
      interestRate: Map<String, double>.from(json['interestRate']),
      approvalRate: json['approvalRate'],
      keyFeatures: List<String>.from(json['keyFeatures']),
      applicationUrl: json['applicationUrl'],
      tagline: json['tagline'],
    );
  }
}
