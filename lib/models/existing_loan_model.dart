class ExistingLoan {
  String? loanType;
  String? bankName;
  double? amount; // Represents EMI or Outstanding Amount

  ExistingLoan({
    this.loanType,
    this.bankName,
    this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'loanType': loanType,
      'bankName': bankName,
      'amount': amount,
    };
  }
}
