import 'dart:convert';

import 'package:crypto/crypto.dart';

/// Utilities for SHA-256 hashing used in chain-of-custody verification.
///
/// Each audit log entry is hashed with its content and the previous entry's
/// hash, forming a tamper-evident linked chain similar to a blockchain.
class HashUtils {
  HashUtils._();

  /// Compute a SHA-256 hash of the given [input] string.
  static String sha256Hash(String input) {
    final List<int> bytes = utf8.encode(input);
    final Digest digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Compute the chain-of-custody hash for an audit log entry.
  ///
  /// Combines [action], [timestamp] (ISO 8601), [details], and
  /// [previousHash] into a deterministic hash.
  static String computeAuditHash({
    required String action,
    required String timestamp,
    required String details,
    required String previousHash,
  }) {
    final String payload = '$action|$timestamp|$details|$previousHash';
    return sha256Hash(payload);
  }

  /// Verify that a given [hash] matches the recomputed hash from its inputs.
  static bool verifyAuditHash({
    required String action,
    required String timestamp,
    required String details,
    required String previousHash,
    required String hash,
  }) {
    final String computed = computeAuditHash(
      action: action,
      timestamp: timestamp,
      details: details,
      previousHash: previousHash,
    );
    return computed == hash;
  }

  /// Compute a SHA-256 hash of raw bytes (e.g., for photo hashing).
  static String sha256HashBytes(List<int> bytes) {
    final Digest digest = sha256.convert(bytes);
    return digest.toString();
  }
}
