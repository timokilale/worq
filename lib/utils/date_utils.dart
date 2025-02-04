import 'package:intl/intl.dart';

DateTime strToDate(String source) => DateTime.parse(source);

String datePattern(DateTime date, String pattern) =>
    DateFormat(pattern).format(date);
