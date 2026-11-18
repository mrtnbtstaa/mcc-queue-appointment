import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/common_bottom_sheet.dart';
import '../../../../../core/widgets/common_responsive_modal.dart';
import '../../../../../core/widgets/common_elevated_button.dart';
import '../../../../shared/filter_options/domain/filter_options.dart';
import '../../../../shared/filter_options/presentation/filter_options_cubit.dart';
import '../../../../shared/services/domain/entities/service_entity.dart';
import '../../../../shared/services/presentation/bloc/manage_services_bloc.dart';
import '../../../../shared/services/presentation/bloc/manage_services_event.dart';
import '../../../../shared/services/presentation/bloc/manage_services_state.dart';
import 'required_document_field.dart';

class AddRegistrarServiceBottomSheet extends StatefulWidget {
  const AddRegistrarServiceBottomSheet({super.key, this.serviceToEdit});

  final ServiceEntity? serviceToEdit;

  static void showAddServiceModal(
    BuildContext context, {
    ServiceEntity? service,
  }) {
    CommonResponsiveModal.show<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<ManageServicesBloc>(),
        child: AddRegistrarServiceBottomSheet(serviceToEdit: service),
      ),
    );
  }

  @override
  State<AddRegistrarServiceBottomSheet> createState() =>
      _AddRegistrarServiceBottomSheetState();
}

