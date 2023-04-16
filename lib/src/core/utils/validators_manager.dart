import 'package:flutter/widgets.dart';
import 'package:utils_helpers_consts/src/core/helpers/formatters.dart';

import '../consts/app_regex.dart';
import '../helpers/cnpj_validator.dart';
import '../helpers/cpf_validator.dart';
import '../helpers/date_helper.dart';

class Validators {
  Validators._();

  static FormFieldValidator<String> multiple(List<FormFieldValidator<String>> validators) {
    return (value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }

  static FormFieldValidator required(String message) {
    return (value) {
      if (value?.isEmpty ?? true) return message;
      return null;
    };
  }

  static FormFieldValidator name(String message) {
    return (value) {
      if (value != null) {
        List<String> nameSplited = value.trim().split(" ");
        if (nameSplited.length > 1) {
          if (nameSplited[0].length > 1 && nameSplited[1].length > 1) {
            return null;
          }
        }
      }
      return message;
    };
  }

  static FormFieldValidator<String> min(int min, String message) {
    return (value) {
      if (value?.isEmpty ?? true) return null;
      if ((value?.trim().length ?? 0) < min) return message;
      return null;
    };
  }

  static FormFieldValidator<String> max(int max, String message, bool canBeEmpty) {
    return (value) {
      if (value?.isEmpty ?? true) {
        return canBeEmpty ? null : 'Campo obrigatório';
      }
      if ((value?.trim().length ?? 0) > max) return message;
      return null;
    };
  }

  static FormFieldValidator isNotNull(String message, {dynamic object = -9999}) {
    return (value) {
      if (object != -9999) {
        if (object is Function) {
          return object() == null ? message : null;
        } else if (object is List) {
          return object.isEmpty ? message : null;
        } else if (object is Set) {
          return object.isEmpty ? message : null;
        } else {
          return object == null ? message : null;
        }
      } else {
        if (value == null || value?.toString().isEmpty == true) return message;
        return null;
      }
    };
  }

  static FormFieldValidator initialDate(String message, [TextEditingController? finalDateController]) {
    return (value) {
      if (finalDateController?.text.trim().isNotEmpty == true && (value ?? '').isNotEmpty) {
        final DateTime initialDate = DateHelper.stringToDate(value);
        final DateTime finalDate = DateHelper.stringToDate(finalDateController!.text.trim());

        if (finalDate.isBefore(initialDate)) {
          return message;
        }

        return null;
      } else {
        return null;
      }
    };
  }

  static FormFieldValidator finalDate(String message, [TextEditingController? initialDateController]) {
    return (value) {
      if (initialDateController?.text.trim().isNotEmpty == true && (value ?? '').isNotEmpty) {
        final DateTime initialDate = DateHelper.stringToDate(initialDateController!.text.trim());
        final DateTime finalDate = DateHelper.stringToDate(value);

        if (finalDate.isBefore(initialDate)) {
          return message;
        }

        return null;
      } else {
        return null;
      }
    };
  }

  static FormFieldValidator<String> date(String errorMessage) {
    return (value) {
      if (DateHelper.isValid(value)) {
        return null;
      }
      return errorMessage;
    };
  }

  static FormFieldValidator<String> number(String errorMessage) {
    return (v) {
      if (v?.isEmpty ?? true) return null;
      if (double.tryParse(v!) != null) {
        return null;
      } else {
        return errorMessage;
      }
    };
  }

  static FormFieldValidator maxDate(DateTime max, String message) {
    return (value) {
      if (value != null && (value as String).length == 10) {
        final currentDate = DateHelper.stringDateTimeToDate(value);
        if (currentDate.isAfter(max)) {
          return message;
        }
      }
      return null;
    };
  }

  static FormFieldValidator minDate(DateTime min, String message) {
    return (value) {
      if (value != null && (value as String).length == 10) {
        final currentDate = DateHelper.stringDateTimeToDate(value);
        if (currentDate.isBefore(min)) {
          return message;
        }
      }
      return null;
    };
  }

  static FormFieldValidator olderAge(String message, [int age = 18]) {
    return (value) {
      if (value != null && (value as String).length == 10) {
        final dateValue = DateHelper.stringDateTimeToDate(value);
        final isOlder = (DateTime.now().difference(dateValue).inDays / 365) >= age;
        if (!isOlder) {
          return message;
        }
      }
      return null;
    };
  }

  static FormFieldValidator compare(String message, [TextEditingController? compareDateController]) {
    return (value) {
      final String current = value?.trim() ?? '';
      final String reference = compareDateController?.text.trim() ?? '';

      if (current.isNotEmpty && reference.isNotEmpty) {
        if (current != reference) {
          return message;
        }

        return null;
      } else {
        return null;
      }
    };
  }

  static FormFieldValidator email(String message) {
    return (value) {
      if (value?.isEmpty ?? true) return message;
      return RegExp(AppRegexp.email).hasMatch(value) ? null : message;
    };
  }

  static FormFieldValidator cep(String message) {
    return (value) {
      if (value?.isEmpty ?? true) return message;
      return RegExp(AppRegexp.cep).hasMatch(value) ? null : message;
    };
  }

  static FormFieldValidator cnpj(String message) {
    return (value) {
      if (value?.isEmpty ?? true) return message;
      return CnpjValidator.isValid(value) ? null : message;
    };
  }

  static FormFieldValidator cpf(String message) {
    return (value) {
      if (value?.isEmpty ?? true) return message;
      return CpfValidator.isValid(value) ? null : message;
    };
  }

  static FormFieldValidator cpfOrCnpj(String message) {
    return (value) {
      if (value?.isEmpty ?? true) return message;
      return (_cleanValue(value).length <= 11) ? cpf(message).call(value) : cnpj(message).call(value);
    };
  }

  static FormFieldValidator cellPhoneWithDDD(String message) {
    return (value) {
      if (value?.isEmpty ?? true) return null;
      return RegExp(AppRegexp.dddCellPhone).hasMatch(value) ? null : message;
    };
  }

  static String _cleanValue(String? value) {
    return value?.replaceAll(RegExp(AppRegexp.onlyDigits), '') ?? '';
  }

  static FormFieldValidator validateSecurityCode(String message) {
    return (value) {
      if (value?.isEmpty ?? true) return message;
      return RegExp(AppRegexp.validateSecurityCode).hasMatch(value) ? null : message;
    };
  }

  static bool validateSequencePassword(String message) {
    for (int count = 0; count < message.length; count++) {
      bool sequence = false;
      bool sequence1 = false;
      if (count + 2 < message.length) {
        if (Formatters.parseInt(message[count]) == (Formatters.parseInt(message[count + 1]) - 1)) {
          sequence = true;
        }
        if (Formatters.parseInt(message[count + 1]) == (Formatters.parseInt(message[count + 2]) - 1)) {
          sequence1 = true;
        }
        if (sequence && sequence1) {
          return true;
        }
      }
    }
    return false;
  }

  static FormFieldValidator isPasswordValid(String message) {
    return (value) {
      return validateSequencePassword(value) ? message : null;
    };
  }

  static FormFieldValidator moneyMask(String message) {
    return (value) {
      if (value == null || value == '') {
        return message;
      }
      String valueParsed = value.replaceAll('R\$ ', '');
      valueParsed = valueParsed.replaceAll('.', '');
      valueParsed = valueParsed.replaceAll(',', '.');
      if (double.parse(valueParsed) <= 0) {
        return message;
      } else {
        return null;
      }
    };
  }
}
