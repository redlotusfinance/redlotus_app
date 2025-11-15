import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/bank_model.dart';
import '../config.dart';

class BankService {
  Future<List<Bank>> getMatchedBanks(String loanPurpose, double monthlyIncome) async {
    final uri = Uri.parse('$apiBaseUrl/api/banks/match?loanPurpose=$loanPurpose&monthlyIncome=$monthlyIncome');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Bank.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load banks');
    }
  }
}
