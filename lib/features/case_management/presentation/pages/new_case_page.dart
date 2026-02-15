import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:dfei_opus/core/constants/app_constants.dart';
import 'package:dfei_opus/core/theme/tactical_theme.dart';
import 'package:dfei_opus/core/utils/timestamp_utils.dart';
import 'package:dfei_opus/features/auth/providers/auth_provider.dart';
import 'package:dfei_opus/features/case_management/domain/entities/case_entity.dart';
import 'package:dfei_opus/features/case_management/presentation/providers/case_providers.dart';

/// Page for creating a new forensic case / incident.
///
/// Auto-fills date/time and officer name from the auth state.
/// Officer selects crime type and enters location details.
class NewCasePage extends ConsumerStatefulWidget {
  const NewCasePage({super.key});

  @override
  ConsumerState<NewCasePage> createState() => _NewCasePageState();
}

class _NewCasePageState extends ConsumerState<NewCasePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  String _selectedCrimeType = AppConstants.crimeTypes.first;
  bool _submitting = false;

  @override
  void dispose() {
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _submitting = true);

    final AuthState auth = ref.read(authProvider);
    final DateTime now = TimestampUtils.nowUtc();
    final String caseNumber =
        'DFEI-${now.year}${now.month.toString().padLeft(2, '0')}'
        '${now.day.toString().padLeft(2, '0')}-'
        '${const Uuid().v4().substring(0, 8).toUpperCase()}';

    final CaseEntity newCase = CaseEntity(
      caseNumber: caseNumber,
      crimeType: _selectedCrimeType,
      location: _locationController.text.trim(),
      officerName: auth.officerName,
      notes: _notesController.text.trim(),
      createdAt: now,
      updatedAt: now,
    );

    try {
      final int caseId =
          await ref.read(caseRepositoryProvider).createCase(newCase);

      // Invalidate the cases list so it refreshes.
      ref.invalidate(activeCasesProvider);

      if (mounted) {
        // Navigate to the triage dashboard for this case.
        Navigator.pop(context);
        Navigator.pushNamed(
          context,
          '/triage',
          arguments: newCase.copyWith(id: caseId),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create case: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthState auth = ref.watch(authProvider);
    final DateTime now = TimestampUtils.nowUtc();

    return Scaffold(
      appBar: AppBar(title: const Text('New Incident')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Auto-filled metadata
              _readOnlyField(
                label: 'Officer',
                value: auth.officerName,
                icon: Icons.badge_outlined,
              ),
              const SizedBox(height: 12),
              _readOnlyField(
                label: 'Date / Time (UTC)',
                value: TimestampUtils.toDisplay(now),
                icon: Icons.access_time,
              ),
              const SizedBox(height: 20),

              // Crime type dropdown
              Text(
                'CRIME TYPE',
                style: TacticalTheme.monoDataSmall.copyWith(
                  color: TacticalTheme.neonBlue,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedCrimeType,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.category_outlined),
                ),
                dropdownColor: TacticalTheme.surfaceVariant,
                items: AppConstants.crimeTypes
                    .map(
                      (String type) => DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      ),
                    )
                    .toList(),
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() => _selectedCrimeType = value);
                  }
                },
              ),
              const SizedBox(height: 20),

              // Location
              Text(
                'LOCATION',
                style: TacticalTheme.monoDataSmall.copyWith(
                  color: TacticalTheme.neonBlue,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  hintText: 'e.g., 742 Evergreen Terrace, Apt 2B',
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Location is required';
                  }
                  return null;
                },
                maxLines: 2,
              ),
              const SizedBox(height: 20),

              // Notes
              Text(
                'INITIAL NOTES',
                style: TacticalTheme.monoDataSmall.copyWith(
                  color: TacticalTheme.neonBlue,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  hintText: 'Optional scene notes...',
                  prefixIcon: Icon(Icons.notes_outlined),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 32),

              // Submit
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _submitting ? null : _submit,
                  icon: _submitting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.add_circle_outline),
                  label: Text(_submitting ? 'CREATING...' : 'CREATE CASE'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _readOnlyField({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: TacticalTheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: TacticalTheme.divider),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: TacticalTheme.textMuted),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 2),
              Text(value, style: TacticalTheme.monoData),
            ],
          ),
        ],
      ),
    );
  }
}
