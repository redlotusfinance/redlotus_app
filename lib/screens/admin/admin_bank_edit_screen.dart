import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/bank_model.dart';
import '../../providers/bank_provider.dart';

class AdminBankEditScreen extends StatefulWidget {
  final Bank? bank; // If bank is null, it's a new bank

  const AdminBankEditScreen({super.key, this.bank});

  @override
  State<AdminBankEditScreen> createState() => _AdminBankEditScreenState();
}

class _AdminBankEditScreenState extends State<AdminBankEditScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers for all bank fields
  late TextEditingController _nameController;
  late TextEditingController _logoUrlController;
  late TextEditingController _minIncomeController;
  late TextEditingController _maxLoanController;
  late TextEditingController _minRateController;
  late TextEditingController _maxRateController;
  late TextEditingController _approvalRateController;
  late TextEditingController _taglineController;
  late TextEditingController _appUrlController;
  late TextEditingController _keyFeaturesController;
  List<String> _supportedLoanTypes = [];


  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing bank data or empty strings
    _nameController = TextEditingController(text: widget.bank?.name ?? '');
    _logoUrlController = TextEditingController(text: widget.bank?.logoUrl ?? '');
    _minIncomeController = TextEditingController(text: widget.bank?.minIncome.toString() ?? '');
    _maxLoanController = TextEditingController(text: widget.bank?.maxLoanAmount.toString() ?? '');
    _minRateController = TextEditingController(text: widget.bank?.interestRate['min']?.toString() ?? '');
    _maxRateController = TextEditingController(text: widget.bank?.interestRate['max']?.toString() ?? '');
    _approvalRateController = TextEditingController(text: widget.bank?.approvalRate.toString() ?? '');
    _taglineController = TextEditingController(text: widget.bank?.tagline ?? '');
    _appUrlController = TextEditingController(text: widget.bank?.applicationUrl ?? '');
    _keyFeaturesController = TextEditingController(text: widget.bank?.keyFeatures.join(', ') ?? '');
    _supportedLoanTypes = widget.bank?.supportedLoanTypes ?? [];
  }

  Future<void> _saveForm() async {
    if (_formKey.currentState!.validate()) {
      final bankProvider = Provider.of<BankProvider>(context, listen: false);

      final bankData = Bank(
        id: widget.bank?.id,
        name: _nameController.text,
        logoUrl: _logoUrlController.text,
        minIncome: double.parse(_minIncomeController.text),
        maxLoanAmount: double.parse(_maxLoanController.text),
        interestRate: {
          'min': double.parse(_minRateController.text),
          'max': double.parse(_maxRateController.text),
        },
        approvalRate: double.parse(_approvalRateController.text),
        tagline: _taglineController.text,
        applicationUrl: _appUrlController.text,
        keyFeatures: _keyFeaturesController.text.split(',').map((e) => e.trim()).toList(),
        supportedLoanTypes: _supportedLoanTypes,
      );

      bool success = false;
      if (widget.bank == null) {
        success = await bankProvider.addBank(bankData);
      } else {
        success = await bankProvider.updateBank(widget.bank!.id!, bankData);
      }

      if (success) {
        Navigator.pop(context); // Go back to the dashboard
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bank saved successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${bankProvider.errorMessage}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bank == null ? 'Add New Bank' : 'Edit Bank'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(controller: _nameController, decoration: const InputDecoration(labelText: 'Bank Name'), validator: (v) => v!.isEmpty ? 'Required' : null),
                TextFormField(controller: _logoUrlController, decoration: const InputDecoration(labelText: 'Logo URL'), validator: (v) => v!.isEmpty ? 'Required' : null),
                TextFormField(controller: _taglineController, decoration: const InputDecoration(labelText: 'Tagline'), validator: (v) => v!.isEmpty ? 'Required' : null),
                TextFormField(controller: _appUrlController, decoration: const InputDecoration(labelText: 'Application URL'), validator: (v) => v!.isEmpty ? 'Required' : null),
                TextFormField(controller: _minIncomeController, decoration: const InputDecoration(labelText: 'Minimum Income'), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null),
                TextFormField(controller: _maxLoanController, decoration: const InputDecoration(labelText: 'Max Loan Amount'), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null),
                TextFormField(controller: _minRateController, decoration: const InputDecoration(labelText: 'Min Interest Rate'), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null),
                TextFormField(controller: _maxRateController, decoration: const InputDecoration(labelText: 'Max Interest Rate'), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null),
                TextFormField(controller: _approvalRateController, decoration: const InputDecoration(labelText: 'Approval Rate (%)'), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null),
                TextFormField(controller: _keyFeaturesController, decoration: const InputDecoration(labelText: 'Key Features (comma-separated)')),
                const SizedBox(height: 20),
                Text('Supported Loan Types', style: Theme.of(context).textTheme.titleMedium),
                ...['Personal', 'Home', 'Mortgage', 'Business'].map((type) {
                  return CheckboxListTile(
                    title: Text(type),
                    value: _supportedLoanTypes.contains(type),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          _supportedLoanTypes.add(type);
                        } else {
                          _supportedLoanTypes.remove(type);
                        }
                      });
                    },
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
