import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/bank_model.dart';
import '../models/existing_loan_model.dart';
import '../config.dart';

class BankService {
  Future<List<Bank>> getMatchedBanks(String loanPurpose, double monthlyIncome, List<ExistingLoan> existingLoans) async {
    final uri = Uri.parse('$apiBaseUrl/api/banks/match');
    
    final body = {
      'loanPurpose': loanPurpose,
      'monthlyIncome': monthlyIncome,
      'existingLoans': existingLoans.map((e) => e.toJson()).toList(),
    };

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Bank.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load banks: ${response.body}');
    }
  }
}
