import 'package:intl/intl.dart';

class CustomFormatter {
  static String numberFormat(num value,
      {String? pattern = '#,##,##,##,##0.00'}) {
    final formatter = NumberFormat(pattern);
    return formatter.format(value);
  }

  static String compactFormattedNumber(String strNum, {String? pattern}) {
    final sanitizedNum = strNum.split('.').first.replaceAll(',', '');
    final numLength = sanitizedNum.length;
    if (numLength > 6 && numLength < 10) {
      final formattedNum = sanitizedNum.substring(0, numLength - 5);
      final decimal = sanitizedNum.substring(numLength - 5, numLength - 3);
      return '$formattedNum.$decimal M';
    } else if (numLength >= 10) {
      final formattedNum = sanitizedNum.substring(0, numLength - 7);
      final decimal = sanitizedNum.substring(numLength - 7, numLength - 5);

      return CustomFormatter.numberFormat(
          num.tryParse('$formattedNum.$decimal B') ?? 0,
          pattern: pattern);
    }

    return CustomFormatter.numberFormat(
        num.tryParse(strNum.replaceAll(',', '')) ?? 0,
        pattern: pattern);
  }

  static String compactFormattedNumberFromNum(num value, {String? pattern}) {
    return CustomFormatter.compactFormattedNumber(
        CustomFormatter.numberFormat(value, pattern: pattern),
        pattern: pattern);
  }
}
