import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/bank_model.dart';
import '../config.dart';

class AdminService {
  final String _apiKey = 'YOUR_SUPER_SECRET_API_KEY'; // Use the same key as in the backend

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'x-api-key': _apiKey,
  };

  Future<List<Bank>> getAllBanks() async {
    final uri = Uri.parse('$apiBaseUrl/api/admin/banks');
    final response = await http.get(uri, headers: { 'x-api-key': _apiKey });

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Bank.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load banks: ${response.body}');
    }
  }

  Future<Bank> addBank(Bank bank) async {
    final uri = Uri.parse('$apiBaseUrl/api/admin/banks');
    final response = await http.post(
      uri,
      headers: _headers,
      body: json.encode(bank.toJson()),
    );

    if (response.statusCode == 201) {
      return Bank.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to add bank: ${response.body}');
    }
  }

  Future<Bank> updateBank(String id, Bank bank) async {
    final uri = Uri.parse('$apiBaseUrl/api/admin/banks/$id');
    final response = await http.put(
      uri,
      headers: _headers,
      body: json.encode(bank.toJson()),
    );

    if (response.statusCode == 200) {
      return Bank.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to update bank: ${response.body}');
    }
  }

  Future<void> deleteBank(String id) async {
    final uri = Uri.parse('$apiBaseUrl/api/admin/banks/$id');
    final response = await http.delete(
      uri,
      headers: { 'x-api-key': _apiKey },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete bank: ${response.body}');
    }
  }
}
