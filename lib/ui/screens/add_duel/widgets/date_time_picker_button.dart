import 'package:duelduck_solana/ui/widgets/text/custom_text.dart';
import 'package:duelduck_solana/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DateTimePickerButton extends StatefulWidget {
  final Function(DateTime) onSelectedDate;
  const DateTimePickerButton({super.key, required this.onSelectedDate});

  @override
  State<DateTimePickerButton> createState() => _DateTimePickerButtonState();
}

class _DateTimePickerButtonState extends State<DateTimePickerButton> {
  DateTime? _selectedDateTime;

  void _pickDateTime() async {
    final DateTime now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime:
          _selectedDateTime != null
              ? TimeOfDay.fromDateTime(_selectedDateTime!)
              : TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    final combinedDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      _selectedDateTime = combinedDateTime;
      widget.onSelectedDate(combinedDateTime);
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('d MMM, h:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickDateTime,
      child: Container(
        decoration: BoxDecoration(
          color: ProjectColors.backgroundDark,
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText.basic(
              text:
                  _selectedDateTime != null
                      ? _formatDateTime(_selectedDateTime!)
                      : "add_duel_screen_date_time_picker_initial".tr(),
              style: ProjectFonts.bodyMedium.copyWith(
                color: ProjectColors.grey,
              ),
            ),
            const SizedBox(width: 12),
            SvgPicture.asset(ProjectSource.calendarIcon),
          ],
        ),
      ),
    );
  }
}
