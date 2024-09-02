import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

export 'context_extension.dart';
export 'color_extension.dart';
export 'double_extension.dart';
export 'result.dart';
export 'go_router_extension.dart';
export 'decimal_text_input_formatter.dart';

String formatDate(DateTime date, {bool withTime = true}) {
  if (!withTime) return '${date.day}/${date.month}/${date.year}';
  return '${date.day}/${date.month}/${date.year} | ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}';
}

final currencyFormatter = CurrencyTextInputFormatter.currency(locale: 'es_CO', decimalDigits: 2, name: 'COP');

double getUnformattedCurrency(String value) {
  return double.tryParse(value.replaceAll('.', '').replaceAll(',', '.').replaceAll('COP', '').trim()) ?? 0.0;
}

String? Function(T? value) notZero<T>({String error = "Value must be different from zero"}) {
  return (value) {
    if (value == null) return error;
    if (value is num && value == 0) return error;
    return null;
  };
}

String? Function(T? value) notNegative<T>({String error = "Value must be greater or equal to zero"}) {
  return (value) {
    if (value == null) return error;
    if (value is num && value.isNegative) return error;
    return null;
  };
}
