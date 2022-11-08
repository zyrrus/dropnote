import 'package:dropnote/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingListItem extends StatelessWidget {
  final String label;
  final Widget? setting;
  final bool isSectionHeader;

  const SettingListItem({
    super.key,
    required this.label,
    this.setting,
    this.isSectionHeader = false,
  });

  @override
  Widget build(BuildContext context) {
    return isSectionHeader
        ? _ListHeader(label: label)
        : _ListItem(label: label, setting: setting);
  }
}

class _ListItem extends StatelessWidget {
  final String label;
  final Widget? setting;

  const _ListItem({super.key, required this.label, this.setting});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: DropNote.colors.disabled)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: DropNote.textStyles.setting()),
          if (setting != null) setting!,
        ],
      ),
    );
  }
}

class _ListHeader extends StatelessWidget {
  final String label;

  const _ListHeader({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 34.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: DropNote.textStyles.setting()),
        ],
      ),
    );
  }
}
