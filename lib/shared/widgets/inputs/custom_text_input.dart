import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:zau_layer_first/app/theme/colors.dart";

class CustomTextInput extends StatelessWidget {
  final String inputLabel;
  final String inputHint;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter> inputFormatter;
  final FocusNode focusNode;
  final Function fieldSubmit;
  final Function validator;
  final bool isTextArea;
  final bool isRequired;
  final bool readOnly;
  final bool editMode;
  final bool withSuffixIcon;
  final bool isManualError;
  final bool alwaysFloatLabel;
  final Widget suffixIcon;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;

  const CustomTextInput({
    super.key,
    required this.inputLabel,
    required this.inputHint,
    required this.textEditingController,
    required this.keyboardType,
    required this.textInputAction,
    required this.focusNode,
    required this.fieldSubmit,
    required this.validator,
    this.inputFormatter = const [],
    this.isTextArea = false,
    this.isRequired = false,
    this.readOnly = false,
    this.editMode = true,
    this.withSuffixIcon = false,
    this.isManualError = false,
    this.alwaysFloatLabel = false,
    this.suffixIcon = const Icon(Icons.mail),
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      enabled: editMode,
      controller: textEditingController,
      keyboardType: isTextArea ? TextInputType.multiline : keyboardType,
      textInputAction: isTextArea ? TextInputAction.newline : textInputAction,
      minLines: isTextArea ? 4 : 1,
      maxLines: isTextArea ? 5 : 1,
      maxLength: isTextArea ? 450 : null,
      decoration: InputDecoration(
        filled: true,
        fillColor: editMode ? Colors.transparent : AppColor.colorMediumTint,
        isDense: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: isManualError ? AppColor.colorDanger : AppColor.colorMedium,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: isManualError ? AppColor.colorDanger : AppColor.colorMedium,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Color(0xFFC8C8C8),
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: isManualError ? AppColor.colorDanger : AppColor.colorMedium,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
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
        floatingLabelBehavior: alwaysFloatLabel
            ? FloatingLabelBehavior.always
            : FloatingLabelBehavior.auto,
        hintText: inputHint,
        hintStyle: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: AppColor.colorMedium),
        suffixIcon: withSuffixIcon ? suffixIcon : null,
      ),
      style: Theme.of(
        context,
      ).textTheme.bodySmall?.copyWith(color: AppColor.textColor),
      cursorColor: AppColor.textColor,
      focusNode: focusNode,
      inputFormatters: inputFormatter,
      onFieldSubmitted: (_) => fieldSubmit,
      onChanged: onChanged,
      validator: (value) {
        return validator(value);
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