class _AddRegistrarServiceBottomSheetState
    extends State<AddRegistrarServiceBottomSheet> {
  late final TextEditingController _serviceNameController;
  late final TextEditingController _feeController;
  late final TextEditingController _durationMinController;
  late final TextEditingController _durationMaxController;

  late final List<FilterOption> _categories;
  late String _selectedCategory;
  late bool _isActiveForBooking;
  late List<String> _documents;

  bool _isSubmitting = false;

  bool get _isEditing => widget.serviceToEdit != null;

  @override
  void initState() {
    super.initState();
    final service = widget.serviceToEdit;

    _serviceNameController = TextEditingController(text: service?.name ?? '');
    _feeController = TextEditingController(text: service?.fee ?? '0.00');
    _durationMinController = TextEditingController(
      text: (service?.durationMin ?? 15).toString(),
    );
    _durationMaxController = TextEditingController(
      text: (service?.durationMax ?? 30).toString(),
    );

    // Keep the saved category selectable even if it isn't in the backend list.
    final existing = service?.category;
    final options = context
        .read<FilterOptionsCubit>()
        .state
        .options
        .serviceCategories;
    _categories = [
      ...options,
      if (existing != null &&
          existing.isNotEmpty &&
          !options.any((option) => option.value == existing))
        FilterOption(value: existing, label: existing),
    ];
    _selectedCategory =
        (existing != null &&
            _categories.any((option) => option.value == existing))
        ? existing
        : (_categories.isEmpty ? '' : _categories.first.value);

    _isActiveForBooking = service?.isActive ?? true;

    // Default documents only when creating a new service.
    _documents = List<String>.of(
      service != null
          ? service.requiredDocuments
          : const ['Valid MCC Student ID', 'Official Request Slip'],
    );
  }

  @override
  void dispose() {
    _serviceNameController.dispose();
    _feeController.dispose();
    _durationMinController.dispose();
    _durationMaxController.dispose();
    super.dispose();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _submitForm(BuildContext context) {
    if (_isSubmitting) return;

    final name = _serviceNameController.text.trim();
    if (name.isEmpty) {
      _showError('Please enter a service name');
      return;
    }

    final feeText = _feeController.text.trim();
    if (double.tryParse(feeText) == null) {
      _showError('Please enter a valid fee');
      return;
    }

    final durationMin = int.tryParse(_durationMinController.text.trim());
    final durationMax = int.tryParse(_durationMaxController.text.trim());
    if (durationMin == null || durationMax == null) {
      _showError('Please enter the processing duration in minutes');
      return;
    }
    if (durationMax < durationMin) {
      _showError('Maximum duration must be at least the minimum');
      return;
    }
    if (_selectedCategory.isEmpty) {
      _showError('Please select a category');
      return;
    }

    final serviceEntity = ServiceEntity(
      id: widget.serviceToEdit?.id,
      name: name,
      category: _selectedCategory,
      fee: feeText,
      durationMin: durationMin,
      durationMax: durationMax,
      requiredDocuments: List<String>.of(_documents),
      isActive: _isActiveForBooking,
    );

    setState(() => _isSubmitting = true);

    final bloc = context.read<ManageServicesBloc>();
    if (_isEditing) {
      bloc.add(
        UpdateService(
          id: widget.serviceToEdit?.id ?? '',
          service: serviceEntity,
        ),
      );
    } else {
      bloc.add(CreateService(serviceEntity));
    }
    // The sheet is closed by the BlocListener when the save succeeds.
  }

  InputDecoration _inputDecoration({String? hint, String? prefix}) {
    OutlineInputBorder border(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color),
    );

    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: TAppColors.textHint, fontSize: 13),
      prefixText: prefix,
      prefixStyle: const TextStyle(
        color: TAppColors.textSecondary,
        fontSize: 13,
      ),
      filled: true,
      fillColor: TAppColors.inputFill,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: border(TAppColors.border),
      enabledBorder: border(TAppColors.border),
      focusedBorder: border(TAppColors.primary),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: TAppColors.textPrimary,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ManageServicesBloc, ManageServicesState>(
      listenWhen: (previous, current) =>
          previous.mutationStatus != current.mutationStatus,
      listener: (context, state) {
        if (state.mutationStatus == MutationStatus.success) {
          Navigator.pop(context);
        } else if (state.mutationStatus == MutationStatus.failure) {
          setState(() => _isSubmitting = false);
          _showError(state.errorMessage ?? 'Save failed');
        }
      },
      child: CommonBottomSheet(
        onClosing: () {},
        showDragHandle: false,
        padding: EdgeInsets.zero,
        builder: (context) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: TAppColors.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: TAppColors.primary,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: TAppColors.surface.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          _isEditing ? Icons.edit : Icons.add,
                          color: TAppColors.surface,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _isEditing
                                  ? 'Edit Registrar Service'
                                  : 'Add New Registrar Service',
                              style: const TextStyle(
                                color: TAppColors.surface,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Configure transaction offering for MCC students',
                              style: TextStyle(
                                color: TAppColors.mutedOnPrimary,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.close,
                          color: TAppColors.surface,
                          size: 20,
                        ),
                        splashRadius: 20,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),

                // Form Body Content (Scrollable)
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Service Name
                        _label('Service Name'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _serviceNameController,
                          style: const TextStyle(
                            fontSize: 13,
                            color: TAppColors.textPrimary,
                          ),
                          decoration: _inputDecoration(
                            hint: 'e.g., Certificate of Enrollment',
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Category Classification
                        _label('Category Classification'),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: TAppColors.inputFill,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: TAppColors.border),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value:
                                  _categories.any(
                                    (option) =>
                                        option.value == _selectedCategory,
                                  )
                                  ? _selectedCategory
                                  : null,
                              hint: const Text(
                                'Select category',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: TAppColors.textHint,
                                ),
                              ),
                              isExpanded: true,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: TAppColors.textSecondary,
                                size: 20,
                              ),
                              style: const TextStyle(
                                fontSize: 13,
                                color: TAppColors.textPrimary,
                              ),
                              items: _categories
                                  .map(
                                    (option) => DropdownMenuItem<String>(
                                      value: option.value,
                                      child: Text(option.label),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() => _selectedCategory = newValue);
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Service Fee
                        _label('Service Fee (₱)'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _feeController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          style: const TextStyle(
                            fontSize: 13,
                            color: TAppColors.textPrimary,
                          ),
                          decoration: _inputDecoration(prefix: '₱ '),
                        ),
                        const SizedBox(height: 14),

                        // Processing Duration (min / max in minutes)
                        _label('Processing Duration (minutes)'),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _durationMinController,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: TAppColors.textPrimary,
                                ),
                                decoration: _inputDecoration(hint: 'Min'),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                '–',
                                style: TextStyle(
                                  color: TAppColors.textSecondary,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _durationMaxController,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: TAppColors.textPrimary,
                                ),
                                decoration: _inputDecoration(hint: 'Max'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Required Student Documents Component
                        RequiredDocumentsField(
                          initialDocuments: _documents,
                          onChanged: (updatedDocs) {
                            // The field owns its UI state; the parent only
                            // needs the latest list for saving.
                            _documents = List<String>.of(updatedDocs);
                          },
                        ),
                        const SizedBox(height: 16),

                        // Active for Student Booking Toggle Card
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: TAppColors.inputFill,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: TAppColors.border),
                          ),
                          child: Row(
                            children: [
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Active for Student Booking',
                                      style: TextStyle(
                                        color: TAppColors.textPrimary,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      'When enabled, students can queue and book appointments for this service',
                                      style: TextStyle(
                                        color: TAppColors.textSecondary,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Switch.adaptive(
                                value: _isActiveForBooking,
                                activeThumbColor: TAppColors.surface,
                                activeTrackColor: TAppColors.success,
                                onChanged: (val) {
                                  setState(() => _isActiveForBooking = val);
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Submit / Save Button
                        CommonElevatedButton(
                          // style: ElevatedButton.styleFrom(
                          //   backgroundColor: TAppColors.primary,
                          //   padding: const EdgeInsets.symmetric(vertical: 14),
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(12),
                          //   ),
                          // ),
                          onButtonPressed: _isSubmitting
                              ? null
                              : () => _submitForm(context),
                          custom: _isSubmitting
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: TAppColors.surface,
                                  ),
                                )
                              : Text(
                                  _isEditing
                                      ? 'Save Changes'
                                      : 'Create Registrar Service',
                                  style: const TextStyle(
                                    color: TAppColors.surface,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
