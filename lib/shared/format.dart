String compactNumber(int value) {
  if (value >= 1000000) {
    return '${(value / 1000000).toStringAsFixed(1).replaceAll('.', ',')} M';
  }
  if (value >= 10000) {
    return '${(value / 1000).round()} k';
  }
  if (value >= 1000) {
    return '${(value / 1000).toStringAsFixed(1).replaceAll('.', ',')} k';
  }
  return '$value';
}
