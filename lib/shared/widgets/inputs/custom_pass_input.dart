import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:zau_layer_first/app/theme/colors.dart";

class CustomPassInput extends StatelessWidget {
  final String inputLabel;
  final String inputHint;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode focusNode;
  final Function onSuffixIconPressed;
  final Function fieldSubmit;
  final Function validator;
  final bool editMode;
  final bool alwaysFloatLabel;
  final bool isRequired;
  final ValueChanged<String>? onChanged;

  const CustomPassInput({
    super.key,
    required this.inputLabel,
    required this.inputHint,
    required this.textEditingController,
    required this.keyboardType,
    required this.textInputAction,
    required this.obscureText,
    required this.inputFormatters,
    required this.focusNode,
    required this.onSuffixIconPressed,
    required this.fieldSubmit,
    required this.validator,
    this.editMode = true,
    this.alwaysFloatLabel = false,
    this.isRequired = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: editMode,
      controller: textEditingController,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      decoration: InputDecoration(
        isDense: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: AppColor.colorMedium,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: AppColor.colorMedium,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: AppColor.colorMedium,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            style: BorderStyle.solid,
            color: AppColor.colorDanger,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.colorDanger,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        label: RichText(
          text: TextSpan(
            text: inputLabel,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColor.textColor),
            children: isRequired
                ? const [
                    TextSpan(
                      text: '*',
                      style: TextStyle(color: Colors.red),
                    ),
                  ]
                : [],
          ),
        ),
        labelStyle: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: AppColor.textColor),
        hintText: inputHint,
        hintStyle: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: AppColor.colorMedium),
        suffixIcon: IconButton(
          icon: Icon(
            (obscureText) ? Icons.visibility : Icons.visibility_off,
            color: AppColor.textColor,
          ),
          onPressed: () {
            onSuffixIconPressed();
          },
        ),
        floatingLabelBehavior: alwaysFloatLabel
            ? FloatingLabelBehavior.always
            : FloatingLabelBehavior.auto,
      ),
      style: Theme.of(
        context,
      ).textTheme.bodySmall?.copyWith(color: AppColor.textColor),
      cursorColor: AppColor.textColor,
      focusNode: focusNode,
      onChanged: onChanged,
      onFieldSubmitted: (_) => fieldSubmit,
      validator: (value) {
        return validator(value);
      },
    );
  }
}
