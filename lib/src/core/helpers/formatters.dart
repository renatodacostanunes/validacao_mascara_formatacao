import 'package:intl/intl.dart';
import 'package:utils_helpers_consts/src/core/consts/app_regex.dart';

class Formatters {
  static int parseInt(dynamic value) {
    try {
      if (value == null) {
        return 0;
      }
      if (value is int) {
        return value;
      }
      if (value is String) {
        return int.parse(value);
      }
    } catch (_) {}
    return 0;
  }

  static String parseString(dynamic value) {
    try {
      if (value == null) {
        return '';
      }
      if (value is String) {
        return value;
      }
      if (value is double) {
        return value.toString();
      }
      if (value is int) {
        return value.toString();
      }
    } catch (_) {
      return '';
    }
    return '';
  }

  static double parseDouble(dynamic value) {
    if (value == null || value == '') {
      return 0;
    }
    if (value is String) {
      return double.parse(value);
    }
    if (value is double) {
      return value;
    }
    if (value is int) {
      return value.toDouble();
    }
    return 0;
  }

  static double parseMoneyMaskToDouble(String value) {
    String valueParsed = value.replaceAll('R\$ ', '');
    valueParsed = valueParsed.replaceAll('.', '');
    valueParsed = valueParsed.replaceAll(',', '.');
    return double.parse(valueParsed);
  }

  static bool parseBool(dynamic value) {
    if (value == null) {
      return false;
    }
    if (value is bool) {
      return value;
    }
    return false;
  }

  static String currency(dynamic value) {
    String currencySymbol = "R\$";

    if (value < 0) {
      value = -value;
      currencySymbol = "- R\$";
    }

    final formatter = NumberFormat("###,##0.00", "pt-br").format(value);
    return "$currencySymbol $formatter";
  }

  static String leadgindZero(String value, int quantity) {
    return value.padLeft(quantity, '0');
  }

  static String dateTimeToApiDate(DateTime? value) {
    if (value == null) {
      return '';
    }
    try {
      return '${DateFormat('yyyy-MM-ddTHH:mm:ss').format(value)}Z';
    } catch (e) {
      return '';
    }
  }

  static String dateToApiDate(DateTime? value) {
    if (value == null) {
      return '';
    }
    try {
      return DateFormat('yyyy-MM-dd').format(value);
    } catch (e) {
      return '';
    }
  }

  static DateTime? apiDateToDatetime(String? value) {
    if (value == null || value == '') {
      return null;
    }
    try {
      return DateFormat('yyyy-MM-dd').parse(value);
    } catch (e) {
      return null;
    }
  }

  static String dateTimeString(DateTime? value) {
    if (value == null) {
      return '';
    }
    try {
      return DateFormat('dd/MM/yyyy').format(value);
    } catch (e) {
      return '';
    }
  }

  static String extractNumbers(String value) {
    return value.replaceAll(RegExp(r'[^0-9]'), '');
  }

  static String formatCellPhone(String value) {
    if (value.contains(RegExp(AppRegexp.onlyDigits))) return '';
    return value.replaceAllMapped(RegExp(r'(\d{2})(\d{5})(\d+)'), (Match m) => "(${m[1]}) ${m[2]}-${m[3]}");
  }

  static String formatCellPhoneMasked(String value) {
    value = extractNumbers(value);
    if (value.length == 11) {
      return '(${value[0]}${value[1]}) *****-**${value[9]}${value[10]}';
    }
    return value;
  }

  static String formatEmailMasked(String value) {
    List<String> values = value.split('@');
    if (values.length > 1) {
      return '${values[0][0]}***@${values[1]}';
    }
    return value;
  }

  static String formatCep(String value) {
    if (value.length == 8) {
      return '${value[0]}${value[1]}${value[2]}${value[3]}${value[4]}-${value[5]}${value[6]}${value[7]}';
    }
    return value;
  }

  static String formatCPF(String value) {
    if (value.length == 11) {
      return '${value[0]}${value[1]}${value[2]}.${value[3]}${value[4]}${value[5]}.${value[6]}${value[7]}${value[8]}-${value[9]}${value[10]}';
    }
    return value;
  }

  static String formatCardNumber(String value) {
    if (value.length == 16) {
      return '${value[0]}${value[1]}${value[2]}${value[3]} ${value[4]}${value[5]}${value[6]}${value[7]} ${value[8]}${value[9]}${value[10]}${value[11]} ${value[12]}${value[13]}${value[14]}${value[15]}';
    }
    return value;
  }

  static String parseMapToString(Map<String, dynamic>? map) {
    if (map == null) return '';

    final StringBuffer sb = StringBuffer();
    map.forEach((key, value) {
      sb.write('$key: $value\n');
    });

    return sb.toString();
  }

  static String firstAndLastName(String name) {
    List<String> names = name.split(' ');

    if (names.length > 1) {
      return '${names.first} ${names.last}';
    } else {
      return name;
    }
  }
}
