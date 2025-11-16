import 'package:flutter/material.dart';
import '../services/admin_service.dart';
import '../models/bank_model.dart';

class BankProvider with ChangeNotifier {
  final AdminService _adminService = AdminService();
  
  List<Bank> _banks = [];
  List<Bank> get banks => _banks;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

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
      // If the delete fails, we might need to refresh the list to be safe
      await fetchBanks(); 
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
