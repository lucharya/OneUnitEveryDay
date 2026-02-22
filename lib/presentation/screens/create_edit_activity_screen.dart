import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';

import '../../core/design/design.dart';
import '../../domain/entities/activity.dart';
import '../providers/activity_providers.dart';

/// Screen for creating or editing an activity
class CreateEditActivityScreen extends ConsumerStatefulWidget {
  final Activity? activity;

  const CreateEditActivityScreen({
    super.key,
    this.activity,
  });

  bool get isEditing => activity != null;

  @override
  ConsumerState<CreateEditActivityScreen> createState() =>
      _CreateEditActivityScreenState();
}

class _CreateEditActivityScreenState
    extends ConsumerState<CreateEditActivityScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.activity?.name ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.activity?.description ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_isSaving) return;

    setState(() => _isSaving = true);

    final l10n = AppLocalizations.of(context)!;
    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim();

    try {
      if (widget.isEditing) {
        await ref.read(activitiesProvider.notifier).updateActivity(
              activity: widget.activity!,
              name: name,
              description: description.isEmpty ? null : description,
            );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.activityUpdated)),
          );
        }
      } else {
        await ref.read(activitiesProvider.notifier).createActivity(
              name: name,
              description: description.isEmpty ? null : description,
            );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.activityCreated)),
          );
        }
      }

      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isEditing = widget.isEditing;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? l10n.editActivity : l10n.createActivity,
          style: AppTypography.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Name field
              Text(
                l10n.activityName,
                style: AppTypography.labelLarge,
              ),
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.sentences,
                autofocus: !isEditing,
                decoration: InputDecoration(
                  hintText: l10n.activityName,
                  hintStyle: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
                style: AppTypography.bodyLarge,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.activityNameRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Description field
              Text(
                l10n.activityDescription,
                style: AppTypography.labelLarge,
              ),
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: _descriptionController,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: l10n.activityDescription,
                  hintStyle: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
                style: AppTypography.bodyLarge,
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // Type indicator
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: AppRadius.borderRadiusMd,
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.repeat,
                      color: AppColors.primary,
                      size: 22,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Text(
                      l10n.daily,
                      style: AppTypography.titleMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // Save button
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.borderRadiusMd,
                    ),
                    textStyle: AppTypography.titleLarge,
                  ),
                  child: _isSaving
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(l10n.save),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
