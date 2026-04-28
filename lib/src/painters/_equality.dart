import '../models/section.dart';

/// Sub-pixel epsilon used for [listsEqualWithEpsilon]. Two doubles are
/// treated as equal if they differ by less than this amount.
const double _kPixelEpsilon = 0.5;

/// Compares two `double` lists by content with a sub-pixel epsilon.
///
/// Lists of different length are unequal. Empty lists are equal.
bool listsEqualWithEpsilon(List<double> a, List<double> b) {
  if (identical(a, b)) return true;
  if (a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if ((a[i] - b[i]).abs() >= _kPixelEpsilon) return false;
  }
  return true;
}

/// Compares two maps for value equality.
bool mapsEqual<K, V>(Map<K, V> a, Map<K, V> b) {
  if (identical(a, b)) return true;
  if (a.length != b.length) return false;
  for (final key in a.keys) {
    if (!b.containsKey(key) || a[key] != b[key]) return false;
  }
  return true;
}

/// Compares two `Section` lists by content.
bool sectionsEqual(List<Section> a, List<Section> b) {
  if (identical(a, b)) return true;
  if (a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
