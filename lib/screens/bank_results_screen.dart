import 'package:flutter/material.dart';
import '../services/bank_service.dart';
import '../widgets/bank_card.dart';
import '../models/bank_model.dart';

class BankResultsScreen extends StatefulWidget {
  final String loanPurpose;
  final double monthlyIncome;

  const BankResultsScreen({
    super.key,
    required this.loanPurpose,
    required this.monthlyIncome,
  });

  @override
  State<BankResultsScreen> createState() => _BankResultsScreenState();
}

class _BankResultsScreenState extends State<BankResultsScreen> {
  late Future<List<Bank>> _matchedBanksFuture;

  @override
  void initState() {
    super.initState();
    _matchedBanksFuture = BankService().getMatchedBanks(
      widget.loanPurpose,
      widget.monthlyIncome,
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
            return Center(child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Error: ${snapshot.error}', textAlign: TextAlign.center),
            ));
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
