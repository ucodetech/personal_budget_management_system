import 'package:intl/intl.dart';

String formatMoney(double amount) {
  final formatCurrency = NumberFormat.currency(locale: "en_US", symbol: "N");
  return formatCurrency.format(amount);
}

String formatDate(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final tomorrow = today.add(const Duration(days: 1));

  if (date.isAtSameMomentAs(today)) {
    return 'Today';
  } else if (date.isAtSameMomentAs(yesterday)) {
    return 'Yesterday';
  } else if (date.isAfter(today) && date.isBefore(tomorrow)) {
    return 'Tomorrow';
  } else if (date.isAfter(today)) {
    return DateFormat('dd/MM/yyyy').format(date);
  } else {
    final difference = today.difference(date).inDays;
    if (difference < 7) {
      return '${difference} days ago';
    } else {
      final weeks = (difference / 7).floor();
      return '$weeks weeks ago';
    }
  }
}