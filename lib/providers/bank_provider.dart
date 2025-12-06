import 'package:flutter/material.dart';
import '../services/admin_service.dart';
import '../models/bank_model.dart';
import '../models/user_submission_model.dart';

class BankProvider with ChangeNotifier {
  final AdminService _adminService = AdminService();
  
  // Bank State
  List<Bank> _banks = [];
  List<Bank> get banks => _banks;

  // Submission State
  List<UserSubmission> _submissions = [];
  List<UserSubmission> get submissions => _submissions;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // --- Bank Methods ---

  Future<void> fetchBanks() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _banks = await _adminService.getAllBanks();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addBank(Bank bank) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _adminService.addBank(bank);
      await fetchBanks(); // Refresh the list
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateBank(String id, Bank bank) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _adminService.updateBank(id, bank);
      await fetchBanks(); // Refresh the list
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteBank(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _adminService.deleteBank(id);
      _banks.removeWhere((bank) => bank.id == id); // Optimistic update
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      await fetchBanks(); 
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // --- Submission Methods ---

  Future<void> fetchSubmissions() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _submissions = await _adminService.getAllSubmissions();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
