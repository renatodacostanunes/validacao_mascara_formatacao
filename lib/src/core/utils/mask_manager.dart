import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:utils_helpers_consts/src/core/consts/app_regex.dart';

class AppMask {
  AppMask._();

  static String cpf = '999.999.999-99';
  static String cnpj = '99.999.999/9999-99';
  static String phone = '(99) 9 9999-9999';
  static String date = '99/99/9999';
  static String cep = '99999-999';
}

class MaskManager {
  MaskManager._();

  static TextInputFormatter cpf() {
    return MaskTextInputFormatter(
      mask: AppMask.cpf,
      filter: {
        "9": RegExp(AppRegexp.digits),
      },
    );
  }

  static TextInputFormatter number() {
    return MaskTextInputFormatter(
      filter: {
        "9": RegExp(AppRegexp.digits),
      },
    );
  }

  static TextInputFormatter cnpj() {
    return MaskTextInputFormatter(
      mask: AppMask.cnpj,
      filter: {
        "9": RegExp(AppRegexp.digits),
      },
    );
  }

  static TextInputFormatter dynamicCpfOrCnpj(TextEditingController controller) {
    return DynamicCpfOrCnpjFormatter(controller, formatter: cpf());
  }

  static TextInputFormatter phone() {
    return MaskTextInputFormatter(
      mask: AppMask.phone,
      filter: {
        "9": RegExp(AppRegexp.digits),
      },
    );
  }

  static TextInputFormatter date() {
    return MaskTextInputFormatter(
      mask: AppMask.date,
      filter: {
        "9": RegExp(AppRegexp.digits),
      },
    );
  }

  static TextInputFormatter cep() {
    return MaskTextInputFormatter(
      mask: AppMask.cep,
      filter: {
        "9": RegExp(AppRegexp.digits),
      },
    );
  }

  // Não estão sendo utilizados no momento...

  // static String applyMaskCpf(String value) {
  //   MagicMask mask = MagicMask.buildMask(AppMask.cpf);
  //   return mask.getMaskedString(FormatterHelper.onlyDigits(value));
  // }

  // static String applyMaskCep(String value) {
  //   MagicMask mask = MagicMask.buildMask(AppMask.cep);
  //   return mask.getMaskedString(FormatterHelper.onlyDigits(value));
  // }

  // static String applyMaskPhoneWithDDD(String value) {
  //   MagicMask mask = MagicMask.buildMask(AppMask.phone);
  //   return mask.getMaskedString(FormatterHelper.onlyDigits(value));
  // }
}

class DynamicCpfOrCnpjFormatter extends TextInputFormatter {
  final TextEditingController controller;
  final TextInputFormatter formatter;

  DynamicCpfOrCnpjFormatter(this.controller, {required this.formatter});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final isCpf = newValue.text.replaceAll(RegExp(AppRegexp.onlyDigits), '').length <= 11;
    final mask = isCpf ? AppMask.cpf : AppMask.cnpj;
    controller.value = (formatter as MaskTextInputFormatter).updateMask(mask: mask);
    return formatter.formatEditUpdate(oldValue, newValue);
  }
}
