class Bank {
  final String? id;
  final String name;
  final String logoUrl;
  final List<String> supportedLoanTypes;
  final double minIncome;
  final double maxLoanAmount;
  final double minLoanAmount; // New
  final int minCibilScore;    // New
  final double multiplier;    // New
  final Map<String, dynamic> interestRate;
  final double ltv;
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
    this.minLoanAmount = 0.0, // New
    this.minCibilScore = 0,   // New
    this.multiplier = 1.0,    // New
    required this.interestRate,
    required this.ltv,
    required this.keyFeatures,
    required this.applicationUrl,
    required this.tagline,
    this.minAge,
    this.maxAge,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      id: json['_id'],
      name: json['name'] ?? 'Unknown Bank',
      logoUrl: json['logoUrl'] ?? '',
      supportedLoanTypes: json['supportedLoanTypes'] != null ? List<String>.from(json['supportedLoanTypes']) : [],
      minIncome: (json['minIncome'] as num?)?.toDouble() ?? 0.0,
      maxLoanAmount: (json['maxLoanAmount'] as num?)?.toDouble() ?? 0.0,
      minLoanAmount: (json['minLoanAmount'] as num?)?.toDouble() ?? 0.0, // New
      minCibilScore: (json['minCibilScore'] as num?)?.toInt() ?? 0,     // New
      multiplier: (json['multiplier'] as num?)?.toDouble() ?? 1.0,      // New
      interestRate: json['interestRate'] != null ? Map<String, dynamic>.from(json['interestRate']) : {'min': 0, 'max': 0},
      ltv: (json['ltv'] as num?)?.toDouble() ?? (json['approvalRate'] as num?)?.toDouble() ?? 0.0,
      keyFeatures: json['keyFeatures'] != null ? List<String>.from(json['keyFeatures']) : [],
      applicationUrl: json['applicationUrl'] ?? '',
      tagline: json['tagline'] ?? '',
      minAge: (json['minAge'] as num?)?.toInt(),
      maxAge: (json['maxAge'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'logoUrl': logoUrl,
      'supportedLoanTypes': supportedLoanTypes,
      'minIncome': minIncome,
      'maxLoanAmount': maxLoanAmount,
      'minLoanAmount': minLoanAmount, // New
      'minCibilScore': minCibilScore, // New
      'multiplier': multiplier,       // New
      'interestRate': interestRate,
      'ltv': ltv,
      'keyFeatures': keyFeatures,
      'applicationUrl': applicationUrl,
      'tagline': tagline,
      'minAge': minAge,
      'maxAge': maxAge,
    };
  }
}
