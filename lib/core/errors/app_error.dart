/// Machine-readable reason a subnet/CIDR calculation failed.
///
/// The domain throws these codes instead of user-facing strings so the
/// presentation layer can render them in the active locale.
enum AppError {
  /// Not four dot-separated octets.
  invalidIpv4,

  /// An octet is not a number in 0..255.
  invalidOctet,

  /// The input has no "/prefix" part.
  missingPrefix,

  /// The prefix is not a number in 0..32.
  prefixOutOfRange,

  /// Fewer than one subnet was requested.
  subnetCountTooSmall,

  /// The requested count does not fit in the remaining address bits.
  tooManySubnets,

  /// Anything unclassified.
  unknown,
}

/// Thrown by the domain when a calculation cannot be performed.
class AppException implements Exception {
  final AppError error;

  const AppException(this.error);

  @override
  String toString() => 'AppException(${error.name})';
}
