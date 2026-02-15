import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:dfei_opus/core/constants/app_constants.dart';
import 'package:dfei_opus/core/utils/hash_utils.dart';

/// Authentication state.
enum AuthStatus { unknown, authenticated, unauthenticated, firstTime }

/// Holds the current auth state and the officer name once authenticated.
class AuthState {
  const AuthState({
    required this.status,
    this.officerName = '',
  });

  final AuthStatus status;
  final String officerName;

  AuthState copyWith({AuthStatus? status, String? officerName}) {
    return AuthState(
      status: status ?? this.status,
      officerName: officerName ?? this.officerName,
    );
  }
}

/// Manages PIN-based authentication backed by secure storage.
///
/// On first launch the officer sets a PIN. On subsequent launches
/// the stored hash is compared against the entered PIN.
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._storage)
      : super(const AuthState(status: AuthStatus.unknown)) {
    _init();
  }

  final FlutterSecureStorage _storage;

  Future<void> _init() async {
    final String? existingPin =
        await _storage.read(key: AppConstants.secureKeyPin);
    if (existingPin == null || existingPin.isEmpty) {
      state = state.copyWith(status: AuthStatus.firstTime);
    } else {
      state = state.copyWith(status: AuthStatus.unauthenticated);
    }
  }

  /// Set a new PIN (first-time setup).
  Future<bool> setupPin(String pin, String officerName) async {
    if (pin.length < 4) return false;

    final String hashedPin = HashUtils.sha256Hash(pin);
    await _storage.write(key: AppConstants.secureKeyPin, value: hashedPin);
    await _storage.write(key: 'dfei_officer_name', value: officerName);

    state = AuthState(
      status: AuthStatus.authenticated,
      officerName: officerName,
    );
    return true;
  }

  /// Verify a PIN against the stored hash.
  Future<bool> authenticate(String pin) async {
    final String? storedHash =
        await _storage.read(key: AppConstants.secureKeyPin);
    if (storedHash == null) return false;

    final String inputHash = HashUtils.sha256Hash(pin);
    if (inputHash == storedHash) {
      final String officerName =
          await _storage.read(key: 'dfei_officer_name') ?? 'Unknown Officer';
      state = AuthState(
        status: AuthStatus.authenticated,
        officerName: officerName,
      );
      return true;
    }
    return false;
  }

  /// Lock the app (e.g., on background / manual lock).
  void lock() {
    state = state.copyWith(status: AuthStatus.unauthenticated);
  }
}

/// Secure storage provider.
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
});

/// Auth state provider.
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final FlutterSecureStorage storage = ref.watch(secureStorageProvider);
  return AuthNotifier(storage);
});
