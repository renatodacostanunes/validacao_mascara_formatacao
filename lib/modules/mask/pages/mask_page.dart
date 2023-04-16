import 'package:flutter/material.dart';
import 'package:utils_helpers_consts/src/core/helpers/date_helper.dart';
import 'package:utils_helpers_consts/src/core/helpers/formatters.dart';
import 'package:utils_helpers_consts/src/core/utils/mask_manager.dart';
import 'package:utils_helpers_consts/src/core/utils/validators_manager.dart';

import '../../../src/core/helpers/money_masked_text_controller.dart';

class MaskPage extends StatefulWidget {
  const MaskPage({super.key});

  @override
  State<MaskPage> createState() => _MaskPageState();
}

class _MaskPageState extends State<MaskPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController cellPhoneNumberController = TextEditingController();
  final MoneyMaskedTextController moneyMaskController = MoneyMaskedTextController(leftSymbol: 'R\$ ');
  DateTime dateTime = DateTime(1995, 05, 24, 17, 30);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                // TODO: Utilizado o packote MaskText mask_text_input_formatter
                inputFormatters: [MaskManager.cpf()],
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: Validators.multiple(
                  [
                    Validators.required('Campo obrigatório'),
                    Validators.cpf('CPF Inválido'),
                  ],
                ),
                controller: cpfController,
                decoration: const InputDecoration(hintText: 'Máscara de CPF'),
              ),
              const SizedBox(height: 48.0),
              TextFormField(
                inputFormatters: [MaskManager.phone()],
                validator: Validators.multiple(
                  [
                    Validators.required('Campo obrigatório'),
                    Validators.cellPhoneWithDDD('Número de celular inválido'),
                  ],
                ),
                controller: cellPhoneNumberController,
                decoration: const InputDecoration(hintText: 'Máscara número de celular'),
              ),
              const SizedBox(height: 48.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextFormField(
                      validator: Validators.moneyMask('Campo obrigatório'),
                      controller: moneyMaskController,
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    // Uma forma de pegar o valor como double
                    child: Text(Formatters.parseMoneyMaskToDouble(
                      moneyMaskController.value.text,
                    ).toStringAsFixed(2).toString()),
                  ),
                ],
              ),
              const SizedBox(height: 48.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    debugPrint('Todos campos estão válidos');
                    debugPrint(Formatters.formatCPF('36139891825'));
                  } else {
                    debugPrint('Um ou mais campos não é válido');
                  }
                },
                child: const Text('Validar campos'),
              ),
              const SizedBox(height: 48.0),
              Text(DateHelper.toDateDDmmYYYY(dateTime)),
              Text(DateHelper.toDateDD(dateTime)),
              Text(DateHelper.toDateDDmm(dateTime)),
              Text(DateHelper.toDateDDmmYYYYhhMM(dateTime)),
              Text('${DateHelper.stringToDate('24/05/1995')}'),
              Text(DateHelper.toSecondsFormatted('232')),
              Text(DateHelper.daysBetween(DateTime(2023, 04, 15), DateTime(2023, 04, 25)).toString()),
              Text(Formatters.currency(22222222)),
              Text(Formatters.formatCellPhone('11956521499')),
              Text(Formatters.formatCellPhoneMasked('11956521499')),
              Text(Formatters.formatEmailMasked('renato.nunes@rarolabs.com.br')),
            ],
          ),
        ),
      ),
    );
  }
}
