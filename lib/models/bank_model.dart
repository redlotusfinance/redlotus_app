class Bank {
  final String? id; // Nullable for new banks that don't have an ID yet
  final String name;
  final String logoUrl;
  final List<String> supportedLoanTypes;
  final double minIncome;
  final double maxLoanAmount;
  final Map<String, dynamic> interestRate;
  final double ltv; // Renamed from approvalRate
  final List<String> keyFeatures;
  final String applicationUrl;
  final String tagline;
  final int? minAge;
  final int? maxAge;

  Bank({
    this.id,
    required this.name,
    required this.logoUrl,
    required this.supportedLoanTypes,
    required this.minIncome,
    required this.maxLoanAmount,
    required this.interestRate,
    required this.ltv, // Renamed
    required this.keyFeatures,
    required this.applicationUrl,
    required this.tagline,
    this.minAge,
    this.maxAge,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      id: json['_id'],
      name: json['name'],
      logoUrl: json['logoUrl'],
      supportedLoanTypes: List<String>.from(json['supportedLoanTypes']),
      minIncome: (json['minIncome'] as num).toDouble(),
      maxLoanAmount: (json['maxLoanAmount'] as num).toDouble(),
      interestRate: Map<String, dynamic>.from(json['interestRate']),
      ltv: (json['ltv'] as num).toDouble(), // Renamed
      keyFeatures: List<String>.from(json['keyFeatures']),
      applicationUrl: json['applicationUrl'],
      tagline: json['tagline'],
      minAge: json['minAge'],
      maxAge: json['maxAge'],
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
      'ltv': ltv, // Renamed
      'keyFeatures': keyFeatures,
      'applicationUrl': applicationUrl,
      'tagline': tagline,
      'minAge': minAge,
      'maxAge': maxAge,
    };
  }
}
