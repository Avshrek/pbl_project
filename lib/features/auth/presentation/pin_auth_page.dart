import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dfei_opus/core/theme/tactical_theme.dart';
import 'package:dfei_opus/features/auth/providers/auth_provider.dart';

/// PIN entry / setup page.
///
/// Displayed on app launch. If first-time, prompts for officer name
/// and PIN creation. Otherwise prompts for PIN verification.
class PinAuthPage extends ConsumerStatefulWidget {
  const PinAuthPage({super.key});

  @override
  ConsumerState<PinAuthPage> createState() => _PinAuthPageState();
}

class _PinAuthPageState extends ConsumerState<PinAuthPage> {
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String _error = '';
  bool _loading = false;

  @override
  void dispose() {
    _pinController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit(AuthStatus status) async {
    setState(() {
      _error = '';
      _loading = true;
    });

    final String pin = _pinController.text.trim();
    final AuthNotifier notifier = ref.read(authProvider.notifier);

    if (status == AuthStatus.firstTime) {
      final String name = _nameController.text.trim();
      if (name.isEmpty) {
        setState(() {
          _error = 'Officer name is required.';
          _loading = false;
        });
        return;
      }
      if (pin.length < 4) {
        setState(() {
          _error = 'PIN must be at least 4 digits.';
          _loading = false;
        });
        return;
      }
      await notifier.setupPin(pin, name);
    } else {
      final bool success = await notifier.authenticate(pin);
      if (!success) {
        setState(() {
          _error = 'Invalid PIN. Try again.';
          _loading = false;
        });
        _pinController.clear();
        return;
      }
    }

    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final AuthState auth = ref.watch(authProvider);

    if (auth.status == AuthStatus.unknown) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final bool isFirstTime = auth.status == AuthStatus.firstTime;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Shield icon
                Icon(
                  Icons.shield_outlined,
                  size: 64,
                  color: TacticalTheme.neonBlue,
                ),
                const SizedBox(height: 16),

                // Title
                Text(
                  'DFEI',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: TacticalTheme.neonBlue,
                        letterSpacing: 4,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Digital Forensic Evidence Identifier',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 40),

                // Subtitle
                Text(
                  isFirstTime ? 'INITIAL SETUP' : 'AUTHENTICATE',
                  style: TacticalTheme.monoDataBold,
                ),
                const SizedBox(height: 24),

                // Officer name (first time only)
                if (isFirstTime) ...[
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Officer Name',
                      prefixIcon: Icon(Icons.badge_outlined),
                    ),
                    textCapitalization: TextCapitalization.words,
                  ),
                  const SizedBox(height: 16),
                ],

                // PIN field
                TextField(
                  controller: _pinController,
                  decoration: InputDecoration(
                    labelText: isFirstTime ? 'Create PIN' : 'Enter PIN',
                    prefixIcon: const Icon(Icons.lock_outline),
                  ),
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  maxLength: 8,
                  onSubmitted: (_) => _handleSubmit(auth.status),
                ),
                const SizedBox(height: 8),

                // Error message
                if (_error.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      _error,
                      style: TextStyle(
                        color: TacticalTheme.critical,
                        fontSize: 13,
                      ),
                    ),
                  ),

                // Submit button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        _loading ? null : () => _handleSubmit(auth.status),
                    child: _loading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(isFirstTime ? 'SET UP' : 'UNLOCK'),
                  ),
                ),
                const SizedBox(height: 24),

                // Security notice
                Text(
                  'All data encrypted at rest',
                  style: TacticalTheme.monoDataSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
