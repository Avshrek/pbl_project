import 'package:intl/intl.dart';

/// Precision timestamp utilities for forensic logging.
///
/// All timestamps in DFEI are stored and displayed in UTC to ensure
/// consistency across jurisdictions and eliminate timezone ambiguity.
class TimestampUtils {
  TimestampUtils._();

  /// Returns the current UTC time.
  static DateTime nowUtc() => DateTime.now().toUtc();

  /// Formats a [DateTime] as ISO 8601 with microsecond precision.
  /// Example: `2026-02-12T08:06:18.123456Z`
  static String toIso8601(DateTime dt) {
    return dt.toUtc().toIso8601String();
  }

  /// Formats a [DateTime] for display in the UI.
  /// Example: `12 Feb 2026, 08:06:18 UTC`
  static String toDisplay(DateTime dt) {
    final DateFormat formatter = DateFormat('dd MMM yyyy, HH:mm:ss');
    return '${formatter.format(dt.toUtc())} UTC';
  }

  /// Formats a [DateTime] as a short date string.
  /// Example: `12/02/2026`
  static String toShortDate(DateTime dt) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dt.toUtc());
  }

  /// Formats a [DateTime] as a short time string.
  /// Example: `08:06:18`
  static String toShortTime(DateTime dt) {
    final DateFormat formatter = DateFormat('HH:mm:ss');
    return formatter.format(dt.toUtc());
  }

  /// Computes the elapsed time since [dt] as a human-readable string.
  static String timeAgo(DateTime dt) {
    final Duration diff = DateTime.now().toUtc().difference(dt.toUtc());
    if (diff.inSeconds < 60) return '${diff.inSeconds}s ago';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
