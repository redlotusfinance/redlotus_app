import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/bank_provider.dart';
import 'submission_detail_screen.dart'; // Import the detail screen

class SubmissionListScreen extends StatefulWidget {
  const SubmissionListScreen({super.key});

  @override
  State<SubmissionListScreen> createState() => _SubmissionListScreenState();
}

class _SubmissionListScreenState extends State<SubmissionListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BankProvider>(context, listen: false).fetchSubmissions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BankProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading && provider.submissions.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.errorMessage != null) {
          return Center(child: Text('Error: ${provider.errorMessage}'));
        }

        if (provider.submissions.isEmpty) {
          return const Center(child: Text('No submissions found.'));
        }

        return RefreshIndicator(
          onRefresh: () => provider.fetchSubmissions(),
          child: ListView.builder(
            itemCount: provider.submissions.length,
            itemBuilder: (context, index) {
              final submission = provider.submissions[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(submission.customerName ?? 'Unknown User'),
                  subtitle: Text('${submission.loanPurpose ?? "N/A"} - ${submission.phoneNumber ?? "N/A"}'),
                  trailing: Text(submission.submissionDate != null 
                      ? "${submission.submissionDate!.day}/${submission.submissionDate!.month}/${submission.submissionDate!.year}"
                      : ""),
                  onTap: () {
                    // Navigate to detail screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SubmissionDetailScreen(submission: submission)),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
