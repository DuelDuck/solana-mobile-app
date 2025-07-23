import 'dart:io';

import 'package:duelduck_solana/ui/screens/add_duel/widgets/date_time_picker_button.dart';
import 'package:duelduck_solana/ui/screens/add_duel/widgets/expandable_section.dart';
import 'package:duelduck_solana/ui/screens/add_duel/widgets/selectable_tabs.dart';
import 'package:duelduck_solana/ui/widgets/custom_text.dart';
import 'package:duelduck_solana/ui/widgets/custom_text_field.dart';
import 'package:duelduck_solana/ui/widgets/gradient_text.dart';
import 'package:duelduck_solana/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class AddDuelScreen extends StatefulWidget {
  const AddDuelScreen({super.key});

  @override
  State<AddDuelScreen> createState() => _AddDuelScreenState();
}

class _AddDuelScreenState extends State<AddDuelScreen> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _resolvesController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _commissionController = TextEditingController();

  XFile? _selectedQuestionImage;
  DateTime? _selectedDeadline;
  String? _selectedResolves;
  int? _selectedPrice;
  int? _selectedCommission;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  GradientText(
                    text: "add_duel_screen_header".tr().toUpperCase(),
                    textStyle: ProjectFonts.headerRegular.copyWith(
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ExpandableSection(
                    title: "add_duel_screen_item_question".tr(),
                    isFilled:
                        _questionController.text.isNotEmpty &&
                        _selectedQuestionImage != null,
                    child: _buildQuestionItem(),
                  ),
                  const SizedBox(height: 16),
                  ExpandableSection(
                    title: "add_duel_screen_item_deadline".tr(),
                    isFilled: _selectedDeadline != null,
                    child: _buildDeadlineItem(),
                  ),
                  const SizedBox(height: 16),
                  ExpandableSection(
                    title: "add_duel_screen_item_resolves".tr(),
                    isFilled: _selectedResolves != null,
                    child: _buildResolvesItem(),
                  ),
                  const SizedBox(height: 16),
                  ExpandableSection(
                    title: "add_duel_screen_item_price".tr(),
                    isFilled: _selectedPrice != null,
                    child: _buildPriceItem(),
                  ),
                  const SizedBox(height: 16),
                  ExpandableSection(
                    title: "add_duel_screen_item_commission".tr(),
                    isFilled: _selectedCommission != null,
                    child: _buildCommissionItem(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildQuestionItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.basic(
          text: "add_duel_screen_item_question_description".tr(),
          style: ProjectFonts.bodyRegular.copyWith(color: ProjectColors.grey),
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: _questionController,
          hint: "add_duel_screen_item_question_hint".tr(),
          maxLength: 85,
          onChanged: (text) {},
          onSubmitted: (text) => setState(() {}),
        ),
        _selectedQuestionImage == null
            ? GestureDetector(
              onTap: () => onTapChooseMedia(context),
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: SvgPicture.asset(ProjectSource.addImageIcon),
              ),
            )
            : Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    height: 85,
                    width: 75,
                    alignment: Alignment.centerLeft,
                    child: Image.file(
                      File(_selectedQuestionImage!.path),
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _removeImage,
                      child: Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          color: ProjectColors.greySecondary,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(ProjectSource.closeIcon),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      ],
    );
  }

  Future<void> onTapChooseMedia(BuildContext context) async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedQuestionImage = picked;
      });
    }
  }

  void _removeImage() {
    setState(() {
      _selectedQuestionImage = null;
    });
  }

  _buildDeadlineItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.basic(
          text: "add_duel_screen_item_question_description".tr(),
          style: ProjectFonts.bodyRegular.copyWith(color: ProjectColors.grey),
        ),
        const SizedBox(height: 16),
        DateTimePickerButton(
          onSelectedDate: (dateTime) {
            setState(() {
              _selectedDeadline = dateTime;
            });
          },
        ),
      ],
    );
  }

  _buildResolvesItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.basic(
          text: "add_duel_screen_item_question_description".tr(),
          style: ProjectFonts.bodyRegular.copyWith(color: ProjectColors.grey),
        ),
        const SizedBox(height: 16),
        SelectableTabs(
          tabs: [
            "add_duel_screen_item_resolves_you_tab".tr(),
            "add_duel_screen_item_resolves_duel_duck_tab".tr(),
          ],
          onTabSelected: (value) {
            setState(() {
              _selectedResolves = value;
            });
          },
        ),
        const SizedBox(height: 24),
        CustomText.basic(
          text: "add_duel_screen_item_resolves_duel_duck_description".tr(),
          style: ProjectFonts.bodyRegular.copyWith(color: ProjectColors.grey),
        ),
        const SizedBox(height: 16),
        if (_selectedResolves != null &&
            _selectedResolves ==
                "add_duel_screen_item_resolves_duel_duck_tab".tr())
          CustomTextField(
            controller: _resolvesController,
            hint: "add_duel_screen_item_resolves_duel_duck_hint".tr(),
            maxLength: 200,
            onChanged: (text) {},
            onSubmitted: (text) => setState(() {}),
          ),
      ],
    );
  }

  _buildPriceItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.basic(
          text: "add_duel_screen_item_question_description".tr(),
          style: ProjectFonts.bodyRegular.copyWith(color: ProjectColors.grey),
        ),
        const SizedBox(height: 16),
        SelectableTabs(
          tabs: ["2", "5", "10", "15", "20"],
          itemIcon: _buildUsdcIcon(),
          onTabSelected: (value) {
            setState(() {
              _selectedPrice = int.tryParse(value);
            });
          },
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Flexible(
              child: CustomTextField(
                controller: _priceController,
                hint: "add_duel_screen_item_price_hint".tr(),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                onChanged: (text) {},
                onSubmitted: (text) => setState(() {}),
              ),
            ),
            _buildUsdcIcon(),
          ],
        ),
      ],
    );
  }

  _buildUsdcIcon() {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ProjectColors.greyBorder,
      ),
      padding: EdgeInsets.all(3),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          SvgPicture.asset(ProjectSource.usdcIcon),
        ],
      ),
    );
  }

  _buildCommissionItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.basic(
          text: "add_duel_screen_item_question_description".tr(),
          style: ProjectFonts.bodyRegular.copyWith(color: ProjectColors.grey),
        ),
        const SizedBox(height: 16),
        SelectableTabs(
          tabs: ["2%", "5%", "7%", "10%"],
          onTabSelected: (value) {
            setState(() {
              _selectedCommission = int.parse(
                value.replaceAll(RegExp(r'\D'), ''),
              );
            });
          },
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Flexible(
              child: CustomTextField(
                controller: _commissionController,
                hint: "add_duel_screen_item_commission_hint".tr(),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                onChanged: (text) {},
                onSubmitted: (text) => setState(() {}),
              ),
            ),
            CustomText.basic(
              text: "%",
              style: ProjectFonts.bodyRegular.copyWith(
                color: ProjectColors.gradientGrey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
