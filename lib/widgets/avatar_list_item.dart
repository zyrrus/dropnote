import 'package:dropnote/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AvatarListItem extends StatelessWidget {
  final String imageURL;
  final String label;

  const AvatarListItem({
    super.key,
    required this.imageURL,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    String fileType = imageURL.split('.').last;
    var UrlDisplay = (fileType == 'svg') ? SvgPicture.network : Image.network;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: DropNote.colors.grey,
          ),
          clipBehavior: Clip.antiAlias,
          child: UrlDisplay(
            imageURL,
            width: 70.0,
            height: 70.0,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: 70.0,
          child: Text(
            label,
            style: DropNote.textStyles.main(fontSize: 10.0),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
