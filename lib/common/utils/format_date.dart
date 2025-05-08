import 'package:intl/intl.dart';

String formatDateTime(DateTime date) {
  final dateFormat = DateFormat('dd MMM yyyy');
  return dateFormat.format(date);
}
