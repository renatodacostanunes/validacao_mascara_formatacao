import 'package:intl/intl.dart';

class DateHelper {
  DateHelper._();

  static String toDateDDmmYYYY(DateTime? date, {String separator = '/'}) {
    if (date == null) {
      return '';
    }
    return DateFormat("dd${separator}MM${separator}yyyy").format(date);
  }

  static String toDateDDmm(DateTime? date, {String separator = '/'}) {
    if (date == null) {
      return '';
    }
    return DateFormat("dd${separator}MM").format(date);
  }

  static String toDateDD(DateTime? date, {String separator = '/'}) {
    if (date == null) {
      return '';
    }
    return DateFormat("dd").format(date);
  }

  static String dateNow({String separator = '/'}) {
    return DateFormat("dd${separator}MM${separator}yyyy").format(DateTime.now());
  }

  static String toDateDDmmYYYYhhMM(DateTime? date, {String separator = '/'}) {
    if (date == null) {
      return '';
    }
    return DateFormat("dd${separator}MM${separator}yyyy HH:mm").format(date);
  }

  static String toDateDDmmYYYYhhMMss(DateTime? date, {String separator = '/'}) {
    if (date == null) {
      return '';
    }
    return DateFormat("dd${separator}MM${separator}yyyy HH:mm:ss").format(date);
  }

  static String toDateYYYYmmDD(DateTime? date, {String separator = '-'}) {
    if (date == null) {
      return '';
    }
    return DateFormat("yyyy${separator}MM${separator}dd").format(date);
  }

  static String toDateMMYYYY(DateTime? date, {String separator = '/'}) {
    if (date == null) {
      return '';
    }
    return DateFormat("MMMM yyyy", 'pt').format(date).toUpperCase();
  }

  static DateTime stringToDate(String date) {
    final separator = date.contains('/') ? '/' : '-';
    List<String> parts = date.split(separator);

    return DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );
  }

  static DateTime stringDateTimeToDate(String value) {
    return DateFormat('dd/MM/yyyy').parse(value);
  }

  static DateTime? stringToDateOrNull(String? date) {
    if (date == null || date.isEmpty) return null;

    return stringToDate(date);
  }

  static bool isEquals(DateTime date1, DateTime date2) {
    final compare1 = DateTime(date1.year, date1.month, date1.day);
    final compare2 = DateTime(date2.year, date2.month, date2.day);
    return compare1.compareTo(compare2) == 0;
  }

  static bool isMonthYearBefore(DateTime date1, DateTime date2) {
    return date1.year < date2.year || (date1.month < date2.month && date1.year == date2.year);
  }

  static String toSecondsFormatted(String second) {
    if (second.isEmpty) {
      return "00:00";
    }

    if (second.length == 1) {
      return "00:0$second";
    }

    if (second.length > 2) {
      return "00:00";
    }

    return "00:$second";
  }

  static bool isValid(String? value) {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    try {
      value = value?.trim().replaceAll(" ", "");
      final date = dateFormat.parse(value!);
      final originalFormatString = _toOriginalFormatString(date, false);

      return (value == originalFormatString) ? true : false;
    } catch (e) {
      return false;
    }
  }

  static String _toOriginalFormatString(DateTime dateTime, bool onlyMonthYear) {
    final y = dateTime.year.toString().padLeft(4, '0');
    final m = dateTime.month.toString().padLeft(2, '0');
    final d = dateTime.day.toString().padLeft(2, '0');
    if (onlyMonthYear) {
      return "$m/$y";
    } else {
      return "$d/$m/$y";
    }
  }

  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  static List<String> months = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro',
  ];
}
