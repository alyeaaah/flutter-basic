import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    super.key,
    required this.sourceData,
    required this.dropdownController,
    required this.selectedValue,
    required this.dropdownTitle,
    this.dropdownHint = 'Pilih',
    this.emptyAlertMessage = 'Harus dipilih',
    required this.onDropdownChanged,
  });

  final dynamic sourceData;
  final TextEditingController dropdownController;
  final dynamic selectedValue;
  final String dropdownTitle;
  final String dropdownHint;
  final String emptyAlertMessage;
  final void Function(Object?)? onDropdownChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(dropdownTitle, style: Theme.of(context).textTheme.bodySmall),
          DropdownButtonFormField(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Color.fromARGB(255, 206, 205, 205),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            isExpanded: true,
            isDense: true,
            hint: Text(
              dropdownHint,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            elevation: 0,
            initialValue: selectedValue,
            items: sourceData.map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                value: value.dropdownValue.runtimeType != String
                    ? value.dropdownValue.toString()
                    : value.dropdownValue,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    Text(value.dropdownLabel),
                    const SizedBox(height: 10),
                    const Divider(thickness: 3),
                  ],
                ),
              );
            }).toList(),
            selectedItemBuilder: (BuildContext context) {
              return sourceData.map<Widget>((value) {
                return Text(value.dropdownLabel);
              }).toList();
            },
            validator: (_) {
              if (!dropdownController.text.isNotEmpty) {
                return emptyAlertMessage;
              }

              return null;
            },
            onChanged: onDropdownChanged,
          ),
        ],
      ),
    );
  }
}
