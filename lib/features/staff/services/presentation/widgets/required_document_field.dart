import 'package:material_ui/material_ui.dart';

import '../../../../../../core/theme/app_colors.dart';

class RequiredDocumentsField extends StatefulWidget {
  const RequiredDocumentsField({
    super.key,
    required this.initialDocuments,
    required this.onChanged,
  });

  final List<String> initialDocuments;
  final ValueChanged<List<String>> onChanged;

  @override
  State<RequiredDocumentsField> createState() => _RequiredDocumentsFieldState();
}

class _RequiredDocumentsFieldState extends State<RequiredDocumentsField> {
  late List<String> _documents;

  @override
  void initState() {
    super.initState();
    _documents = List.of(widget.initialDocuments);
  }

  void _notify() => widget.onChanged(List.unmodifiable(_documents));

  Future<void> _showAddDocumentDialog() async {
    final result = await showDialog<String>(
      context: context,
      builder: (_) => _AddDocumentDialog(existing: _documents),
    );

    if (result != null && mounted) {
      setState(() => _documents = [..._documents, result]);
      _notify();
    }
  }

  void _removeAt(int index) {
    setState(() => _documents = List.of(_documents)..removeAt(index));
    _notify();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Required Student Documents',
              style: TextStyle(
                color: TAppColors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            InkWell(
              onTap: _showAddDocumentDialog,
              child: const Row(
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    color: TAppColors.primary,
                    size: 14,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Add Doc',
                    style: TextStyle(
                      color: TAppColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (_documents.isEmpty)
          const Text(
            'No required documents added yet.',
            style: TextStyle(color: TAppColors.textMuted, fontSize: 11),
          )
        else
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: [
              for (var i = 0; i < _documents.length; i++)
                Chip(
                  label: Text(
                    _documents[i],
                    style: const TextStyle(fontSize: 11),
                  ),
                  deleteIcon: const Icon(Icons.close, size: 14),
                  onDeleted: () => _removeAt(i),
                ),
            ],
          ),
      ],
    );
  }
}

class _AddDocumentDialog extends StatefulWidget {
  const _AddDocumentDialog({required this.existing});

  final List<String> existing;

  @override
  State<_AddDocumentDialog> createState() => _AddDocumentDialogState();
}

class _AddDocumentDialogState extends State<_AddDocumentDialog> {
  final TextEditingController _controller = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _controller.text.trim();
    if (name.isEmpty) {
      setState(() => _error = 'Enter a document name');
      return;
    }
    final exists = widget.existing.any(
      (d) => d.toLowerCase() == name.toLowerCase(),
    );
    if (exists) {
      setState(() => _error = 'Already added');
      return;
    }
    Navigator.pop(context, name);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Add Required Document',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      content: TextField(
        controller: _controller,
        autofocus: true,
        textInputAction: TextInputAction.done,
        onChanged: (_) {
          if (_error != null) setState(() => _error = null);
        },
        onSubmitted: (_) => _submit(),
        decoration: InputDecoration(
          hintText: 'e.g., Valid School ID, Form 138',
          errorText: _error,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(onPressed: _submit, child: const Text('Add')),
      ],
    );
  }
}
