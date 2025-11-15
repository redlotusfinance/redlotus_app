import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/form_provider.dart';
import '../services/bank_service.dart';
import '../widgets/bank_card.dart';
import '../models/bank_model.dart';

class BankResultsScreen extends StatefulWidget {
  const BankResultsScreen({super.key});

  @override
  State<BankResultsScreen> createState() => _BankResultsScreenState();
}

class _BankResultsScreenState extends State<BankResultsScreen> {
  late Future<List<Bank>> _matchedBanksFuture;

  @override
  void initState() {
    super.initState();
    final formProvider = Provider.of<FormProvider>(context, listen: false);
    _matchedBanksFuture = BankService().getMatchedBanks(
      formProvider.loanPurpose!,
      formProvider.monthlyIncome!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matched Banks'),
      ),
      body: FutureBuilder<List<Bank>>(
        future: _matchedBanksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No banks found matching your criteria.'));
          } else {
            final banks = snapshot.data!;
            return ListView.builder(
              itemCount: banks.length,
              itemBuilder: (context, index) {
                return BankCard(bank: banks[index]);
              },
            );
          }
        },
      ),
    );
  }
}
