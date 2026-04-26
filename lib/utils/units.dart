const double _mlPerOz = 29.5735;

String formatAmount(int ml, String unit) {
  if (unit == 'oz') return (ml / _mlPerOz).round().toString();
  return ml.toString();
}

String unitLabel(String unit) => unit;

int toMl(num value, String unit) {
  if (unit == 'oz') return (value * _mlPerOz).round();
  return value.toInt();
}
