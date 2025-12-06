import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/bank_provider.dart';
import 'admin_bank_edit_screen.dart';
import 'submission_list_screen.dart'; // Import the new screen

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Fetch banks initially
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BankProvider>(context, listen: false).fetchBanks();
    });
  }

  Future<void> _deleteBank(BankProvider provider, String bankId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to permanently delete this bank?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final success = await provider.deleteBank(bankId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? 'Bank deleted successfully!' : 'Error: ${provider.errorMessage}'),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );
    }
  }

  Widget _buildBankList(BankProvider bankProvider) {
    if (bankProvider.isLoading && bankProvider.banks.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (bankProvider.errorMessage != null) {
      return Center(child: Text('Error: ${bankProvider.errorMessage}'));
    }

    if (bankProvider.banks.isEmpty) {
      return const Center(child: Text('No banks found. Add one to get started.'));
    }

    return RefreshIndicator(
      onRefresh: () => bankProvider.fetchBanks(),
      child: ListView.builder(
        itemCount: bankProvider.banks.length,
        itemBuilder: (context, index) {
          final bank = bankProvider.banks[index];
          return ListTile(
            leading: Image.network(bank.logoUrl, width: 50, errorBuilder: (c, e, s) => const Icon(Icons.business)),
            title: Text(bank.name),
            subtitle: Text(bank.tagline),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminBankEditScreen(bank: bank),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteBank(bankProvider, bank.id!),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0 ? 'Manage Banks' : 'User Submissions'),
        actions: [
          if (_currentIndex == 0)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminBankEditScreen()),
                );
              },
            ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: _currentIndex == 0 
          ? Consumer<BankProvider>(builder: (ctx, provider, _) => _buildBankList(provider))
          : const SubmissionListScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: 'Banks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Submissions',
          ),
        ],
      ),
    );
  }
}
