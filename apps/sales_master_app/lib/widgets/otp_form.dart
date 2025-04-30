import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sales_master_app/config/constants.dart';
import 'package:sales_master_app/widgets/custom_textfield.dart';

class OtpInput extends StatelessWidget {
  final List<TextEditingController> controllers =
      List.generate(6, (_) => TextEditingController());

  OtpInput({super.key});

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.sizeOf(context).width -
            paddingOtpGap -
            (paddingBetweenOtp * 4) -
            (paddingXl * 2)) /
        6;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        return Padding(
          padding: EdgeInsets.only(
            right: index == 2 ? 15.0 : (index < 5 ? 5.0 : 0),
          ),
          child: SizedBox(
            height: 64,
            width: width,
            child: CustomTextFormField(
              controller: controllers[index],
              keyboardType: TextInputType.number,
              maxLength: 1,
              innerPadding: const EdgeInsets.symmetric(vertical: paddingXm),
              outlineColor:
                  Theme.of(context).colorScheme.onSecondaryFixedVariant,
              filled: true,
              fillColor: Theme.of(context).colorScheme.outlineVariant,
              textFormaters: [FilteringTextInputFormatter.digitsOnly],
              textAlign: TextAlign.center,
              onchanged: (value) {
                if (value != null && value.isNotEmpty && index < 5) {
                  FocusScope.of(context).nextFocus();
                }
                if (value != null && value.isEmpty && index > 0) {
                  FocusScope.of(context).previousFocus();
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
