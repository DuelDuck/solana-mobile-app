import 'package:duelduck_solana/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final int? maxLength;
  final String hint;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  const CustomTextField({
    super.key,
    required this.controller,
    this.maxLength,
    required this.hint,
    this.keyboardType,
    this.inputFormatters,
    required this.onChanged,
    required this.onSubmitted,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_update);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_update);
    super.dispose();
  }

  void _update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.controller,
          maxLength: widget.maxLength,
          style: const TextStyle(color: Colors.white),
          cursorColor: ProjectColors.primaryYellow,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          decoration: InputDecoration(
            counterText: '',
            hintText: widget.hint,
            hintStyle: ProjectFonts.bodyRegular.copyWith(
              color: ProjectColors.gradientGrey,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ProjectColors.primaryYellow,
                width: 2,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ProjectColors.gradientGrey,
                width: 2,
              ),
            ),
          ),
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
        ),
        const SizedBox(height: 8),
        if (widget.maxLength != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${widget.controller.text.length}',
                      style: ProjectFonts.bodySmall.copyWith(
                        color: ProjectColors.primaryYellow,
                      ),
                    ),
                    TextSpan(
                      text:
                          "/${widget.maxLength} ${"add_duel_screen_field_chars_counter".tr()}",
                      style: ProjectFonts.bodySmall.copyWith(
                        color: ProjectColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}
