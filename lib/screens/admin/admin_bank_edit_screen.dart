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
  late TextEditingController _minLoanController; // New
  late TextEditingController _minCibilController; // New
  late TextEditingController _multiplierController; // New
  late TextEditingController _minRateController;
  late TextEditingController _maxRateController;
  late TextEditingController _ltvController;
  late TextEditingController _taglineController;
  late TextEditingController _appUrlController;
  late TextEditingController _keyFeaturesController;
  late TextEditingController _minAgeController;
  late TextEditingController _maxAgeController;
  List<String> _supportedLoanTypes = [];
  
  // Define the master list of loan types
  final List<String> _allLoanTypes = [
    'Business Loan',
    'Working Capital Loan',
    'Machinery Loan',
    'Construction Loan',
    'Solar Loan',
    'Marriege',
    'New Business Set-up',
    'Loan consolidation',
    'Credit card Payment',
    'Land Purchase',
    'Home Construction',
    'Land buy+Construction',
    'Business Expension',
    'Two wheeler',
    'New Car',
    'Old Car Finance',
    'SME Loan',
    'Personal Loan',
    'Home loan',
    'Loan Against Property',
    'Mortgage loan',
  ];


  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.bank?.name ?? '');
    _logoUrlController = TextEditingController(text: widget.bank?.logoUrl ?? '');
    _minIncomeController = TextEditingController(text: widget.bank?.minIncome.toString() ?? '');
    _maxLoanController = TextEditingController(text: widget.bank?.maxLoanAmount.toString() ?? '');
    _minLoanController = TextEditingController(text: widget.bank?.minLoanAmount.toString() ?? '0'); // New
    _minCibilController = TextEditingController(text: widget.bank?.minCibilScore.toString() ?? '0'); // New
    _multiplierController = TextEditingController(text: widget.bank?.multiplier.toString() ?? '1'); // New
    _minRateController = TextEditingController(text: widget.bank?.interestRate['min']?.toString() ?? '');
    _maxRateController = TextEditingController(text: widget.bank?.interestRate['max']?.toString() ?? '');
    _ltvController = TextEditingController(text: widget.bank?.ltv.toString() ?? '');
    _taglineController = TextEditingController(text: widget.bank?.tagline ?? '');
    _appUrlController = TextEditingController(text: widget.bank?.applicationUrl ?? '');
    _keyFeaturesController = TextEditingController(text: widget.bank?.keyFeatures.join(', ') ?? '');
    _minAgeController = TextEditingController(text: widget.bank?.minAge?.toString() ?? '18');
    _maxAgeController = TextEditingController(text: widget.bank?.maxAge?.toString() ?? '65');
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
        minLoanAmount: double.parse(_minLoanController.text), // New
        minCibilScore: int.parse(_minCibilController.text),   // New
        multiplier: double.parse(_multiplierController.text), // New
        interestRate: {
          'min': double.parse(_minRateController.text),
          'max': double.parse(_maxRateController.text),
        },
        ltv: double.parse(_ltvController.text),
        tagline: _taglineController.text,
        applicationUrl: _appUrlController.text,
        keyFeatures: _keyFeaturesController.text.split(',').map((e) => e.trim()).toList(),
        supportedLoanTypes: _supportedLoanTypes,
        minAge: int.tryParse(_minAgeController.text),
        maxAge: int.tryParse(_maxAgeController.text),
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
                
                const SizedBox(height: 16),
                const Text('Financial Criteria', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: TextFormField(controller: _minIncomeController, decoration: const InputDecoration(labelText: 'Min Income'), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null)),
                    const SizedBox(width: 16),
                    Expanded(child: TextFormField(controller: _minCibilController, decoration: const InputDecoration(labelText: 'Min Cibil'), keyboardType: TextInputType.number)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: TextFormField(controller: _minLoanController, decoration: const InputDecoration(labelText: 'Min Loan Amount'), keyboardType: TextInputType.number)),
                    const SizedBox(width: 16),
                    Expanded(child: TextFormField(controller: _maxLoanController, decoration: const InputDecoration(labelText: 'Max Loan Amount'), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: TextFormField(controller: _minRateController, decoration: const InputDecoration(labelText: 'Min Rate (%)'), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null)),
                    const SizedBox(width: 16),
                    Expanded(child: TextFormField(controller: _maxRateController, decoration: const InputDecoration(labelText: 'Max Rate (%)'), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: TextFormField(controller: _ltvController, decoration: const InputDecoration(labelText: 'LTV (%)'), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null)),
                    const SizedBox(width: 16),
                    Expanded(child: TextFormField(controller: _multiplierController, decoration: const InputDecoration(labelText: 'Multiplier'), keyboardType: TextInputType.number)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: TextFormField(controller: _minAgeController, decoration: const InputDecoration(labelText: 'Min Age'), keyboardType: TextInputType.number)),
                    const SizedBox(width: 16),
                    Expanded(child: TextFormField(controller: _maxAgeController, decoration: const InputDecoration(labelText: 'Max Age'), keyboardType: TextInputType.number)),
                  ],
                ),
                
                const SizedBox(height: 16),
                TextFormField(controller: _keyFeaturesController, decoration: const InputDecoration(labelText: 'Key Features (comma-separated)')),
                const SizedBox(height: 20),
                Text('Supported Loan Types', style: Theme.of(context).textTheme.titleMedium),
                // Use the new master list to build the checklist
                ..._allLoanTypes.map((type) {
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
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
