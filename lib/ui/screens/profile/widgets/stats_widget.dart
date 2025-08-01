import 'dart:io';
import 'package:duelduck_solana/data/repositories/models/user.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:duelduck_solana/ui/widgets/field/custom_text_field.dart';
import 'package:duelduck_solana/ui/widgets/text/custom_text.dart';
import 'package:duelduck_solana/utils/constants.dart';

class StatsWidget extends StatefulWidget {
  final User user;
  final Function(String) onSubmitted;
  const StatsWidget({super.key, required this.user, required this.onSubmitted});

  @override
  State<StatsWidget> createState() => _StatsWidgetState();
}

class _StatsWidgetState extends State<StatsWidget> {
  late User user;
  late TextEditingController _usernameController;

  XFile? _selectedAvatar;

  @override
  void initState() {
    super.initState();
    user = widget.user;
    _usernameController = TextEditingController(text: user.username);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          _buildAvatar(),
          SizedBox(height: 24),
          _buildUsernameField(onSubmitted: widget.onSubmitted),
          const SizedBox(height: 16),
          Row(
            children: [
              _builbStatsCard(
                title: "profile_screen_tab_stats_total_win".tr(),
                value: Row(
                  children: [
                    _buildUsdcIcon(),
                    const SizedBox(width: 12),
                    CustomText.basic(
                      text: "1562",
                      style: ProjectFonts.headerRegular,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _builbStatsCard(
                title: "profile_screen_tab_stats_my_fee".tr(),
                value: CustomText.basic(
                  text: "+1111",
                  style: ProjectFonts.headerRegular.copyWith(
                    color: ProjectColors.green,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _builbStatsCard(
                title: "profile_screen_tab_stats_duels_win".tr(),
                value: CustomText.basic(
                  text: "+1562",
                  style: ProjectFonts.headerRegular.copyWith(
                    color: ProjectColors.green,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              _builbStatsCard(
                title: "profile_screen_tab_stats_duels_lost".tr(),
                value: CustomText.basic(
                  text: "-1562",
                  style: ProjectFonts.headerRegular.copyWith(
                    color: ProjectColors.red,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          GestureDetector(
            onTap: () => _launchURL(),
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText.basic(
                  text: "profile_screen_tab_stats_about".tr(),
                  style: ProjectFonts.bodyMedium,
                ),
                Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    color: ProjectColors.greyBlack,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(ProjectSource.arrowRightTop),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildAvatar({String? avatarUrl}) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: ProjectColors.black,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: ClipOval(
            child:
                _selectedAvatar != null
                    ? Image.file(
                      File(_selectedAvatar!.path),
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    )
                    : avatarUrl != null && avatarUrl.isNotEmpty
                    ? Image.network(
                      avatarUrl,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return Container(
                          padding: EdgeInsets.all(13),
                          child: SvgPicture.asset(
                            ProjectSource.defaultDuckIcon,
                          ),
                        );
                      },
                    )
                    : Container(
                      padding: EdgeInsets.all(13),
                      child: SvgPicture.asset(ProjectSource.defaultDuckIcon),
                    ),
          ),
        ),
        GestureDetector(
          onTap: () => _onTapChooseMedia(),
          child: Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ProjectColors.primaryYellow,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(ProjectSource.uploadIcon),
          ),
        ),
      ],
    );
  }

  Future<void> _onTapChooseMedia() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedAvatar = picked;
      });
    }
  }

  _buildUsernameField({required Function(String) onSubmitted}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.basic(
          text: "profile_screen_tab_stats_field".tr(),
          style: ProjectFonts.bodyRegular.copyWith(color: ProjectColors.grey),
        ),
        const SizedBox(height: 8),
        CustomTextField.outline(
          controller: _usernameController,
          hint: "",
          maxLength: 17,
          onChanged: (name) {},
          onSubmitted: (name) => onSubmitted(name),
        ),
      ],
    );
  }

  _builbStatsCard({required String title, required Widget value}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ProjectColors.black,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText.basic(
              text: title,
              style: ProjectFonts.bodyRegular.copyWith(
                color: ProjectColors.grey,
              ),
            ),
            const SizedBox(height: 8),
            value,
          ],
        ),
      ),
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

  _launchURL() async {
    final uri = Uri.parse(ProjectConstants.duelduckUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch ${ProjectConstants.duelduckUrl}';
    }
  }
}
