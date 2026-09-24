class Ipv4 {
  static int toInt(String ip) {
    final parts = ip.split('.');
    if (parts.length != 4) throw const FormatException('Invalid IPv4');
    int out = 0;
    for (final p in parts) {
      final n = int.tryParse(p);
      if (n == null || n < 0 || n > 255) throw const FormatException('Invalid octet');
      out = (out << 8) | n;
    }
    return out;
  }

  static String fromInt(int n) =>
    '${(n >> 24) & 0xff}.${(n >> 16) & 0xff}.${(n >> 8) & 0xff}.${n & 0xff}';

  static String netmask(int prefix) =>
    fromInt(prefix == 0 ? 0 : (0xFFFFFFFF << (32 - prefix)) & 0xFFFFFFFF);

  static String wildcard(int prefix) =>
    fromInt(prefix == 32 ? 0 : (1 << (32 - prefix)) - 1);

  static bool isPrivate(String ip) {
    final n = toInt(ip);
    return (n & 0xFF000000) == 0x0A000000 ||      // 10/8
           (n & 0xFFF00000) == 0xAC100000 ||      // 172.16/12
           (n & 0xFFFF0000) == 0xC0A80000 ||      // 192.168/16
           (n & 0xFF000000) == 0x7F000000;        // 127/8
  }

  static String ipClass(String ip) {
    final first = toInt(ip) >> 24;
    if (first < 128) return 'A';
    if (first < 192) return 'B';
    if (first < 224) return 'C';
    if (first < 240) return 'D';
    return 'E';
  }
}

({String ip, int prefix}) parseCidr(String input) {
  final s = input.trim();
  final slash = s.indexOf('/');
  if (slash < 0) throw const FormatException('Missing "/prefix"');
  final ip = s.substring(0, slash);
  final prefix = int.tryParse(s.substring(slash + 1));
  if (prefix == null || prefix < 0 || prefix > 32) {
    throw const FormatException('Prefix must be 0..32');
  }
  Ipv4.toInt(ip); // validates
  return (ip: ip, prefix: prefix);
}