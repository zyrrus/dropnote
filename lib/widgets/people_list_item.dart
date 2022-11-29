import 'package:dropnote/widgets/avatar_list_item.dart';
import 'package:flutter/material.dart';
import 'package:dropnote/models/user.dart';
import 'package:flutter_svg/svg.dart';

import '../theme.dart';

class PeopleListItem extends StatelessWidget {
  // Author: Otis Jackson IV

  // Attributes
  final bool isExpanded;
  final DNUser user;

  // Constructor
  const PeopleListItem(
      {super.key, required this.user, required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return isExpanded
        ? ExpandedPeople(
            name: user.name,
            school: user.school,
            profilePicture: user.profilePicture,
            numSaves: user.totalSaves ?? 0)
        : AvatarListItem(imageURL: user.profilePicture, label: user.name);
  }
}

class ExpandedPeople extends StatelessWidget {
  // Attributes
  final String name;
  final String school;
  final String profilePicture;
  final int numSaves;

  // Constructor
  const ExpandedPeople(
      {super.key,
      required this.name,
      required this.school,
      required this.profilePicture,
      required this.numSaves});

  @override
  Widget build(BuildContext context) {
    // Build Attributes
    String fileType = profilePicture.split('.').last;
    var UrlDisplay = (fileType == 'svg') ? SvgPicture.network : Image.network;

    // Render Method
    return Container(
      padding: EdgeInsets.symmetric(horizontal: DropNote.pagePadding),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: DropNote.pagePadding),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: DropNote.colors.grey,
            ),
            clipBehavior: Clip.antiAlias,
            child: UrlDisplay(
              profilePicture,
              width: 70.0,
              height: 70.0,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: DropNote.pagePadding, vertical: 7),
                      child: Text(name,
                          style: DropNote.textStyles.main(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    Row(
                      children: [
                        Text(
                          numSaves.toString(),
                          style: DropNote.textStyles.main(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(Icons.file_download_outlined),
                      ],
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: DropNote.pagePadding, vertical: 0),
                  child: Text(
                    school,
                    style: DropNote.textStyles.main(
                      fontSize: 18,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
