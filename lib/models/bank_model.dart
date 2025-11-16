class Bank {
  final String? id; // Nullable for new banks that don't have an ID yet
  final String name;
  final String logoUrl;
  final List<String> supportedLoanTypes;
  final double minIncome;
  final double maxLoanAmount;
  final Map<String, dynamic> interestRate;
  final double approvalRate;
  final List<String> keyFeatures;
  final String applicationUrl;
  final String tagline;

  Bank({
    this.id,
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
      id: json['_id'], // MongoDB uses _id
      name: json['name'],
      logoUrl: json['logoUrl'],
      supportedLoanTypes: List<String>.from(json['supportedLoanTypes']),
      minIncome: (json['minIncome'] as num).toDouble(),
      maxLoanAmount: (json['maxLoanAmount'] as num).toDouble(),
      interestRate: Map<String, dynamic>.from(json['interestRate']),
      approvalRate: (json['approvalRate'] as num).toDouble(),
      keyFeatures: List<String>.from(json['keyFeatures']),
      applicationUrl: json['applicationUrl'],
      tagline: json['tagline'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'logoUrl': logoUrl,
      'supportedLoanTypes': supportedLoanTypes,
      'minIncome': minIncome,
      'maxLoanAmount': maxLoanAmount,
      'interestRate': interestRate,
      'approvalRate': approvalRate,
      'keyFeatures': keyFeatures,
      'applicationUrl': applicationUrl,
      'tagline': tagline,
    };
  }
}
