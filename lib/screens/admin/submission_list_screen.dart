import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/bank_provider.dart';
import 'submission_detail_screen.dart';
import '../../services/excel_service.dart';
import '../../utils/web_file_downloader.dart';

class SubmissionListScreen extends StatefulWidget {
  const SubmissionListScreen({super.key});

  @override
  State<SubmissionListScreen> createState() => _SubmissionListScreenState();
}

class _SubmissionListScreenState extends State<SubmissionListScreen> {
  final Set<String> _selectedIds = {};
  bool _isExporting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BankProvider>(context, listen: false).fetchSubmissions();
    });
  }

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
  }

  void _selectAll(bool? select, List<dynamic> submissions) {
    setState(() {
      if (select == true) {
        _selectedIds.addAll(submissions.map((s) => s.id as String));
      } else {
        _selectedIds.clear();
      }
    });
  }

  Future<void> _exportSelected() async {
    final provider = Provider.of<BankProvider>(context, listen: false);
    final selectedSubmissions = provider.submissions
        .where((s) => _selectedIds.contains(s.id))
        .toList();

    if (selectedSubmissions.isEmpty) return;

    setState(() => _isExporting = true);

    try {
      final excelService = ExcelService();
      final bytes = excelService.generateExcel(selectedSubmissions);
      
      if (bytes != null) {
        downloadExcelWeb(bytes, 'User_Submissions_${DateTime.now().millisecondsSinceEpoch}.xlsx');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Export successful!')),
        );
        setState(() {
          _selectedIds.clear(); // Clear selection after export
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Export failed: $e')),
      );
    } finally {
      setState(() => _isExporting = false);
    }
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

        final allSelected = _selectedIds.length == provider.submissions.length && provider.submissions.isNotEmpty;

        return Column(
          children: [
            // Styled Action Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Checkbox(
                        value: allSelected,
                        onChanged: (val) => _selectAll(val, provider.submissions),
                        activeColor: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${_selectedIds.length} Selected',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const Spacer(),
                      if (_isExporting)
                        const SizedBox(
                          width: 20, 
                          height: 20, 
                          child: CircularProgressIndicator(strokeWidth: 2)
                        )
                      else
                        FilledButton.icon(
                          onPressed: _selectedIds.isEmpty ? null : _exportSelected,
                          icon: const Icon(Icons.download_rounded, size: 18),
                          label: const Text('Export Excel'),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            Expanded(
              child: RefreshIndicator(
                onRefresh: () => provider.fetchSubmissions(),
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: provider.submissions.length,
                  separatorBuilder: (ctx, idx) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final submission = provider.submissions[index];
                    final isSelected = _selectedIds.contains(submission.id);

                    return Card(
                      elevation: isSelected ? 4 : 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: isSelected 
                          ? BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)
                          : BorderSide.none,
                      ),
                      color: isSelected ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3) : null,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SubmissionDetailScreen(submission: submission)),
                          );
                        },
                        onLongPress: () => _toggleSelection(submission.id!),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: isSelected,
                                onChanged: (_) => _toggleSelection(submission.id!),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      submission.customerName ?? 'Unknown User',
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(Icons.description_outlined, size: 16, color: Colors.grey[600]),
                                        const SizedBox(width: 4),
                                        Text(
                                          submission.loanPurpose ?? "N/A",
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Icon(Icons.phone_outlined, size: 16, color: Colors.grey[600]),
                                        const SizedBox(width: 4),
                                        Text(
                                          submission.phoneNumber ?? "N/A",
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              if (submission.submissionDate != null)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${submission.submissionDate!.day}/${submission.submissionDate!.month}/${submission.submissionDate!.year}",
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const Icon(Icons.chevron_right, color: Colors.grey),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
