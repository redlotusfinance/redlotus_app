import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/form_provider.dart';
import '../widgets/form_steps/form_step_personal.dart';
import '../widgets/form_steps/form_step_address.dart';
import '../widgets/form_steps/form_step_financial.dart';
import '../widgets/form_steps/form_step_review.dart';
import 'submission_success_screen.dart';

class MultiStepFormScreen extends StatefulWidget {
  const MultiStepFormScreen({super.key});

  @override
  State<MultiStepFormScreen> createState() => _MultiStepFormScreenState();
}

class _MultiStepFormScreenState extends State<MultiStepFormScreen> {
  int _currentStep = 0;

  void _goToStep(int step) {
    setState(() {
      _currentStep = step;
    });
  }

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Application Form'),
      ),
      body: formProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stepper(
              type: StepperType.horizontal,
              currentStep: _currentStep,
              onStepContinue: () async {
                bool isStepValid = false;
                if (_currentStep == 0) {
                  isStepValid = formProvider.validateStep(formProvider.personalInfoFormKey);
                } else if (_currentStep == 1) {
                  isStepValid = formProvider.validateStep(formProvider.addressFormKey);
                } else if (_currentStep == 2) {
                  isStepValid = formProvider.validateStep(formProvider.financialFormKey);
                }

                if (isStepValid && _currentStep < 3) {
                  setState(() {
                    _currentStep += 1;
                  });
                } else if (_currentStep == 3) {
                  final success = await formProvider.submitForm();
                  if (success) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const SubmissionSuccessScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(formProvider.errorMessage ?? 'An unknown error occurred.')),
                    );
                  }
                }
              },
              onStepCancel: () {
                if (_currentStep > 0) {
                  setState(() {
                    _currentStep -= 1;
                  });
                }
              },
              steps: [
                Step(
                  title: const Text('Personal'),
                  content: const FormStepPersonal(),
                  isActive: _currentStep >= 0,
                  state: _currentStep > 0 ? StepState.complete : StepState.indexed,
                ),
                Step(
                  title: const Text('Address'),
                  content: const FormStepAddress(),
                  isActive: _currentStep >= 1,
                  state: _currentStep > 1 ? StepState.complete : StepState.indexed,
                ),
                Step(
                  title: const Text('Financial'),
                  content: const FormStepFinancial(),
                  isActive: _currentStep >= 2,
                  state: _currentStep > 2 ? StepState.complete : StepState.indexed,
                ),
                Step(
                  title: const Text('Review'),
                  content: FormStepReview(
                    onEditPersonal: () => _goToStep(0),
                    onEditAddress: () => _goToStep(1),
                    onEditFinancial: () => _goToStep(2),
                  ),
                  isActive: _currentStep >= 3,
                ),
              ],
            ),
    );
  }
}
