import "package:zau_layer_first/shared/utils/helper.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:zau_layer_first/app/theme/colors.dart";

class CustomSearchInput extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onSubmitted;
  final GestureTapCallback? onTap;
  final bool readOnly;
  final bool autofocus;

  const CustomSearchInput({
    super.key,
    this.controller,
    this.onChange,
    this.onSubmitted,
    this.onTap,
    this.autofocus = true,
    this.readOnly = false,
  });

  @override
  State<CustomSearchInput> createState() => _CustomSearchInputState();
}

class _CustomSearchInputState extends State<CustomSearchInput> {
  bool searchKeywordExist = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.0,
      child: TextField(
        controller: widget.controller,
        key: const Key('searchInputBar'),
        readOnly: widget.readOnly,
        autofocus: widget.autofocus,
        textInputAction: TextInputAction.search,
        inputFormatters: [filterEmoji],
        style: const TextStyle(
          color: AppColor.textColor,
          fontSize: 14,
          fontWeight: FontWeight.normal,
          height: 1,
        ),
        decoration: InputDecoration(
          hintText: 'Mau cari produk apa?',
          contentPadding: const EdgeInsets.all(8),
          hintStyle: const TextStyle(
            color: AppColor.colorGrey,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: widget.readOnly
              ? null
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 6.0,
                  ),
                  child: SvgPicture.asset('assets/icons/search.svg'),
                ),
          suffixIcon: widget.readOnly
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 6.0,
                  ),
                  child: SvgPicture.asset('assets/icons/search.svg'),
                )
              : InkWell(
                  onTap: () {
                    if (searchKeywordExist) {
                      widget.controller!.text = "";
                      widget.onChange?.call("");
                      FocusManager.instance.primaryFocus?.unfocus();
                      setState(() {
                        searchKeywordExist = false;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 6.0,
                    ),
                    child: searchKeywordExist == true
                        ? SvgPicture.asset('assets/icons/close.svg')
                        : const SizedBox(),
                  ),
                ),
        ),
        onChanged: (value) {
          if (widget.controller!.text.isNotEmpty) {
            setState(() {
              searchKeywordExist = true;
            });
          } else {
            setState(() {
              searchKeywordExist = false;
            });
          }
          // EasyDebounce.debounce(
          //   'onChanged',
          //   const Duration(milliseconds: 500),
          //   () => widget.onChange?.call(value),
          // );
        },
        onSubmitted: widget.onSubmitted,
        onTap: widget.onTap,
      ),
    );
  }
}
