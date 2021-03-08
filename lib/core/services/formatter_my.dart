import 'package:roylen/core/services/formatter_abstract.dart';
import 'package:intl/intl.dart';

class MyFormatter extends AbstractFormatter {
  @override
  String formatDate(DateTime date, {bool withTime = true}) {
    String format = 'E d MMM yyyy';
    if (withTime) {
      format += ', HH:mm';
    }
    String parsedDate = DateFormat(format).format(date);
    return parsedDate;
  }
}
